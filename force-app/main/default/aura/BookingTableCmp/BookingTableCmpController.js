({
    doInit : function(component, event, helper) {   
        var action=component.get("c.getAcc");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.wrpacc",response.getReturnValue()); 
              console.log('*****getAcc   ');
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    },
    
   
    checkAllCheckboxes : function(component, event, helper) {
        var checkboxes = component.find("checkbox");
         var checkboxes2 = component.find("checkbox22").get("v.value");
      
        if(checkboxes2 == true){
             for (var i = 0; i < checkboxes.length; i++){
            checkboxes[i].set("v.value",true);
        }
        }else{
              for (var i = 0; i < checkboxes.length; i++){
            checkboxes[i].set("v.value",false);
                  
        }
       }
    },
    showContact : function(component, event, helper) {
       
        var checkId = [];
        var checkAllId = JSON.stringify(component.get("v.wrpacc"));
      
        
        
        /*   if(!Array.isArray(checkAllId)){
            if (checkAllId.get("v.value") == true) {
                checkId.push(checkAllId.get("v.text"));
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
            for (var i = 0; i < checkAllId.length; i++) {
                if (checkAllId[i].get("v.value") == true) {
                    checkId.push(checkAllId[i].get("v.text"));
                }
            }
        }*/
        
        
        // var wrapperList = component.get("v.wrapperList");
          component.set("v.hideshow",false); 
        var action=component.get("c.showContacts");
        action.setParams({ "accWrapList" : checkAllId });
        
        
        // var action=component.get("c.showContacts1");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                if(response.getReturnValue().length<=0){
                     
                    alert("Select Atleast One Account");
                    
                }
                  console.log('*****   ');
                console.log(response.getReturnValue());
                component.set("v.wrapperConList",response.getReturnValue());
            }
            
        });
        $A.enqueueAction(action);
        
    },
    
    
    contchk: function(component, event) {
        var selected = event.getSource().get("v.text");
        alert("selected"+selected)
        component.set("v.ConId",selected); 
    },
    
    showBooking : function(component, event, helper) {
      
        var action=component.get("c.getBooking");
        var selected=component.get("v.ConId");
          var bookingList=JSON.stringify(component.get("v.wrapperBookingList"));
        if(selected== null){
            alert("Select Atleast One Contact");
            
        }else{ 
            action.setParams({ "allconBooktIdList" : selected});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
               component.set("v.wrapperBookingList",response.getReturnValue()); 
               alert("respo size=="+response.getReturnValue()); 
               console.log('*****   ');
                console.log(response.getReturnValue());
                /*var bList=component.get("v.wrapperBookingList");
                if(bList.length<=0){ 
                    alert("hiiiiiiiiiii"+bList.length); 
                    component.set("v.hideshow",true);
                   helper.addbookinghlp(component, event);
                    
                }else{
                   
                    component.set("v.hideshow",true);
                    component.set("v.wrapperBookingList",bList); 
                    
                }*/
                
            }
        });
            $A.enqueueAction(action);
        }
    },
    
    addbooking : function(component, event, helper){
        helper.addbookinghlp(component, event);
    },
   
    removebook: function(component, event, helper) {
        
        var index = event.getParam("indexVar");
        
        var AllRowsList = component.get("v.wrapperBookingList");
        AllRowsList.splice(index, 1);
        
        component.set("v.wrapperBookingList", AllRowsList);
        helper.Totalamt(component, event);
    },
    
    
     chkbooking: function(component, event, helper) {
        
        var index = event.getParam("chkbooing1");
         alert("index"+index);
        component.set("v.chkbok", index);
        
    },
    
    
    
    save: function(component, event, helper) {

        if (helper.validateRequired(component, event)) { 
            var action = component.get("c.saveBooking");
            var selected=component.get("v.ConId");
            
              var blist=JSON.stringify(component.get("v.wrapperBookingList"));
           
              alert('blist '+blist);
            action.setParams({
                "Listbook":blist, "ConId":selected
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                      alert('Record Save Successfully');
                       component.set("v.wrapperBookingList",response.getReturnValue());
                    //    helper.addbookinghlp(component, event);
                
                      helper.showToast(component, event);
                    
                }
            });
            
            $A.enqueueAction(action);
        }
    },
    
    
    calOnTabl: function(component, event, helper) {
     
        helper.Totalamt(component, event);
     
    }, 
    
    
})