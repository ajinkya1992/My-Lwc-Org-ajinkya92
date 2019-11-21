public with sharing class ContBaseAcc {
 public ContBaseAcc() {
        
        
    }


    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        List<Account> accList;
        accList =[SELECT Id,Name,Phone,Parent.Name FROM Account WHERE ID IN (SELECT AccountId FROM Contact)];
       // System.debug('accList-->>'+accList);
        return accList;
    }


    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(Id[] selAccId){
        System.debug('selAccId-->>'+selAccId);
        List<Contact> conList;
        conList=[Select FirstName, LastName, Phone,Email From Contact Where AccountId In: selAccId];
        System.debug('conList-->>'+conList);
        return conList;
    }



    @AuraEnabled(cacheable=true)
    public static List<Show_Booking__c> getBookingList(Id selConId){
        System.debug('selConId-->>'+selConId);
        List<Show_Booking__c> bookList;
        bookList=[Select Id,Name,Calculated__c, Description__c,Amount__c, Contact__r.Name,Contact__r.Id From Show_Booking__c Where Contact__c =:selConId ];
        System.debug('bookList-->>'+bookList);
        return bookList;
    }


      @AuraEnabled
    public static sObject deleteSObject(sObject sob) {
        delete sob;
        return sob;
    }
}