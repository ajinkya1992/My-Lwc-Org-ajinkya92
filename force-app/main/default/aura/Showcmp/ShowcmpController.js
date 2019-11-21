({
	    handleComponentEvent : function(component, event) {
        var message = event.getParam("message");
        
        alert("In Parant=== "+message);
        //alert(message);
        var action =component.get("c.getCompair");
        action.setParams({ "textarea" :message });
        
        action.setCallback(this,function(response){
            
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.messageFromEvent",response.getReturnValue());
                component.set("v.isStatusTrue",true);
                alert('retun value--'+response.getReturnValue());
                
            }
        });
        $A.enqueueAction(action);
        
    }
})