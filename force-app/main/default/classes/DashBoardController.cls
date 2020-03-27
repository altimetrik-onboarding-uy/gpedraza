public with sharing class DashBoardController {
	@AuraEnabled
    public static List<Task_Monitor__c> getDaily_AND_Todo_Tasks() {
        // Check Task_Monitor fields that will be updated
    	String [] tasktAccesFields = new String [] {'State__c','Type__c'};
        if(SecurityHandler.canAccesTask_MonitorFields(tasktAccesFields))
        	return [SELECT Id, State__c,Type__c FROM Task_Monitor__c where State__c <> 'Completed' and Type__c <> 'Habit'];
        return new List<Task_Monitor__c>();
    }
     
    @AuraEnabled
    public static List<Task_Monitor__c> getHabit_Tasks() {
        String [] tasktAccesFields = new String [] {'Id'};
        if(SecurityHandler.canAccesTask_MonitorFields(tasktAccesFields))
        	return [SELECT Id FROM Task_Monitor__c where Type__c ='Habit'];
        return new List<Task_Monitor__c>();
    }
}