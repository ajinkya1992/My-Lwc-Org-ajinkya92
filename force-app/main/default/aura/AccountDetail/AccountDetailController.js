({
    doInit : function(component, event, helper) {
		//alert('akki');
	},
    
    
	save : function(component, event, helper) {
		  var nameId = component.find("nameId").get("v.value");
          var LnameId = component.find("LnameId").get("v.value");
          var AddressId = component.find("AddressId").get("v.value");
          var phnId = component.find("phnId").get("v.value");
        
       
        
        
         var action=component.get("c.saveAcc");
         action.setParams({ "nameId" : nameId,
                           "LnameId" : LnameId,
                           "AddressId" : AddressId,
                           "phnId" : phnId
                          
                          });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                alert("RECORD SAVE SUCCESSFULLU!!")
               // component.set("v.wrpacc",response.getReturnValue()); 
              
            }
            if(state==="ERROR"){
                alert("RECORD FAIL TO SAVE!!")
               // component.set("v.wrpacc",response.getReturnValue()); 
              
            }
        });
        $A.enqueueAction(action);
        
	}
})