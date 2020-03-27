({
	doInit: function(component, event, helper) {
        // Create the action to get daily and todo task
        var action = component.get("c.getDaily_AND_Todo_Tasks");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //Reduce result in TODO and Daliy arrays
                 let result = response.getReturnValue().reduce(function(arr, x) {
                    if (!arr[x["Type__c"]]) { arr[x["Type__c"]] = []; }
                    arr[x["Type__c"]].push(x);
                    return arr;
                  }, {});
                result.Daily !== undefined ? component.set("v.recordsDAILY",result["Daily"]) : component.set("v.recordsDAILY",[]);
                result["TO-DO"] !== undefined ?  component.set("v.recordsTODO",result["TO-DO"]): omponent.set("v.recordsTODO",[]);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
        
        // Create the action to get habit tasks
        var action = component.get("c.getHabit_Tasks");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.recordsHABIT",response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    handlingTaskEvent : function(component, event, helper) {
        //restart component doInit method
        $A.get('e.force:refreshView').fire();
	}
})