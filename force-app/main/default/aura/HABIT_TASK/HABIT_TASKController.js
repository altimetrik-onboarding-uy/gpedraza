({
    addPoints: function(component, event, helper) {
        helper.updateContactPoints(component,true);  
	},
    removePoints: function(component, event, helper) {
		helper.updateContactPoints(component,false);
	},
})