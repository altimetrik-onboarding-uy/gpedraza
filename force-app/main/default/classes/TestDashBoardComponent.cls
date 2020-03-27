@isTest
public class TestDashBoardComponent {
	 @isTest static void TestgetHabit_Tasks(){
        Contact cont = new Contact(LastName = 'Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name = 'Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Habit',
                                                   State__c = 'New');
         // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(task, false);
        Test.stopTest();
        // Verify 
         boolean res=false;
         for(Task_Monitor__c taskIterator : DashBoardController.getHabit_Tasks()){
             if(task.Id == taskIterator.Id){
                 res = true;
             }
         }
         System.assert(res == true,'The data do not returned properly');
    }
    @isTest static void TestgetDaily_AND_Todo_Tasks(){
        Contact cont = new Contact(LastName = 'Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name = 'Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Daily',
                                                   State__c = 'New');
         // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(task, false);
        Test.stopTest();
        // Verify 
         boolean res=false;
         for(Task_Monitor__c taskIterator : DashBoardController.getDaily_AND_Todo_Tasks()){
             if(task.Id == taskIterator.Id){
                 res = true;
             }
         }
         System.assert(res == true,'The data do not returned properly');
    }
	@isTest static void TestupdateContactAmountOfPoints(){
        Contact cont = new Contact(LastName='Last Name Test',Points_Ammount__c = 0);
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name ='Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Habit',
                                                   State__c = 'New');
         // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(task, false);
         HABIT_TASKController.updateContactAmountOfPoints(task.Id, true);
        Test.stopTest();
        // Verify 
        Contact updatedCont= [Select Points_Ammount__c From Contact where Id = :cont.Id];
        System.assert(updatedCont.Points_Ammount__c == 1,'The points not where added properlly');
    }
}