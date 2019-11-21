({
	
 init : function(component, event, helper) {
   
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__helloTarget',
            },
            state: {
                "c__first": "John"
            }
        };
      /*  component.set("v.pageReference", pageReference);
      if(component.get("v.page")!= null){
             var myPageRef = component.get("v.pageReference1");
        var firstname = myPageRef.state.c__first;
        component.set("v.firstname1", firstname);
           alert("myPageRe2   "+firstname)
         }*/
     },
    
      getdata: function(component, event, helper) {
        var myPageRef = component.get("v.page");
        var firstname = myPageRef.state.c__first;
        component.set("v.firstname1", firstname);
       
         alert("myPageRe2   "+firstname)
         
    },
    
    
     handleClick: function(component, event, helper) {
        var navService = component.find("navService");
        var pageReference = component.get("v.pageReference");
          
        event.preventDefault();
        navService.navigate(pageReference);
    },
    
     
})