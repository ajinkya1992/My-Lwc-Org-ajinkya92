({
    createButtonDynamically : function(component, event, helper) {
        var db=component.find("newtag");
        
        $A.createComponent("ui:button", {
            "label":"New Button"+db.get("v.body").length,
            
            "press": component.getReference("c.showPressedButtonLabel")
        }, 
                           function attachModal(modalCmp, status) {
                        //var container = component.find("container");
                        if (component.isValid() && status === 'SUCCESS') {
                            var body = component.get("v.body");
                            body.push(modalCmp);
                            component.set("v.body", body);    
                        }
                               
                               /*if (status === "SUCCESS") {
                                   
                                   var bdy=db.get("v.body");
                                   
                                   bdy.push(dynamicButton);
                                   
                                   db.set("v.body",bdy);
                                   
                               }*/
                               
                               else if (status === "INCOMPLETE") {
                                   
                                   console.log("No response from the server!")
                                   
                               }
                               
                                   else if (status === "ERROR") {
                                       
                                       console.log("Error: " +errorMessage);
                                       
                                   }
                               
                           });
        
        
    },
    
    removeButtonDynamically : function(component, event, helper){
        
        component.find("newtag").set("v.body",[]);
        
        //Destroying the component dynamically.
        
    },
    
    showPressedButtonLabel : function(component, event, helper){
        
        alert('You pressed:'+event.getSource().get("v.label"));
        
    }
})