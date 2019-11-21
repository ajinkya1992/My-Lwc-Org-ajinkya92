({
    navToRecord : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.recordId")
        });
        navEvt.fire();
    },
    editRecord : function(component, event, helper) {
        helper.showHide(component);
    },
    handleSuccess : function(component, event, helper) {
       
        var FirstName = component.find("FirstName").get("v.value");
        var LastName = component.find("LastName").get("v.value");
        var Email1 = component.find("Email2").get("v.value");
        var recordId =  component.get("v.recordId");
        var action = component.get("c.saveRegStud");
        
        action.setParams({
            "FirstName":FirstName,
            "LastName": LastName,
            "email":Email1,
            "recordId": recordId
        });
        action.setCallback(this,function(response){
            var state=response.getState();
        
            if(state == "SUCCESS"){
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Record Save Successfully.",
                    "type" : 'Success'
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
       // helper.showHide(component);
    },
    handleCancel : function(component, event, helper) {
        helper.showHide(component);
        //event.preventDefault();
    }
})