@isTest
public class TestDashBoardComponent {
	 @isTest static void TestgetHabit_Tasks(){
        Id taskId;
         // Perform test
        Test.startTest();
         	taskId = TestDataFactory.insertTaskMonitor_Habit_New();
        Test.stopTest();
        // Verify 
         boolean res=false;
         for(Task_Monitor__c taskIterator : DashBoardController.getHabit_Tasks()){
             if(taskId == taskIterator.Id){
                 res = true;
             }
         }
         System.assert(res == true,'The data do not returned properly');
    }
    @isTest static void TestgetDaily_AND_Todo_Tasks(){
        
        Id taskId;
         // Perform test
        Test.startTest();
         	taskId = TestDataFactory.insertTaskMonitor_Daily_New();
        Test.stopTest();
        // Verify 
         boolean res=false;
         for(Task_Monitor__c taskIterator : DashBoardController.getDaily_AND_Todo_Tasks()){
             if(taskId == taskIterator.Id){
                 res = true;
             }
         }
         System.assert(res == true,'The data do not returned properly');
    }
	@isTest static void TestupdateContactAmountOfPoints(){
        Id contId;
         // Perform test
        Test.startTest();
        	contId = TestDataFactory.insertTaskMonitor_Habit_New_For_Contact();
        Test.stopTest();
        // Verify 
        Contact updatedCont= [Select Points_Ammount__c From Contact where Id = :contId];
        System.assert(updatedCont.Points_Ammount__c == 1,'The points not where added properlly');
    }
}