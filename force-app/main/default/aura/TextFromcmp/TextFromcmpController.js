({
	fireComponentEvent : function(component, event, helper) {
       
        var eventCmp=component.getEvent("cmpEvent");
		alert('child == '+component.find("stopWord").get("v.value"));
           eventCmp.setParams({
               "message":component.find("stopWord").get("v.value")
           });    
            eventCmp.fire();
           
	}
})