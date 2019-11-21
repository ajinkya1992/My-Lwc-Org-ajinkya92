({

    DeleteRow1 : function(component, event, helper){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
       component.getEvent("deletebooking").setParams({"indexVar" : component.get("v.rowIndex") }).fire();
    },

      calOnTabl  : function(component, event, helper){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
       component.getEvent("chkboxCal").fire();
    },
    
   /* firebookchkEvent : function(component, event, helper) {
       
        var eventCmp=component.getEvent("bookch");
	//	alert('child == '+component.find("chkbook").get("v.value"));
           eventCmp.setParams({
               "chkbooing1":component.find("chkbook").get("v.value")
           });    
            eventCmp.fire();
           
	}*/
  
})