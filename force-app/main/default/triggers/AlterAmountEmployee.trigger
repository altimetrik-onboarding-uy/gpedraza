// calculate the points amounts of the employees
// Trigger is launched before process builder
trigger AlterAmountEmployee on Task_Monitor__c ( after update) {
	// do bulk operetions
	List<Contact> conts=new List<Contact>();
    if(Math_Util.runOnce())
    {
        try{
        for(Contact cont : [SELECT Id, Points_Ammount__c, (Select Points_Awarded__c,
                                                           Due_Date__c,
                                                           Difficulty_val__c,
                                                           Type__c from Tasks_Monitor__r
                                                           where State__c='Completed'
                                							AND Type__c<>'Habit' AND
                                                           Id IN :Trigger.New) FROM Contact
                            WHERE 
                            Id  IN (SELECT Contact__c FROM Task_Monitor__c 
                                 where State__c='Completed'
                                AND Type__c<>'Habit' AND Id IN :Trigger.New)])
        {
            System.debug('tasks amount ' + cont.Tasks_Monitor__r.size());
            decimal oldAmount=cont.Points_Ammount__c;
            for(integer i =0;i<cont.Tasks_Monitor__r.size();i++){
                System.debug('contact data ' + cont);
                System.debug('contact data ' + cont.Tasks_Monitor__r[i]);
                decimal points = Math_Util.Fibonacci_Serie(cont.Tasks_Monitor__r[i].Difficulty_val__c);
                if(cont.Tasks_Monitor__r[i].Type__c=='TO-DO'){
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
            System.debug('Amount: ' + cont.Points_Ammount__c);
            System.debug('Add contact');
            if(oldAmount <> cont.Points_Ammount__c)
            conts.add(cont);  
        }
        System.debug('Update contact');
            
     	update conts;
    }
    catch(System.Exception e){
        System.debug(e.getMessage());
    }
    }
    
    
}