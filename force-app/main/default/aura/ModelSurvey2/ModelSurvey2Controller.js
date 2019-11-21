({
    
    doInit : function(component, event, helper) {
          var action=component.get("c.getQuestionAnswer");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                var qList=response.getReturnValue();   
                component.set("v.QuestionList",qList);
            }
          
        });
          $A.enqueueAction(action);
    },
    
    
 OnCheckBox: function(component, event, helper) {
        component.set("v.hideshowMul",true); 
 var text=event.getSource().get("v.text");
     var action=component.get("c.getSubQAns");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                var qList=response.getReturnValue();  
                
                component.set("v.QuestionList",qList);
            }
          
        });
          $A.enqueueAction(action);
 },
})