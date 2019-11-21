({
	doAction : function(component, event, helper) {
		var aj=event.getParam('arguments');
        
        if(aj){
            var parm=aj.childparam;
            alert("parm"+parm)
            component.set("v.child",parm);
        }
	}
})