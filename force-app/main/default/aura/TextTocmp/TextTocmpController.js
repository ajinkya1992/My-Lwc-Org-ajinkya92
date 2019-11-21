({
	Doinit : function(component, event, helper) {
		// $A.enqueueAction(component.get('c.bar'));
	 component.reusableMethod = function(attribute){
           console.log(attribute);
          alert(attribute)
      }
	},
   action1: function action1(component) {
    component.reusableMethod('action1'); 
},
action2: function action2(component) {
    component.reusableMethod('action2'); 
}
   
})