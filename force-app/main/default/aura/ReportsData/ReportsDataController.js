({
	 doInit: function(component, event, helper) {
  //call apex class method
   var action = component.get('c.reportData');
   action.setCallback(this,function(response){
  //store state of response
    var state = response.getState();
      if (state === "SUCCESS") {
      var data=    response.getReturnValue();
          console.log("data "+ data)
  //set response value(map) in myMap attribute on component.
    component.set('v.myMap',response.getReturnValue());
   }
});
   $A.enqueueAction(action);
},
})