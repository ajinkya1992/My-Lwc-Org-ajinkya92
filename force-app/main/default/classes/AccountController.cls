public with sharing class AccountController {
   @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecordWithRelatedContactList(Id recordId) {

        List <Account> accountList = new List<Account>();
        accountList =  [Select Id,(Select Id, FirstName, LastName, Title, Phone, Email FROM Contacts) from Account WHERE Id = :recordId];

        return accountList;
    }
}