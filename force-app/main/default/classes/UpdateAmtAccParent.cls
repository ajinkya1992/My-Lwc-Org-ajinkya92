public class UpdateAmtAccParent {	
    
    public static void TotalOfOppAmt(List<Opportunity> OppList)
    {
        set<ID> AccIdSet =new set<ID>();
        List<Account> AccList=new List<Account>();
        for(Opportunity O:OppList)
        {
            AccIdSet.add(O.AccountId);
        }
        List<AggregateResult> result = [Select AccountId, Sum(Amount) total From Opportunity where AccountId IN :AccIdSet Group By AccountId];
        for(AggregateResult ar : result){
            id str = (ID)ar.get('AccountId');
            if(str != null)
            {
                Account a = new Account(id = str);
                try{
                    a.Total_Amount__c = (Decimal)ar.get('total');
                }
                Catch(NullPointerException e)
                {
                    a.Total_Amount__c=0;
                }
                AccList.add(a);
            }
            
        } 
        if(AccList != null){
            update AccList;
        }
        TotalOfOppAmtParent([SELECT ParentId FROM Account WHERE id =:AccIdSet ]);
        System.debug(AccList);
    }

        
   
    
 public static void TotalOfOppAmtParent(List<Account> AccoList)
    {
        set<ID> AccIdSet =new set<ID>();
        List<Account> AccList=new List<Account>();
        for(Account O:AccoList)
        {
            AccIdSet.add(O.ParentId);
        }
        List<AggregateResult> result = [Select ParentId, Sum(Total_Amount__c) total From Account where ParentId IN :AccIdSet Group By ParentId];
        for(AggregateResult ar : result){
            id str = (ID)ar.get('ParentId');
            if(str != null)
            {
                Account a = new Account(id = str);
                try{
                    a.Total_Amount__c = (Decimal)ar.get('total');
                }
                Catch(NullPointerException e)
                {
                    a.Total_Amount__c=0;
                }
                AccList.add(a);
            }
            
        } 
        if(AccList != null){
            update AccList;
        }
     
        System.debug(AccList);
    }
    
    
    
    
    public static void deleteAcc(List<Opportunity> delList) {

            Map<id,decimal> acc = new Map<id,decimal>();
            for(Opportunity oppod :delList){
                if(oppod.Amount != null){
                    acc.put(oppod.AccountId ,oppod.Amount );
                }
            }
            List<Account> aList = new list<account>();
            List<account> accList = [select Total_Amount__c from Account where Id In : acc.keyset()];
            for(Account a : accList){
                if(a.Total_Amount__c == null){
                    a.Total_Amount__c = 0;
                }
                a.Total_Amount__c -= acc.get(a.id);
                aList.add(a);
            }
            try{
                update aList;
            }
            catch(Exception ex){
                System.debug(ex);
            }
       // deleteAccparent([SELECT ParentId FROM Account WHERE id =:acc.keyset()]);	
        }    
    
    
    /* public static void deleteAccparent(List<Account> delList) {

            Map<id,decimal> acc = new Map<id,decimal>();
            for(Account oppod :delList){
                if(oppod.Total_Amount__c != null){
                    acc.put(oppod.ParentId ,oppod.Total_Amount__c );
                }
            }
            List<Account> aList = new list<account>();
            List<account> accList = [select Total_Amount__c from Account where Id In : acc.keyset()];
            for(Account a : accList){
                if(a.Total_Amount__c == null){
                    a.Total_Amount__c = 0;
                }
                a.Total_Amount__c -= acc.get(a.id);
                aList.add(a);
            }
            try{
                update aList;
            }
            catch(Exception ex){
                System.debug(ex);
            }
        }  */  

}