public with sharing  class AlterAmountEmployeeHandler extends TriggerHandler {
    public override void afterUpdate(){
      System.debug('AccountTriggerHandler afterUpdate Start');
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
                    Contact newContact = handleContact(cont);
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
    
    public static Contact handleContact(Contact cont)
    {
        for(integer i = 0; i < cont.Tasks_Monitor__r.size(); i++){
            decimal points = Math_Util.Fibonacci_Serie(cont.Tasks_Monitor__r[i].Difficulty_val__c);
            if(cont.Tasks_Monitor__r[i].Type__c == 'TO-DO'){
                if(cont.Tasks_Monitor__r[i].Due_Date__c <> null && cont.Tasks_Monitor__r[i].Due_Date__c < system.today())
                {//its overdue
                    cont.Points_Ammount__c -= points/2;
                }
                else{
                    cont.Points_Ammount__c += points;
                }
            }
            else //daily
                cont.Points_Ammount__c += points/2;
        }
        return cont;
    }
}