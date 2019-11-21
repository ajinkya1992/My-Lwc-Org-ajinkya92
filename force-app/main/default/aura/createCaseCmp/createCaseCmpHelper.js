({
	caseValidation : function(component, event) {
        
        var validData = true;
        var tempName = component.find("CaseNameField").get("v.value");
        var tempEmail = component.find("CaseEmailField").get("v.value");
        var tempComp = component.find("CaseCompanyField").get("v.value");
        var tempSI = component.find("CaseSIField").get("v.value");
        var tempSub = component.find("CaseSubField").get("v.value");
        
       var caseNamevll = component.find("caseNamevl");
        $A.util.removeClass(caseNamevll,'slds-visible' );   
        $A.util.addClass(caseNamevll, 'slds-hidden');
        
         var caseEmail = component.find("CaseEmail");
        $A.util.removeClass(caseEmail, 'slds-visible');   
        $A.util.addClass(caseEmail, 'slds-hidden'); 
        
         var caseCompany = component.find("CaseCompany");
        $A.util.removeClass(caseCompany, 'slds-visible');   
        $A.util.addClass(caseCompany, 'slds-hidden'); 
        
        var caseSIF = component.find("CaseSIF");
        $A.util.removeClass(caseSIF, 'slds-visible');   
        $A.util.addClass(caseSIF, 'slds-hidden'); 
         
           var caseSub = component.find("CaseSub");
        $A.util.removeClass(caseSub, 'slds-visible');   
        $A.util.addClass(caseSub, 'slds-hidden'); 
         
        
       
        if(tempName == null || tempName == undefined || tempName.trim().length==0 ){
            
            var caseNamevll = component.find("caseNamevl");
            $A.util.removeClass(caseNamevll, 'slds-hidden');   
            $A.util.addClass(caseNamevll, 'slds-visible'); 
            validData = false;
        }
       
        if(tempEmail == undefined || tempEmail == ''|| tempEmail == null){
            var caseEmail = component.find("CaseEmail");
            $A.util.removeClass(caseEmail, 'slds-hidden');   
            $A.util.addClass(caseEmail, 'slds-visible'); 
            validData = false;
        }else{
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if(tempEmail.match(regExpEmailformat)){
                var caseEmail = component.find('CaseEmail');
                $A.util.removeClass(caseEmail, 'slds-visible');
                $A.util.addClass(caseEmail, 'slds-hidden');
            } 
            else{
                var caseEmail = component.find("CaseEmail");
            $A.util.removeClass(caseEmail, 'slds-hidden');   
            $A.util.addClass(caseEmail, 'slds-visible'); 
            validData = false;
            }
        }
        
         if(tempComp == null || tempComp == undefined || tempComp == "" || tempComp.trim().length==0 ){
            var caseCompany = component.find("CaseCompany");
            $A.util.removeClass(caseCompany, 'slds-hidden');   
            $A.util.addClass(caseCompany, 'slds-visible'); 
            validData = false;
        }
        
        if(tempSI == null || tempSI == undefined || tempSI == "" || tempSI.trim().length==0 ){
            var caseSIF = component.find("CaseSIF");
            $A.util.removeClass(caseSIF, 'slds-hidden');   
            $A.util.addClass(caseSIF, 'slds-visible'); 
            validData = false;
        }
          if(tempSub == null || tempSub == undefined || tempSub == "" || tempSub.trim().length==0 ){
            var caseSub = component.find("CaseSub");
            $A.util.removeClass(caseSub, 'slds-hidden');   
            $A.util.addClass(caseSub, 'slds-visible'); 
            validData = false;
        }
       
       
        if( validData ){
            
            return validData;
        }
        return validData;
    }

})