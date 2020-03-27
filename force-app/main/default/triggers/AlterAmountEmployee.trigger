// calculate the points amounts of the employees
// Trigger is launched before process builder
trigger AlterAmountEmployee on Task_Monitor__c ( after update) {
	// do bulk operetions
	List<Contact> conts = new List<Contact>();
    // Check Contact fields that will be updated
    String [] contactUpdateFields = new String [] {'Points_Ammount__c'};
    // Check Task_Monitor fields that will be updated
    String [] tasktAccesFields = new String [] {'State__c','Type__c'};
    if(Math_Util.runOnce()  && SecurityHandler.canUpdateContactFields(contactUpdateFields) 
       && SecurityHandler.canAccesTask_MonitorFields(tasktAccesFields))
    {
        try{
            for(Contact cont : [SELECT Id, Points_Ammount__c, (Select Points_Awarded__c,
                                                               Due_Date__c,
                                                               Difficulty_val__c,
                                                               Type__c from Tasks_Monitor__r
                                                               where State__c = 'Completed'
                                                                AND Type__c <> 'Habit' AND
                                                               Id IN :Trigger.New) FROM Contact
                                WHERE 
                                Id  IN (SELECT Contact__c FROM Task_Monitor__c 
                                     where State__c = 'Completed'
                                    AND Type__c <> 'Habit' AND Id IN :Trigger.New)])
            {
                decimal oldAmount = cont.Points_Ammount__c;
                Contact newContact = AlterAmountEmployeeHandler.handleContact(cont);
                if(oldAmount <> newContact.Points_Ammount__c)
                	conts.add(cont);  
            }
     		update conts;
        }
        catch(System.Exception e){
            System.debug(e.getMessage());
        }
    }
}