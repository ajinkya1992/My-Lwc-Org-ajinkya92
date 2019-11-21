({
        doInit : function(component, event, helper) {
       /* var action = component.get("c.fetchUser");
        action.setCallback(this,function(response){
            var state=response.getState();
            //event.preventDefault(); 
            
            
            if(state == "SUCCESS"){
                
                var user=response.getReturnValue();
                console.log(user.Name);
                if(user.Name != 'Success Home Site Guest User')
                {
                    var homeEvent = $A.get("e.force:navigateToObjectHome");
                    homeEvent.setParams({
                        "scope": "Account"
                    });
                    homeEvent.fire();
                }
                else
                {
                    component.set("v.flag",true);
                }
               
                    
                }else if (state == "INCOMPLETE") {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Oops!",
                        "message": "No Internet Connection",
                        "type" : 'INCOMPLETE'
                    });
                    
                    toastEvent.fire();
                    //event.preventDefault(); 
                } else if (state == "ERROR") {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": "Please contact your administrator.",
                        "type" : 'Error'
                    });
                    toastEvent.fire();
                    // event.preventDefault(); 
                }
        });
        $A.enqueueAction(action);
        //}
        */
        
    },
      
    saveCase : function(component, event, helper) {
     
        var accName = component.find("accNameField").get("v.value");
        var description = component.find("description").get("v.value");
        var phoneField = component.find("phoneField").get("v.value");
        var approvalstatus = component.find("approvalstatus").get("v.value");
        var type = component.find("type").get("v.value");
        var Industry = component.find("industry").get("v.value");
        let recId=component.get("v.recordId");
       
        //var recId=component.get("v.recordId");
        
        //  alert('caseNameField  '+caseNameField+ "   caseEmailField   " +caseCompanyField +"  caseEmailField  "+email+"   casePhoneField   "+casePhoneField+"  caseSubField  "+caseSubField+"  severityField  "+severityField+"  caseSubField  "+caseSubField+"  caseDescField  "+caseDescField+"  recId  "+recId);
        
        var action = component.get("c.saveAccData");
        if(helper.caseValidation(component, event)){ 
          
            action.setParams({
                "accName":accName,
                "description" :description,
                "phoneField": phoneField,
                "approvalstatus":approvalstatus,
                "type":type,
                "Industry":Industry,
                "recId":recId
            });
            
            
            action.setCallback(this,function(response){
                var state=response.getState();
                event.preventDefault(); 
                
                
                if(state == "SUCCESS"){
                    
                    var workRId=response.getReturnValue();
                    console.log(workRId);
                    // component.set("v.recIdWorkId",workRId);
                    
                    
                    window.location.reload();
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "Record Save Successfully.",
                        "type" : 'Success'
                    });
                    toastEvent.fire();
                    
                    //event.preventDefault(); 
                       
                   // window.location.replace("https://ajinkya-92-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=Recent");
                    /* var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": recId,
                    "slideDevName": "detail"
                });
                navEvt.fire();*/
                
            }else if (state == "INCOMPLETE") {
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
          }
        
        
    }
})