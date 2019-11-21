trigger ContactDelete on Contact (before delete) {
    
    set<Id>ids=new  set<Id>();
    for(Contact c:trigger.old){
        ids.add(c.Id); 
    }
    List<Contact_relationship__c> contRelObj=new List<Contact_relationship__c>();
    if(!ids.isEmpty() && ids!=null){
        contRelObj=[Select Id from Contact_relationship__c where Contact__c IN:ids];
        delete contRelObj;
    }
}