@isTest
private class TestResetTasks {
    // Dummy CRON expression: almost midnight every day.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 59 23 * * ? *';
    static testmethod void testScheduledJob() {
        
        Test.startTest();
         	List<Id> tasksIds = TestDataFactory.insertTaskMonitorOfType_Habit_Daily_Not_New_For_Contact(149,50);
            // Schedule the test job
            String jobId = System.schedule('ScheduledApexTest',
                                           CRON_EXP, 
                                           new ResetDailyHabitTasks());         
        Test.stopTest();
        // Now that the scheduled job has executed,
        // check that our tasks were created
        List<Task_Monitor__c> lt = [SELECT Id,State__c 
              FROM Task_Monitor__c 
              WHERE Id IN :tasksIds];
        System.assertEquals(tasksIds.size(), lt.size(), 'Tasks were not created');
        List <Task_Monitor__c> resultTask= [Select Id From Task_Monitor__c where Id IN :tasksIds and State__c ='New' ];
        System.assertEquals(tasksIds.size(), resultTask.size(), 'Tasks states where not updated');
    }
}