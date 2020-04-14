@isTest
public class TestDataFactory {
	
    public static Id insertTaskMonitor_Habit_New (){
        Contact cont = new Contact(LastName = 'Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name = 'Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Habit',
                                                   State__c = 'New');
        Database.SaveResult result = Database.insert(task, false);
        return task.Id;
    }
    
    public static Id insertTaskMonitor_Daily_New (){
        Contact cont = new Contact(LastName = 'Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name = 'Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Daily',
                                                   State__c = 'New');
        Database.SaveResult result = Database.insert(task, false);
        return task.Id;
    }
    
    public static Id insertTaskMonitor_Habit_New_For_Contact (){
        Contact cont = new Contact(LastName = 'Last Name Test',Points_Ammount__c = 0);
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name ='Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Habit',
                                                   State__c = 'New');
        Database.SaveResult result = Database.insert(task, false);
        HABIT_TASKController.updateContactAmountOfPoints(task.Id, true);
        return cont.Id;
    }
    
    public static Id dataFor_TestUpdateTODOType(){
        // Test data setup
        // Create a contact and test the task is created properly and the contact amaunt is updated
        Contact cont = new Contact(LastName ='Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name ='Task1',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'TO-DO',
                                                   State__c = 'Completed');
        Database.SaveResult result = Database.insert(task, false);
        return cont.Id;
    }
    public static Id dataFor_TestTO_DO_Overdue(){
        // Test data setup
        // Create a contact and test the task is created properly and the contact amaunt is updated
        Contact cont = new Contact(LastName ='Last Name Test');
        insert cont;
         Task_Monitor__c task = new Task_Monitor__c(Name = 'Task',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Due_Date__c = Date.today().addDays(-1),
                                                   Type__c = 'TO-DO',
                                                   State__c = 'Completed');
        Database.SaveResult result = Database.insert(task, false);
        return cont.Id;
    }
    
    public static Id dataFor_TestUpdateDailyType(){
        // Test data setup
        // Create a contact and test the task is created properly and the contact amaunt is updated
        Contact cont = new Contact(LastName ='Last Name Test');
        insert cont;
        Task_Monitor__c task = new Task_Monitor__c(Name = 'Task1',
                                                   Contact__c = cont.Id,
                                                   Difficulty__c = 'Hard',
                                                   Type__c = 'Daily',
                                                   State__c = 'Completed');
        Database.SaveResult result = Database.insert(task, false);
        return cont.Id;
    }
	
    
    public static List<Id> insertTaskMonitorOfType_Habit_Daily_Not_New_For_Contact(integer numberOfHabits, integer numberOfDaily){
        
        Contact cont = new Contact(LastName ='Last Name Test');
        List<Task_Monitor__c> tasks = new List<Task_Monitor__c>();
		insert cont;        
        for(integer i=0; i < numberOfHabits; i++){
            Task_Monitor__c taskHabit;
            if(math.mod(i, 2) == 0)
            	taskHabit = new Task_Monitor__c(Name ='Task' + i,
                                           Contact__c = cont.Id,
                                           Type__c = 'Habit',
                                           State__c = 'Completed',
                                           Habit_Complete__c = true);
            else
               taskHabit = new Task_Monitor__c(Name ='Task' + i,
                                          Contact__c = cont.Id,
                                          Type__c = 'Habit',
                                          State__c = 'In Progress',
                                          Habit_Complete__c = false);
            tasks.add(taskHabit);
        }
        for(integer i=0; i < numberOfDaily; i++){
            Task_Monitor__c taskDaily;
            if(math.mod(i, 2) == 0)
            	taskDaily = new Task_Monitor__c(Name ='Task',
                                                Contact__c =cont.Id,
                                                Difficulty__c ='Hard',
                                                Type__c ='Daily',
                                                State__c ='Completed');
            else
               taskDaily = new Task_Monitor__c(Name ='Task',
                                                   Contact__c =cont.Id,
                                                   Difficulty__c ='Hard',
                                                   Type__c ='Daily',
                                                   State__c ='In Progress');
            tasks.add(taskDaily);
        }
        
        insert tasks;
        
        // Get the IDs just inserted
        Map<Id, Task_Monitor__c> tasksMap = new Map<Id, Task_Monitor__c>(tasks);
        List<Id> tasksIds = new List<Id>(tasksMap.keySet());
        return tasksIds;
    }

}