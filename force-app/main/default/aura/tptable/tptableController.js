({
	 doInit : function(component, event, helper) { 
         var action=component.get("c.getPRojectWithChild");
         action.setCallback(this,function(response){
             var state=response.getState();
             if(state==="SUCCESS"){
                 
                 component.set("v.ProjectLcdList",response.getReturnValue()); 
                 console.log(response.getReturnValue());
             }
         });
         $A.enqueueAction(action);
         
      },
    StatusChanged : function(component, event, helper) { 
        var index = event.getSource().get("v.value");
        component.set("v.ProjectLcdIndex",index);
        
        var ProjectLcdList= component.get("v.ProjectLcdList");
        ProjectLcdList[index].isselect=true;
        component.set("v.ProjectLcdList",ProjectLcdList);
    },
      getSelectedcertificate: function (component, event) {
        // This will contain an array of the "value" attribute of the selected options
        var selectedOptionValue = event.getParam("value");
        console.log('selectedOptionValue->'+selectedOptionValue)
        component.set("v.selectedOptionValue",selectedOptionValue);
        //component.set("v.selectedOptionValue",selectedOptionValue);
       	console.log('selectedOptionValue->'+component.get("v.selectedOptionValue"));
        //alert("Option selected with value: '" + selectedOptionValue.toString() + "'");
    },
	 addRow: function(component, event, helper) {         
        helper.addRecord(component, event);
       
    },
    removeRow: function(component, event, helper) {
        
        
        var ProObjindex = component.get("v.ProjectLcdIndex");
        alert(ProObjindex);
        var ProjectLcdList= component.get("v.ProjectLcdList");
        var editList=ProjectLcdList[ProObjindex].HeadcountmodalList;
       
        var index = event.getSource().get("v.value");
        console.log('index->'+index);
        editList.splice(index, 1);
        component.set("v.ProjectLcdList", ProjectLcdList);
         
    },
    saveEducationDetails:function(component,event,helper){
      /* 	var obj= component.get("v.educationList");
        var othercertificate=component.find("othercertificate").get("v.value");       
        var certificateList=component.get("v.selectedOptionValue");
        var Course=[],colgName=[],boardname=[],passyear=[];
        for(var i=0;i<obj.length;i++){
            //console.log('aaaa->'+obj[i].Course);
            Course.push(obj[i].Course);
            colgName.push(obj[i].colgName);
            boardname.push(obj[i].board);
            passyear.push(obj[i].passyear);
        }        
        console.log('Course->'+Course);console.log('colgName->'+colgName); console.log('boardname->'+boardname);console.log('passyear->'+passyear);
        console.log('certificateList->'+certificateList); console.log('othercertificate->'+othercertificate);
        var action=component.get("c.insertEducationInfo");
        action.setParams({
            "Id":component.get("v.recordId"),
            "course": Course.join(),
            "colgName": colgName.join(),
            "boardName":boardname.join(),
            "passYear": passyear.join(),
            "certificateList":certificateList.join(),
            "othercertificate":othercertificate
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
               component.set("v.mode", "view");
                
            }
        });
        $A.enqueueAction(action);*/
        var index = event.getSource().get("v.title");
        alert(index);
        component.set("v.mode", "view");
    },
    edit:function(component,event,helper)
    {
         component.set("v.mode", "edit");
    },
    cancel:function(component,event,helper)
    {
         component.set("v.mode", "view");
         
    },
    HideTable:function(component,event,helper)
    {
        var index = event.getSource().get("v.title");
         var ProjectLcdList= component.get("v.ProjectLcdList");
        ProjectLcdList[index].isselect=false;
        component.set("v.ProjectLcdList",ProjectLcdList);
         
    },
    handleSave:function(component,event,helper)
    {
       /* var MyList=component.get("v.ProjectLcdList");
        var ListtoSend=[];
        for(var i=0;i<MyList.length;i++)
        {
            alert('ss')
            var MysecondList=MyList[i].HeadcountmodalList;
            if(MysecondList!=undefined)
            {
                alert('aa')
                for(var j=0;j<MysecondList.length;j++)
                {
                    var Obj=MysecondList[j];
                    Obj.Project_LCDB__c=MyList[i].Projects.Id;
                    ListtoSend.push(Obj);
                }
                
            }
        }
        console.log('cccccccccccc');
        console.log(ListtoSend);
        */
        
        
        console.log(component.get("v.ProjectLcdList"));
        var checkAllId = JSON.stringify(component.get("v.ProjectLcdList"));
        console.log(checkAllId);
        var action=component.get("c.CreateChildRecord");
        action.setParams({ 
            "WrapperString" : checkAllId
        });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            alert(state);
            if(state==="SUCCESS"){
                
              /*  var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "The record has been Save successfully."
                    
                });
                toastEvent.fire();*/
                //  window.location.reload();
            }
            
        });
        $A.enqueueAction(action);
        
        
       
        
    }
})