trigger CaseAttachmentTrigger on Case (after update,after insert) {
 List<Case> allCases=[select id,parentId from case where Id in :Trigger.new];
        
         Set<Id> allParentCase=new Set<Id>();
       for(Case c:allCases)
       {
          allParentCase.add(c.Id);
           System.debug('allParentCase====='+allParentCase);
       }
  // allParentCase contain all unique parent cases id

   List<Attachment> allAttachmentParentContains=[select id,Body,BodyLength from attachment where parentId IN :allParentCase];
System.debug('allAttachmentParentContains====='+allAttachmentParentContains);
}