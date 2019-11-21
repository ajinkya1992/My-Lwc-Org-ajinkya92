({
   doInit : function(component, event, helper) {   
         
   },
    
     onChange: function (cmp, evt, helper) {
        alert(cmp.find('mySelect').get('v.value'));
    },
	loadOptions: function (component, event, helper) {
       var action=component.get("c.getPicklistFieldValues");
           action.setParams({ "recId" :component.get("v.recordId") });
      
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
             var cerList=[];   
               
           var contObj=response.getReturnValue(); 
               
                for (var i = 0; i < contObj.length; i++){
                    cerList.push({"Name":contObj[i].Name,"Id":contObj[i].Id});
                    // cerList.push(contObj[i].Certification__r.Id);
                }
               
                 component.set("v.options",cerList);
                
            }
            
        });
        $A.enqueueAction(action);
 
    }
})