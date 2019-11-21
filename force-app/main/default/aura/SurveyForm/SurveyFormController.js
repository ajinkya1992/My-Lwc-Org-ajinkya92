({
    doInit : function(component, event, helper) {
        var action=component.get("c.getQuestions");
        var qList1=[];
       var ans=0;
       
                        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
              
                var qList=response.getReturnValue();
              
                var totalLength = qList.length ;
                var pageSize = component.get("v.pageSize");
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                component.set("v.totalRecordsCount", totalLength);
                    component.set("v.totalPagesCount", Math.ceil(totalLength / pageSize));    
                var finalList = [];
                for(var i=0; i<qList.length; i++)
                {
                    var answers = qList[i].ansOpt;
                     console.log('answers '+answers);
                     var D;
                    
                      var psRangeFrom;
                      var psRangeTo;
                    for(var j=0; j<answers.length; j++)
                                       {
                                          
                                           D=answers[j].Radio_Answer_Range__c;
                                           answers[j].select=false;
                                           
                                       }
                   
                                       var qList1=[];
                                         var q=D+1;
                                       for(var j=1;j<=q;j++)
                                       {
                                         
                                            if(j==q)
                                            {
                                                qList1.push({'label': 'NA', 'value': 'NA'}); 
                                            }
                                           else{
                                                 qList1.push({'label': j, 'value': ''+j}); 
                                           }
                                         
                                       }
                    for(var j=0; j<answers.length; j++)
                    {
                       answers[0].q=qList1;
                          console.log("Ans: " +  answers[0].q);
                        
                    }
                                   //    qList[i].qList1=qList1;
                                       finalList.push(qList[i]); 
                                   }
                                     console.log("finalList: " + finalList);
                                   component.set("v.QuestionList", finalList);
                               }
                               else {
                                   console.log("Failed with state: " + state);
                               }
        });
        $A.enqueueAction(action);
    },
    
    
    
     getval: function(component, event, helper) {
      component.set("v.hideshowMul",true);
        var value=event.getSource().get("v.value");
         var name=event.getSource().get("v.name");
         var label=event.getSource().get("v.label");
        // alert("name "+name);
       //  alert("value "+value);
       //  alert("label "+label);
         
         var a = event.getSource();
         var id = a.getLocalId();
          alert('text1 '+id);
         var AnsId=event.getSource().get("v.text");
         alert("AnsId"+AnsId);
         var temp;
          
        var finalList = [];
        var rowlist=[]
        rowlist = component.get("v.QuestionList");
        var Que;
         
          
         
          for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
           {
            
            var answers = rowlist[indexVar].ansOpt;
               for(var j=0; j<answers.length; j++)
                  {
                        if(answers[j].Id==AnsId)   
                        {
                            temp=answers[j].Sub_Question__c;
                              alert("temp "+temp);
                        }
                                      
                  }
          }
      
        for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
        {
            if(rowlist[indexVar].queObj.Id==temp)
            {
               Que=rowlist[indexVar];
            }
       }
      
         
        for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
        {
            if(rowlist[indexVar].queObj.Name==name)
            {
                var ans=rowlist[indexVar].ansOpt;
                
                for(var indexVar1 = 0; indexVar1 < ans.length; indexVar1++){
                    if(ans[indexVar1].Sub_Question__c==temp){
                    ans[indexVar1].select= true;
                      
                }else{
                     ans[indexVar1].select= false;
                   
                }
                } 
                
                if(id=='text1'){
                for(var cmp in component.find("text1")){
                    var compD = component.find("text1")[cmp];
                    
                var textget= compD.get("v.value");
                    alert("textget "+textget);
                 rowlist[indexVar].textGet.push(textget);   
                }}
                
                if(id=='checkbox')
                {
                  if(value==true)
                  {
                    rowlist[indexVar].QueList.push(Que);
                        rowlist[indexVar].Selected.push(AnsId);
                  }    
                  if(value==false)
                  {
                   // rowlist[indexVar].QueList.pop(Que);
                     rowlist[indexVar].Selected.pop(AnsId);
                     var a=rowlist[indexVar].QueList.indexOf(Que);
                     alert(a);
                     rowlist[indexVar].QueList.splice(a, 1);
                    console.log('In False SubQuelist'+Que);
                  }
                    
            }
            if(id=='r0')
            {
               rowlist[indexVar].QueList=[];
               rowlist[indexVar].QueList.push(Que);
               
            }
     }
            finalList.push(rowlist[indexVar]);
        }
         console.log(finalList); 
        component.set("v.QuestionList", finalList);
       
   },
    
    getval1: function(component, event, helper) {
         var value=event.getSource().get("v.value");
         var name=event.getSource().get("v.name");
         var label=event.getSource().get("v.label");
         alert("name "+name);
         alert("value "+value);
         alert("label "+label);
        var rowlist=[];
        var Que=[];
        var temp;
        var finalList = [];
        rowlist = component.get("v.QuestionList");
        for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
        {
            if(rowlist[indexVar].queObj.Name==name)
            {
                // alert(name);
                var answers=rowlist[indexVar].ansOpt;
               
                for(var j=0; j<answers.length; j++)
                {
                    
                    
                    if(answers[j].From_Detractors__c<=value && answers[j].To_Dtractors__c>=value)
                    {
                        
                        temp=answers[j].Sub_Question__c;
                        // alert(answers[j].Name);
                         alert('From_Detractors__c'+temp);
                    }
                    else if(answers[j].Passives_Range_From__c<=value && answers[j].Passives_Range_To__c>=value)
                    {
                        temp=answers[j].Sub_Question__c;
                        // alert('From_Passive__c'+temp);
                    }
                        else if(answers[j].Promoters_Range_From__c<=value && answers[j].Promoters_Range_To__c>=value)
                        {
                            temp=answers[j].Sub_Question__c;
                        }
                }
                
                for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
                {
                    if(rowlist[indexVar].queObj.Id==temp)
                    {
                        Que=rowlist[indexVar];
                    } 
                }
                for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
                {
                    if(rowlist[indexVar].queObj.Name==name)
                    {
                        rowlist[indexVar].QueList=[];
                        rowlist[indexVar].QueList.push({Que});
                    }
                    else{
                        rowlist[indexVar].QueList.push(' ');
                    }
                }
                finalList.push(rowlist[indexVar]);
            }
            console.log(finalList); 
            component.set("v.QuestionList", rowlist);
            component.set("v.hideshowMul",true);
            
        }
        
    }  ,  
    
   
 /* javaScript function for pagination */
    navigation: function(component, event, helper) {
        var sObjectList = component.get("v.QuestionList");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var whichBtn = event.getSource().get("v.name");
        // check if whichBtn value is 'next' then call 'next' helper method
        if (whichBtn == 'next') {
            component.set("v.currentPage", component.get("v.currentPage") + 1);
            helper.next(component, event, sObjectList, end, start, pageSize);
        }
        // check if whichBtn value is 'previous' then call 'previous' helper method
        else if (whichBtn == 'previous') {
            component.set("v.currentPage", component.get("v.currentPage") - 1);
            helper.previous(component, event, sObjectList, end, start, pageSize);
        }
    },
    
    SaveButton : function(component, event, helper) {
        var textget;
        var rowlist;
         
        rowlist = component.get("v.QuestionList");
        for(var cmp in component.find("text1")){
            var compD = component.find("text1")[cmp];
            
            textget= compD.get("v.value");
         
        } 
   
            for (var indexVar = 0; indexVar < rowlist.length; indexVar++)
            {  
                rowlist[indexVar].textGet.push({extget});
              
            }
        
        
        var questionList = JSON.stringify(component.get("v.QuestionList"));
         var action=component.get("c.saveSurvey");
        action.setParams({ "surveyWrapList" : questionList });
        
         alert("yuuuuuuuu "+questionList);
        // var action=component.get("c.showContacts1");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                 alert("Survey Save Successfully!!");
                if(response.getReturnValue().length<=0){
                     
                    alert("Answer Atleast One Question");
                    
                }
                
               // component.set("v.wrapperConList",response.getReturnValue());
            }
            
        });
        $A.enqueueAction(action);
        
       
    }
    
    
})