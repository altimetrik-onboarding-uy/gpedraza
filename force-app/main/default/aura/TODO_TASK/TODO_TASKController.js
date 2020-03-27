({
	
    saveRecord: function (component, event, helper) {
        component.find('edit').submit();
    },

    handleLoad: function (component,event) {
        var recUi = event.getParam("recordUi");
        // Get current value of State__c field
       	let state = recUi.record.fields["State__c"].value;
        if(state=="Completed")
        {
            var hideTask = component.getEvent("hideTask");
            hideTask.setParams({ id: component.get("v.recordId")});
            hideTask.fire(); 
        }
    }
})