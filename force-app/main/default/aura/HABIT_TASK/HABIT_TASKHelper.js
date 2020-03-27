({
	updateContactPoints : function(component, addPoints) {
        let taskId = component.get("v.recordId");
        let action = component.get("c.updateContactAmountOfPoints");
        action.setParams({ taskID : taskId, addPoints: addPoints });
		// Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let label = component.find("messageResult");
                addPoints ? component.set("v._label", 'Task accomplished') :  component.set("v._label", 'Task failed');
                $A.util.toggleClass(label,'slds-hide');
                window.setTimeout(
                    $A.getCallback(function() {
                        $A.util.toggleClass(label,'slds-hide');
                    }), 1000
                );
              
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
	}
})