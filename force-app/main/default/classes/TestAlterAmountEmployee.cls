@isTest
private class TestAlterAmountEmployee {
	@isTest static void TestUpdateTODOType() {
      
         Id contId;
        // Perform test
        Test.startTest();
        	contId = TestDataFactory.dataFor_TestUpdateTODOType();
        Test.stopTest();
        // Verify 
       
        Contact test_cont = ([SELECT Points_Ammount__c from Contact where Id = :contId Limit 1]);
        System.assert(test_cont.Points_Ammount__c == 5);
    }
    @isTest static void TestTO_DO_Overdue() {
         Id contId;
        // Perform test
        Test.startTest();
        	contId = TestDataFactory.dataFor_TestTO_DO_Overdue();
        Test.stopTest();
        // Verify 
       
        Contact test_cont = ([SELECT Points_Ammount__c from Contact where Id = :contId Limit 1]);
        System.assert(test_cont.Points_Ammount__c == -2.5);
    }
    @isTest static void TestUpdateDailyType() {
        Id contId;
        // Perform test
        Test.startTest();
            contId = TestDataFactory.dataFor_TestUpdateDailyType();
        Test.stopTest();
        // Verify 
       
        Contact test_cont = ([SELECT Points_Ammount__c from Contact where Id = :contId Limit 1]);
        System.assert(test_cont.Points_Ammount__c == 2.5);
    }
}