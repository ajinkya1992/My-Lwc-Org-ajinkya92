({
    
    addbookinghlp : function(component, event){
        
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
      
   
	 validateRequired: function(component, event) {
         var isValid = true;
        var allContactRows = component.get("v.wrapperBookingList");
        for (var indexVar = 0; indexVar < allContactRows.length; indexVar++) {
            if (allContactRows[indexVar].book.Description__c == '' || allContactRows[indexVar].book.Amount__c == '' ) {
                isValid = false;
                alert('Row Number ' + (indexVar + 1) +' Data Fields Cant Blank !!');
            }
        }
        return isValid;
    },
  showToast : function(component, event) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
          "type": "success",
        "title": "Success!",
        "message": "The record has been Save successfully."
        
    });
    toastEvent.fire();
},

 /*   Totalamt: function(component, event) {
         var totalamt=0;
         var calamt=0;
         var amt=0;
        var calamt1=0; 
   //      var chkjjj = component.get("v.chkbok");
     //   alert("chkboxval "+chkjjj);
        var allContactRows = component.get("v.wrapperBookingList");
        for (var i = 0; i < allContactRows.length; i++) {   
            if(allContactRows[i].Amount__c=="") {
                allContactRows[i].Amount__c=0;
            }
            if ((allContactRows[i].Amount__c!= null) || (allContactRows[i].Amount__c !=0) || (allContactRows[i].Amount__c !="")) { 
                
                amt=  allContactRows[i].Amount__c;
                totalamt =parseFloat(totalamt)+parseFloat(amt); 
                allContactRows[i].Calculated__c=totalamt;
            }
            if(allContactRows[i].Amount__c ==0  ){
                calamt1=totalamt;
                amt=  allContactRows[i].Amount__c;
                calamt1 =parseFloat(totalamt)-parseFloat(amt);
                allContactRows[i].Calculated__c = calamt1;
            }
        }
        component.set("v.wrapperBookingList",allContactRows); 
    },  
    */
    
      Totalamt: function(component, event) {
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