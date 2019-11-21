({
    doInit : function(component, event, helper) { 
        var action=component.get("c.getPRojectWithChild");
        action.setParams({ "recId" :component.get("v.recordId") });     
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                component.set("v.DemoList",response.getReturnValue());
                 console.log("response****** ");
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
        
        // get the fields API name and pass it to helper function  
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var objDetails = component.get("v.objDetail");
        // call the helper function
        helper.fetchPicklistValues(component,objDetails,controllingFieldAPI, dependingFieldAPI);     
        
        
    },
    
    
    onControllerFieldChange: function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value

        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        
        if (controllerValueKey != '--- None ---') {
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            
            if(ListOfDependentFields.length > 0){
                component.set("v.bDisabledDependentFld" , false);  
                helper.fetchDepValues(component, ListOfDependentFields);    
            }else{
                component.set("v.bDisabledDependentFld" , true); 
                component.set("v.listDependingValues", ['--- None ---']);
            }  
            
        } else {
            component.set("v.listDependingValues", ['--- None ---']);
            component.set("v.bDisabledDependentFld" , true);
        }
    },
    removeRow: function(component, event, helper) {
        
        var index = event.target.id;
        alert(index)
        var AllRowsList = component.get("v.DemoList");
        AllRowsList.splice(index, 1);
        
        component.set("v.DemoList", AllRowsList);
        //  helper.Totalamt(component, event);
    },
    addbooking : function(component, event){
        
        var book = component.get("v.DemoList");
        var len = book.length;
        book.push({
            'srNo':'0'+len,
            'Name':'',
            'Active__c':'',
            'Region__c':'',
            'Zone__c':''
            
        }); 
        component.set("v.DemoList",book);
    },
    handleSave:function(component,event,helper)
    {
        
        var checkAllId = JSON.stringify(component.get("v.DemoList"));
        console.log(checkAllId);
        alert(checkAllId)
        var action=component.get("c.CreateChildRecord");
        action.setParams({ 
            "WrapperString" : checkAllId,
            "recId" :component.get("v.recordId") 
        });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            alert(state);
            if(state==="SUCCESS"){
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "The record has been Save successfully."
                    
                });
                toastEvent.fire();
                //  window.location.reload();
            }
            
        });
        $A.enqueueAction(action);
        
        
        
        
    },
    
    
})