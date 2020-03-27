public with sharing class HABIT_TASKController {
	@AuraEnabled
    public static void updateContactAmountOfPoints(String taskID,boolean addPoints) {
        // Check Contact fields that will be updated
    	String [] contactUpdateFields = new String [] {'Points_Ammount__c'};
        if( SecurityHandler.canUpdateContactFields(contactUpdateFields)){
            Contact cont = [SELECT Points_Ammount__c FROM Contact WHERE 
                            Id  IN (SELECT Contact__c FROM Task_Monitor__c 
                            where  Id = :taskID)];
            // I don't know why must be the assigment here.
            cont.Points_Ammount__c = addPoints ? ++cont.Points_Ammount__c : --cont.Points_Ammount__c; 
            update cont;      
        }
           
    }
}