({
   init: function(cmp, evt, helper) {
       var myPageRef = cmp.get("v.pageReference");
        var firstname = myPageRef.state.c__first;
        cmp.set("v.firstname", firstname);
       
         alert("myPageRe2   "+firstname)
    },
    
    
    handleClick: function(component, event, helper) {
     var ajinkya=   component.get("v.firstname");
       var page = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__hello',
            },
            state: {
                "c__second": ajinkya
            }
        };
        component.set("v.page", page);
       
        var navService = component.find("navService");
        var page = component.get("v.page");
           alert("pageReference1"+page)
        event.preventDefault();
        navService.navigate(page);
        
    },
    
   
    
})