({
    doInit : function(component, event, helper) {   
        var action=component.get("c.getRecId");
           action.setParams({ "recId" :component.get("v.recordId") });
      
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
             var cerList=[];   
               
           var contObj=response.getReturnValue(); 
              
                 component.set("v.myRecordId",contObj);
                
            }
            
        });
        $A.enqueueAction(action);   
   },
	 handleUploadFinished: function (component, event) {
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");        
        var documentId = uploadedFiles[0].documentId;
      
          var action=component.get("c.saveFileInAcc");
           action.setParams({ "myRecordId" :component.get("v.myRecordId"),
                             "recordId": component.get("v.recordId")
                            });
      
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
 
               alert("Record save");
              
            }
            
        });
        $A.enqueueAction(action);
         
    }
})