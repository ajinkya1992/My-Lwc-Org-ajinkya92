public with sharing class LWCApexMethodDemoController {
   
     @AuraEnabled(Cacheable = true)
    public static List<Account> getAccounts(){
      return [SELECT Id, Name, Phone, AccountNumber, Industry, CreatedDate FROM Account  Limit 10];
    }
}