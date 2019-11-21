({
	 caseValidation : function(component, event) {
      
        var validData = true;
         var opportunity = component.find("opportunity").get("v.value");
           var date1 = component.find("date").get("v.value");
         var quantity = component.find("quantity").get("v.value");
         var salesPrice = component.find("salesPrice").get("v.value");
        
       /* if(caseSubField != undefined && caseSubField.trim().length==0 )
        {
            alert('Insert caseSubject');
        }*/
        
        var titleField = component.find("CaseNameField1");
        $A.util.removeClass(titleField,'slds-visible' );   
        $A.util.addClass(titleField, 'slds-hidden');
        
        if((opportunity == null || opportunity == undefined) || (quantity == null || quantity == undefined) || (salesPrice == null || salesPrice == undefined) || (date1 == null || date1 == undefined)   ){
            
            var titleField = component.find("CaseNameField1");
            $A.util.removeClass(titleField, 'slds-hidden');   
            $A.util.addClass(titleField, 'slds-visible'); 
            validData = false;
        }else{
           
            return validData ;
        }
       
    }
})