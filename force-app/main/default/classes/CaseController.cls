public with sharing class CaseController {
     @AuraEnabled(cacheable=true)
    public static void getCasetList(String recordId) {
 System.debug('recordId '+recordId);

 //CaseComment cascom = new CaseComment(ParentId = CaseObject.Id,CommentBody =CaseObject.Description );
   //     insert cascom;

    }
}