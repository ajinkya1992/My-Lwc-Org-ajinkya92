trigger CountContact on Contact (after insert,after update) {
set<Id> accidSet =new set<Id>();
    set<Id> contList =new set<Id>();
    for(Contact conObj:trigger.new){
        accidSet.add(conObj.AccountId);
    }
    List<Account> accLsit1=new List<Account>();
    List<Account> accLsit=[Select Id from Account where Id IN:accidSet];
    List<Contact> contLsit=[Select Id,AccountId from Contact where AccountId IN:accLsit];
    
    Map<Id, Integer> mapacc=new Map<Id, Integer>();
    for(Account acc:accLsit ){
        for(Contact con:contLsit ){
            if(acc.Id ==con.AccountId )
            {
                contList.add(con.Id);
            mapacc.put(acc.Id, contList.size());    
            }
        }
    }
    if(contList.size()>0 && contList!=null){
        for(Account acc1:accLsit ){
            if(mapacc.get(acc1.Id) == null){
                acc1.Contact_Count__c=0;
            }else{
                 acc1.Contact_Count__c= mapacc.get(acc1.Id);
            }
          
            accLsit1.add(acc1);
        }
    }
    try{
        update accLsit1;
    }catch(Exception e){
        
    }
    
}