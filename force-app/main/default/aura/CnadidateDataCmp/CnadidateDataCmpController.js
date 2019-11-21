({
	 doInit: function(component , event, helper) {
      var recId=component.get("v.recordId");
             var action1 = component.get("c.getCont");
        action1.setParams({
            "oppId":recId
        });
        
        action1.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
               alert(data);
                component.set('v.ContactList',data);
            }
        });
        $A.enqueueAction(action1);
        
    },

    handleSubmit: function(cmp, event, helper) {
          var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been created as new version.",
                    "type": 'success'
                });
                toastEvent.fire();
        //cmp.set('v.disabled', true);
     //   cmp.set('v.showSpinner', true);
    },

    handleError: function(cmp, event, helper) {
        // errors are handled by lightning:inputField and lightning:nessages
        // so this just hides the spinnet
       // cmp.set('v.showSpinner', false);
    },

    handleSuccess: function(cmp, event, helper) {
        var WraperContlist = cmp.get("v.ContactList");
        alert("WraperContlist"+WraperContlist);
     
    },
   onNewVesr: function(component, event, helper) {
       var phn=component.find("phn").get("v.value");
        var accId=component.find("accId").get("v.value");
        var email=component.find("email").get("v.value");
       alert(phn)
       alert(accId)
       alert(email)
       

        var WraperContlist = component.get("v.ContactList");
        alert("ContactList"+WraperContlist.length);
       for(var i= -1;i<WraperContlist.length;i++){
           alert("innn")
           WraperContlist[i].acc.Phone=phn;
           WraperContlist[i].acc.AccountId=accId;
           WraperContlist[i].acc.Email=email;
           alert("WraperContlist 1"+WraperContlist);
       }
        console.log("WraperContlist 2");
       console.log(WraperContlist);
         //component.set("v.ContactList",WraperContlist);
      
      },
    
    
})