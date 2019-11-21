({
	 doInit : function(component, event, helper) {   
        var action=component.get("c.showContacts");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.wrapperConList",response.getReturnValue()); 
                
            }
        });
        $A.enqueueAction(action);
        
    },
    
    contchk : function(component, event, helper) {
       var selected = event.getSource().get("v.text");
        alert("selected"+selected)
        component.set("v.ConId",selected); 
        
    },
    
    showBooking : function(component, event, helper) {
       
        var ConId=component.get("v.ConId");
      var action=component.get("c.showbooking");
         action.setParams({ "ConId" : ConId});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
               //  component.set("v.hideshow",false); 
               component.set("v.wrapperBookingList",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
        
    },
    
    
     addbooking : function(component, event, helper){
         var book = component.get("v.wrapperBookingList");
	        var len = book.length;
	        book.push({
                'srNo':'0'+len,
	            'Description__c':'',
	            'Amount__c':0.0,
               
	            'Calculated__c':0.0  
	        }); 
	        component.set("v.wrapperBookingList",book);
    },
   
    DeleteRow1: function(component, event, helper) {
        
      var index = event.getParam("indexVar");
        
        var AllRowsList = component.get("v.wrapperBookingList");
        AllRowsList.splice(index, 1);
        
        component.set("v.wrapperBookingList", AllRowsList);
       /* var totalamt=0;
         var calamt=0;
         var amt=0;
        var calamt1=0; 
        
        var allContactRows = component.get("v.wrapperBookingList");
        for (var i = 0; i < allContactRows.length; i++) {
           
            if (allContactRows[i].isselectbook== true) {
                amt=  allContactRows[i].book.Amount__c;                    
                totalamt =parseFloat(totalamt)+parseFloat(amt); 
                allContactRows[i].book.Calculated__c=totalamt;            
                calamt1  =   allContactRows[i].book.Calculated__c;
            }
            if(allContactRows[i].isselectbook ==false){
                calamt1=totalamt;
                amt=  allContactRows[i].book.Amount__c;
                calamt1 =parseFloat(totalamt)-parseFloat(amt);
             
                allContactRows[i].book.Calculated__c=calamt1;
            }
        }
          component.set("v.wrapperBookingList",allContactRows); */
    },
    
    
     chkbooking: function(component, event, helper) {
        
        var index = event.getParam("chkbooing1");
         alert("index"+index);
        component.set("v.chkbok", index);
        
    },
    
    
    calOnTabl: function(component, event, helper) {
        
        var totalamt=0;
         var calamt=0;
         var amt=0;
        var calamt1=0; 
        
        var allContactRows = component.get("v.wrapperBookingList");
        for (var i = 0; i < allContactRows.length; i++) {
           
            if (allContactRows[i].isselectbook== true) {
                amt=  allContactRows[i].book.Amount__c;                    
                totalamt =parseFloat(totalamt)+parseFloat(amt); 
                allContactRows[i].book.Calculated__c=totalamt;            
                calamt1  =   allContactRows[i].book.Calculated__c;
            }
            if(allContactRows[i].isselectbook ==false){
                calamt1=totalamt;
                amt=  allContactRows[i].book.Amount__c;
                calamt1 =parseFloat(totalamt)-parseFloat(amt);
             
                allContactRows[i].book.Calculated__c=calamt1;
            }
        }
          component.set("v.wrapperBookingList",allContactRows); 

        
    },
})