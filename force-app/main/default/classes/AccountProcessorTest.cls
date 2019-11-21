@IsTest
public class AccountProcessorTest {
 @IsTest
    private static void ContactCount() {
        Account acc= new Account();
        acc.Name='LML';
        insert acc;
        
        Contact cont= new Contact();
        cont.AccountId=acc.Id;
         cont.FirstName='ajinkya';
        cont.LastName='thakre';
        insert cont;
        Set<Id> AccountId=new Set<Id>();
            AccountId.add(acc.Id);
        Test.startTest();
       AccountProcessor.countContacts(AccountId);
    Test.stopTest();
       
        Account accList=[Select Id,Number_of_Contacts__c FROM Account where Id =:acc.Id Limit 1];
         System.assertEquals(Integer.valueOf(accList.Number_of_Contacts__c), 1);
       
    }
}