({
    doInit:function(component, event, helper) {
          var recordId1= component.get("v.recordId");
        component.set("v.recordId", recordId1);
    },
    
    addProd : function(component, event, helper) {
        var recordId1= component.get("v.recordId");
        var relatedOpp = component.find("opportunity").get("v.value");
        var productName = component.find("prodName").get("v.value");
        var prodQuantity = component.find("quantity").get("v.value");
        var salesPrice = component.find("salesPrice").get("v.value");
        var serviceDate = component.find("date").get("v.value");
        var description= component.find("description").get("v.value");

        
        var flag =  helper.caseValidation(component, event);
       alert('--' + flag);
        if(flag){   
        var action2 = component.get("c.getProduct");
         action2.setParams({
             "recordId" : recordId1,
             "relatedOppId" : relatedOpp,
             "productName" : productName,
             "prodQuantity" : prodQuantity,
             "salesPrice" : salesPrice,
             "description" : description,
             "serviceDate": serviceDate
        });
        alert('action2-->>'+action2);
        action2.setCallback(this, function(response) {
            alert('response.getState()-->>'+response.getState());
            var state=response.getState();
            if(state==="SUCCESS"){
                alert('succsess');
            }
            //  component.set("v.recTypeLable", response.getReturnValue());
        });
      $A.enqueueAction(action2); 
      
    }
    }

 })