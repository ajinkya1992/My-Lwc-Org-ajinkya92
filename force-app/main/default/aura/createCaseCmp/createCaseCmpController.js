({
doInit : function(component, event, helper) {
        //   alert('111111111');
        var action=component.get("c.getPickListValuesIntoList");
        //  alert(action);
        action.setCallback(this,function(response){
            
            var state=response.getState();
            //   alert(state);
            if(state==="SUCCESS"){
                
                //    alert(response.getReturnValue());
                var arr=response.getReturnValue();
                var arr1=[];
                for(var i=0; i<response.getReturnValue().length; i++) {
                    var myObj = {
                        'label':arr[i],
                        'value':arr[i]
                    };
                    arr1.push(myObj);
                }  
                component.set("v.options",arr1);
            }
        });  
        $A.enqueueAction(action);
    },
   
    
    saveCase : function(component, event, helper) {
       
           
        if(helper.caseValidation(component, event)){
             let recId=component.get("v.recordId");
            var newcse = component.get("v.newCase");
            var action = component.get("c.saveCaseData");
           
            action.setParams({"cse": newcse, "recId":recId});
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var name = response.getReturnValue();
                       var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "Record Save Successfully.",
                        "type" : 'Success'
                    });
                    toastEvent.fire();
                }
                else if (state == "INCOMPLETE") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Oops!",
                    "message": "No Internet Connection",
                    "type" : 'INCOMPLETE'
                });
                
                toastEvent.fire();
                event.preventDefault(); 
            } else if (state == "ERROR") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "message": "Please contact your administrator.",
                    "type" : 'Error'
                });
                toastEvent.fire();
                event.preventDefault(); 
            }
            });
            $A.enqueueAction(action);
           window.location.reload();  
        }
        
    }
})