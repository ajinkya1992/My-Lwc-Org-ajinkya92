({
	 init: function(cmp, evt, helper) {
        var myPageRef = cmp.get("v.pageReference");
        var firstname = myPageRef.state.c__firstname;
        cmp.set("v.firstname", firstname);
    },
   
     handleClick: function(component, event, helper) {
       var sushant=  component.get("v.firstname");
         component.find("navService").navigate({
            type: "standard__component",
            attributes: {
                componentName: "c__nav1" },
            state: {
                c__firstname1: sushant
            } 
        }, true);
    },
     updateName: function(cmp, event, helper) {
        var nameInput = cmp.find("nameInput");
        var newName = nameInput.get("v.firstName");
        var myPageRef = cmp.get("v.pageReference");
        var newState = Object.assign({}, myPageRef.state, {c__firstname: newName});
        cmp.find("navService").navigate({
            type: myPageRef.type,
            attributes: myPageRef.attributes,
            state: newState
        });
    },
    onPageReferenceChanged: function(cmp, event, helper) {
        var myPageRef = cmp.get("v.pageReference");
        var firstname = myPageRef.state.c__firstname;
        cmp.set("v.firstname", firstname);
    }
    
})