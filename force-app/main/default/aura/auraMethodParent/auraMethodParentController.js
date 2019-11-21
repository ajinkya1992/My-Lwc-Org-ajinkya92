({
	calltochild : function(component, event, helper) {
		   var index = component.find("aurachild");
      
        component.set("v.child1", component.get('v.child1')+1);
        index.chldmethod(component.get("v.child1"));
      },
    
   calltoParent : function(component, event, helper) {
	        component.set("v.parent", component.get('v.parent')+1);
      }, 
    
})