({
    doInit : function(component, event, helper) {   
        var action=component.get("c.getAccndopp ");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                var allDetailsMap=response.getReturnValue();
                
                var expCatList= allDetailsMap['AccWrp'];
                component.set("v.AccWrp",expCatList);
                
            }
        });
        $A.enqueueAction(action);
    
        setTimeout(function(){ 
            $('.datatbleId').DataTable( {
                responsive: true
            } );
            
        }, 600);
    },
    scriptsLoaded : function(component, event, helper) {
        console.log('Script loaded..'); 
    },
    onExpCatPrevAction : function(component, event, helper) {
        var cont = component.find('accounthide');
        $A.util.removeClass(cont, 'slds-hide');
        $A.util.addClass(cont, 'slds-show');
         var acchide = component.find('expCatDivId');
        $A.util.removeClass(acchide, 'slds-show');
        $A.util.addClass(acchide, 'slds-hide'); 
    },
    
     onCancelAction: function(component, event, helper) {
        window.location.reload();
    },
    showContacts : function(component, event, helper) {
     
         setTimeout(function(){ 
            $('.datatbleId2').DataTable( {
                responsive: true
            } );
            
        }, 600);
        var checkId = [];
        var checkAllId = JSON.stringify(component.get("v.AccWrp"));
      
        var action=component.get("c.getCont");
        action.setParams({ "accWrapList" : checkAllId });
       
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                if(response.getReturnValue().length<=0){
                     
                    alert("Select Atleast One Account");
                    
                }
             var contObj=response.getReturnValue(); 
                console.log(contObj)
                component.set("v.ContWrp",contObj['ContList']);
            }
            
        });
        $A.enqueueAction(action);
        
          var cont = component.find('expCatDivId');
        $A.util.removeClass(cont, 'slds-hide');
        $A.util.addClass(cont, 'slds-show');
         var acchide = component.find('accounthide');
        $A.util.removeClass(acchide, 'slds-show');
        $A.util.addClass(acchide, 'slds-hide');
        
        
    }, 
     checkAllCheckboxesAcc : function(component, event, helper) {
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
    checkAllCheckboxesCont: function(component, event, helper) {
        var checkboxes1 = component.find("checkbox1");
         var checkboxes2 = component.find("checkbox11").get("v.value");
      
        if(checkboxes2 == true){
             for (var i = 0; i < checkboxes1.length; i++){
            checkboxes1[i].set("v.value",true);
        }
        }else{
              for (var i = 0; i < checkboxes1.length; i++){
            checkboxes1[i].set("v.value",false);
                  
        }
       }
                  
    },
    showContactsnew : function(component, event, helper) {
     
         setTimeout(function(){ 
            $('.datatbleId3').DataTable( {
                responsive: true
            } );
            
        }, 600);
        var checkId = [];
        var checkAllId = JSON.stringify(component.get("v.ContWrp"));
      
        var action=component.get("c.getNewCont");
        action.setParams({ "newWrapList" : checkAllId });
       
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                
                if(response.getReturnValue().length<=0){
                     
                    alert("Select Atleast one Contact");
                    
                }
           var contObj=response.getReturnValue(); 
                console.log(contObj)
                component.set("v.WraperContNew",contObj['NewContList']);
                 component.set("v.stagedrop",contObj['stagePicklist']);
                
            }
            
        });
        $A.enqueueAction(action);
        
       
         var acchide = component.find('expCatDivId');
        $A.util.removeClass(acchide, 'slds-show');
        $A.util.addClass(acchide, 'slds-hide');
           var cont = component.find('ContTablenew');
        $A.util.removeClass(cont, 'slds-hide');
        $A.util.addClass(cont, 'slds-show');
        
    }, 
    
    onRolePickChange: function(component, event, helper) {
        var pcickval = event.getSource().get("v.value");
        
         alert(pcickval);
        var picksplit =pcickval.split("###");
       
        var stageId=picksplit[0];
        var stageval=picksplit[1];
       
        var WraperContlist = component.get("v.WraperContNew");
        alert("WraperContlist.length "+WraperContlist.length)
        for(var i=0;i<WraperContlist.length;i++){
            if(WraperContlist[i].cont.Id == stageId){
            WraperContlist[i].cont.Id=stageId;
            WraperContlist[i].cont.stage__c=stageval;
                }
        }
        component.set("v.WraperContNew",WraperContlist);

    },
    
     save: function(component, event, helper) {

      
            var action = component.get("c.saveContacts");
            
              var blist=JSON.stringify(component.get("v.WraperContNew"));
           
              alert('blist '+blist);
            action.setParams({
                "filteredEmpWrapp":blist
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                      alert('Record Save Successfully');
                     //  component.set("v.wrapperBookingList",response.getReturnValue());
                    //    helper.addbookinghlp(component, event);
                
                }
            });
            
            $A.enqueueAction(action);
      
    },
    checkAllCheckboxesstageCont : function(component, event, helper) {
        var checkboxes = component.find("checkbox13");
         var checkboxes2 = component.find("checkbox113").get("v.value");
      
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
      
})