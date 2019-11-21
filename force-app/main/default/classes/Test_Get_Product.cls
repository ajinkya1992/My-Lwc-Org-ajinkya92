@isTest
public class Test_Get_Product {
    @isTest static void testOpportunityLineItem() {
        Date myDate = Date.newInstance(2020, 2, 17);
        Date newDate = mydate.addDays(2);
        Id pricebookId = Test.getStandardPricebookId();
        Pricebook2 pb22 = new Pricebook2(Name='testDIE');
        insert pb22;
        // Opportunity opp1 = new Opportunity(Name = 'TestOpp',Amount = 2000,CloseDate=Date.today(),Pricebook2Id =pricebookId,StageName='Close Won',Type='New Customer');
        //insert opp1; 
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        
        Opportunity opp1 = new Opportunity(Pricebook2Id = pricebookId, AccountId = AcntRec.Id,	StageName = 'qualification', Name='Opp',  closeDate=Date.newInstance(2028,10,10));
        insert opp1;
        System.debug('opp1'+opp1);
        //Create your product
        Product2 prod = new Product2(
            Name = 'Product X',
            ProductCode = 'Pro-X',
            isActive = true
        );
        insert prod;
        
        
        //Create your pricebook entry
        PriceBookEntry pbEntry = new PriceBookEntry(
            Pricebook2Id = opp1.Pricebook2Id,
            Product2Id = prod.Id,
            UnitPrice = 100.00,
            IsActive = true
        );
        insert pbEntry;
        System.debug(pbEntry.id+'pbEntry : ' +[SELECT Id, PriceBook2Id, Product2Id
                       FROM PriceBookEntry LIMIT 1]);
        
        Get_Product.getProduct('hello', 22, 5000, opp1.Id, '1jjjjjj',newDate,prod.Id);
        
        
        //create your opportunity line item.  This assumes you already have an opportunity created, called opp
        /*  OpportunityLineItem oli = new OpportunityLineItem(
OpportunityId = opp1.Id,
Quantity = 5,
PricebookEntryId = pbEntry.Id,
TotalPrice = 200
);
insert oli;*/
        
        
        //  getProduct(String productName,String description, String prodQuantity,String salesPrice,String relatedOppId,String recordId, Date serviceDate)
        
        
    }
}