//Reset the states of daily and habit task and add the resulted points to the employee
global class ResetDailyHabitTasks implements Schedulable {
    global void execute(SchedulableContext ctx) {
        
        try{
             List<Contact> conts= new List<Contact>();//Not work ask why
             List<Task_Monitor__c> toUpdateTasks= new List<Task_Monitor__c>();//Not work ask why
           for(Contact cont : [SELECT Id, Points_Ammount__c, //Select contacts with daily and habit tasks
                            	(Select 
                                 State__c, Type__c, Habit_Complete__c,
                                 Difficulty_val__c, Points_Awarded__c
                                 from Tasks_Monitor__r where  Type__c <>'TO-DO') 
                               FROM Contact where Id  IN (SELECT Contact__c FROM Task_Monitor__c 
                               where  Type__c <>'TO-DO')])
            {
                //Calcule the points and update the 
                for(integer i = 0; i < cont.Tasks_Monitor__r.size(); i++){
                    Task_Monitor__c task = cont.Tasks_Monitor__r[i];
                    if(task.Type__c == 'Daily'){
                        if(task.State__c=='Completed'){
                            cont.Points_Ammount__c += task.Points_Awarded__c;
                        }
                        else{
                             //Calculate the fibonacci result with auxiliary class
                             cont.Points_Ammount__c -= Math_Util.Fibonacci_Serie(task.Difficulty_val__c)/2;
                        }
                    }
                    else{ //Habit
                        if(task.Habit_Complete__c)
                            cont.Points_Ammount__c += task.Points_Awarded__c;
                        else
                            cont.Points_Ammount__c -= task.Points_Awarded__c;                        
                    }
                   
                    //always reset the state
                    if(task.State__c <> 'New')
                    	task.State__c = 'New';
                    
                    toUpdateTasks.add(task);
                }
                 conts.add(cont);
            }
            update toUpdateTasks;
            update conts;   
        }
        catch(System.Exception ex){
            System.debug(ex.getMessage());
        }
    }
}