({
	 init : function(component, event, helper) {
       
         
        
         
     },
     handleClick: function(component, event, helper) {
         component.find("navService").navigate({
            type: "standard__component",
            attributes: {
                componentName: "c__nav2" },
            state: {
                c__firstname: "ajinkya"
            } 
        }, true);
        
         
    },
    handleClick1: function(component, event, helper) {
         var myPageRef = component.get("v.pageReference");
        var firstname = myPageRef.state.c__firstname1;
        component.set("v.firstname1", firstname);
    }
})