({
	doInit : function(component, event, helper) { 
        
        var demList={'Name':'raju','Region':['nagpur','bhandara','gujrat']};
       /*	 for(var j  in demList.Region ){
            alert(demList.Region[j]);
        }*/
        
          component.set("v.DemoList",demList);
        
        
         var carList={'Name':'Home','Country':[
             {'state':'maharashtra','city':['nagpur','pune','mumbai']},
              {'state':'gujrat','city':['nagpur','pune','mumbai']},
              {'state':'goa','city':['nagpur','pune','mumbai']},
              {'state':'kerla','city':['nagpur','pune','mumbai']}
            
            
         ]};
        
          component.set("v.carList",carList);
         for(var j  in carList.Country ){
             for(var i  in carList.Country[j].city){
                 //alert('State '+carList.Country[j].state+" city "+carList.Country[j].city[i]);
                
             }
        }
        
       /* var action=component.get("c.getPRojectWithChild");
        action.setParams({ "recId" :component.get("v.recordId") });     
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                component.set("v.DemoList",response.getReturnValue());
                 console.log("response****** ");
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);*/
        
        
       
    },
      onControllerFieldChange: function(component, event, helper) {     
          var controllerValueKey = event.getSource().get("v.value");
     //m alert(controllerValueKey);
      }
})