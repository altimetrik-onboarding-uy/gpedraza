@isTest
private class TestAlterAmountEmployee {
	@isTest static void TestUpdateTODOType() {
        // Test data setup
        // Create a contact and test the task is created properly and the contact amaunt is updated
        Contact cont = new Contact(LastName ='Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name ='Task1',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'TO-DO',
                                                   State__c = 'Completed');
         
        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(task, false);
        Test.stopTest();
        // Verify 
       
        System.assert(result.isSuccess());
        Contact test_cont = ([SELECT Points_Ammount__c from Contact where Id =: cont.Id Limit 1]);
        System.assert(test_cont.Points_Ammount__c == 5);
    }
    @isTest static void TestTO_DO_Overdue() {
        // Test data setup
        // Create a contact and test the task is created properly and the contact amaunt is updated
        Contact cont = new Contact(LastName ='Last Name Test');
        insert cont;
         Task_Monitor__c task2 = new Task_Monitor__c(Name = 'Task2',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Due_Date__c = Date.today().addDays(-1),
                                                   Type__c = 'TO-DO',
                                                   State__c = 'Completed');
        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(task2, false);
        Test.stopTest();
        // Verify 
       
        System.assert(result.isSuccess());
        Contact test_cont = ([SELECT Points_Ammount__c from Contact where Id =: cont.Id Limit 1]);
        System.assert(test_cont.Points_Ammount__c == -2.5);
    }
    @isTest static void TestUpdateDailyType() {
        // Test data setup
        // Create a contact and test the task is created properly and the contact amaunt is updated
        Contact cont = new Contact(LastName ='Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name = 'Task1',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Daily',
                                                   State__c = 'Completed');
        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(task, false);
        Test.stopTest();
        // Verify 
       
        System.assert(result.isSuccess());
        Contact test_cont = ([SELECT Points_Ammount__c from Contact where Id =: cont.Id Limit 1]);
        System.assert(test_cont.Points_Ammount__c == 2.5);
    }
}