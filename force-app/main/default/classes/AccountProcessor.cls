public class AccountProcessor {
 @future 
    public static void countContacts(Set <Id> accId){
       
        List<Account> acclist = [Select Id, Name,Number_of_Contacts__c ,(Select  Id from Contacts) from Account Where Id IN :accId];
        for(Account acc:acclist){
            List<Contact> conlist=acc.Contacts;
            acc.Number_of_Contacts__c = conlist.size();
            
        }
        
       update   acclist; 
    }
    
}