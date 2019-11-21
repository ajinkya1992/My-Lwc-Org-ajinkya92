({
	 caseValidation : function(component, event) {
      
       
        var validData = true;
        var accName = component.find("accNameField").get("v.value");
       
        var phoneField = component.find("phoneField").get("v.value");
        
        var industryvl = component.find("industry").get("v.value");
       
       /* if(caseSubField != undefined && caseSubField.trim().length==0 )
        {
            alert('Insert caseSubject');
        }*/
        
        
        
        var titleField = component.find("accNameField1");
        $A.util.removeClass(titleField,'slds-visible' );   
        $A.util.addClass(titleField, 'slds-hidden');
        
        var phoneFied = component.find("phoneFied");
        $A.util.removeClass(phoneFied, 'slds-visible');   
        $A.util.addClass(phoneFied, 'slds-hidden'); 
         
          var indust1 = component.find("indust");
        $A.util.removeClass(indust1, 'slds-visible');   
        $A.util.addClass(indust1, 'slds-hidden'); 
        
       
        if(accName == null || accName == undefined || accName.trim().length==0 ){
            
            var titleField = component.find("accNameField1");
            $A.util.removeClass(titleField, 'slds-visible');   
            $A.util.addClass(titleField, 'slds-hidden'); 
            validData = false;
        }
       
        /*if(email == undefined || email == ''|| email == null){
            var CaseEmail = component.find("CaseEmailField1");
            $A.util.removeClass(CaseEmail, 'slds-hidden');   
            $A.util.addClass(CaseEmail, 'slds-visible'); 
            validData = false;
        }else{
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if(email.match(regExpEmailformat)){
                var cmpTarget1 = component.find('CaseEmailField1');
                $A.util.removeClass(cmpTarget1, 'slds-visible');
                $A.util.addClass(cmpTarget1, 'slds-hidden');
            } 
            else{
                var CaseEmail = component.find("CaseEmailField1");
                $A.util.removeClass(CaseEmail, 'slds-hidden');   
                $A.util.addClass(CaseEmail, 'slds-visible'); 
                validData = false;
            }
        }*/
        if(phoneField == null || phoneField == undefined || phoneField == "" || phoneField.trim().length==0 ){
            var phoneFied = component.find("phoneFied");
            $A.util.removeClass(phoneFied, 'slds-hidden');   
            $A.util.addClass(phoneFied, 'slds-visible'); 
            validData = false;
        }
          if(industryvl == null || industryvl == undefined || industryvl == "" || industryvl.trim().length==0 ){
            var indust1 = component.find("indust");
            $A.util.removeClass(indust1, 'slds-hidden');   
            $A.util.addClass(indust1, 'slds-visible'); 
            validData = false;
        }
      
       
        if( validData ){
            
            return validData;
        }
     
    }
})