public with sharing class ContactController {
     @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
//  Contact con =   [SELECT Id, Name, Title, Phone, Email FROM Contact where Id =:recordId ];
//  CaseComment cc = new CaseComment(ParentId = con.Id,CommentBody =con.Description );
//         insert cc;

  return [SELECT Id, Name, Title, Phone, Email FROM Contact  LIMIT 10];

    }
}