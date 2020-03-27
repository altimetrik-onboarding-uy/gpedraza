public with sharing  class AlterAmountEmployeeHandler {
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