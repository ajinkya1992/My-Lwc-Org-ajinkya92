public class Get_Product {
    @AuraEnabled
    public static void getProduct(String productName, Decimal prodQuantity,Decimal salesPrice,Id relatedOppId, String description,Date serviceDate,Id recordId){
        
        OpportunityLineItem  OppLinItmObj = new OpportunityLineItem(); 
        List<Opportunity> oppList = [select Id, Name,Pricebook2Id from Opportunity where  Id =: relatedOppId ];
        
        List<PriceBookEntry> pbeList = new List<PriceBookEntry>();
        
        for(Opportunity oppoj:oppList){
             pbeList = [SELECT Id, PriceBook2Id, Product2Id, 
                   Product2.Name FROM PriceBookEntry WHERE Product2Id=:recordId AND PriceBook2Id =: oppoj.Pricebook2Id AND PriceBook2.isActive=true LIMIT 1];
        
        }
       
        if(pbeList.size()==0)
        {
            pbeList = [SELECT Id, PriceBook2Id, Product2Id, Product2.Id,
                       Product2.Name FROM PriceBookEntry WHERE PriceBook2.isActive=true LIMIT 1];
        }
        
        Decimal total= salesPrice*prodQuantity;
        
        if(pbeList != null && pbeList.size() > 0 ){
            //for(PriceBookEntry pr:pbeList){
            
            OppLinItmObj.Product2Id = recordId;
            //OppLinItmObj.Name =productName;
            OppLinItmObj.Quantity = prodQuantity;
            
            OppLinItmObj.TotalPrice = total;
            OppLinItmObj.Description =description;
            OppLinItmObj.OpportunityId = relatedOppId;
            OppLinItmObj.PricebookEntryId = pbeList[0].Id;
            OppLinItmObj.ServiceDate = serviceDate;
            
            try{
                System.debug('OppLinItmObj ~~~~'+OppLinItmObj);
                insert OppLinItmObj;
                
            }catch(Exception e){
                System.debug('error msg  '+e.getMessage()+'   LINE NO '+e.getLineNumber());
            }
        }
        
        
        
    }
}