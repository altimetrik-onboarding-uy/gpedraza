@isTest
private class TestResetTasks {
    // Dummy CRON expression: almost midnight every day.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 59 23 * * ? *';
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        Contact cont = new Contact(LastName ='Last Name Test');
        List<Task_Monitor__c> tasks = new List<Task_Monitor__c>();
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name ='Task',
                                                   Contact__c =cont.Id,
                                                   Difficulty__c ='Hard',
                                                   Type__c ='Daily',
                                                   State__c ='Completed');
        Task_Monitor__c task1 = new Task_Monitor__c(Name ='Task1',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c ='Hard',
                                                   Type__c ='Daily',
                                                   State__c ='In Progress');
        
        Task_Monitor__c task2 = new Task_Monitor__c(Name ='Task2',
                                                   Contact__c = cont.Id,
                                                   Type__c = 'Habit',
                                                   State__c = 'Completed',
                                                   Habit_Complete__c = true);
        
         Task_Monitor__c task3 = new Task_Monitor__c(Name = 'Task3',
                                                   Contact__c = cont.Id,
                                                   Type__c = 'Habit',
                                                    State__c = 'Completed',
                                                   Habit_Complete__c = false);
        
        tasks.add(task);
        tasks.add(task1);
        tasks.add(task2);
        tasks.add(task3);
        insert tasks;

        // Get the IDs of the opportunities we just inserted
        Map<Id, Task_Monitor__c> tasksMap = new Map<Id, Task_Monitor__c>(tasks);
        List<Id> tasksIds = new List<Id>(tasksMap.keySet());
        Test.startTest();
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