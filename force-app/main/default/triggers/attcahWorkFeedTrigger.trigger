trigger attcahWorkFeedTrigger on FeedItem (after insert) {
    
    Set<Id> parentCase=new Set<Id>();
    ID pId;
    for (FeedItem feedList: Trigger.new)
    { 
        System.debug('feedList  '+feedList);
        parentCase.add(feedList.ParentId);
        pId = feedList.Id;
    } 
    
    List <Case> caseDate ;
        
    Id cid ;
    caseDate = [SELECT Id,CaseNumber,OwnerId,agf__ADM_Work__c FROM Case WHERE agf__ADM_Work__c =: parentCase];
    
    for(Case c :caseDate){
        cid=c.Id;
        System.debug('cid '+cid); 
    }
    
    List<FeedAttachment> attachments =  [SELECT Id, Title, Type,RecordId, FeedEntityId  FROM FeedAttachment  WHERE FeedEntityId IN :Trigger.new ];
     List<FeedItem> attachments1 = [SELECT Body, (SELECT RecordId,FeedEntityId, Title, Type, Value FROM FeedAttachments)FROM FeedItem WHERE Id =:pId];
    
     
    System.debug('attachments1 '+attachments1);   
    System.debug('attachments '+attachments);    
    List<ContentDocumentLink> contDocLink =
        [SELECT ContentDocumentID, LinkedEntity.type, LinkedEntityId 
         FROM ContentDocumentLink 
         WHERE ContentDocumentID =: cid ];
    
    System.debug('contDocLink '+contDocLink);   
    for (ContentDocumentLink co : contDocLink) {
     
        for (FeedAttachment attachment : attachments) {
            FeedAttachment feedAttachment = new FeedAttachment();
            feedAttachment.FeedEntityId = pId;
            feedAttachment.RecordId = co.LinkedEntityId; 
            feedAttachment.Title = attachment.Title;
            feedAttachment.Type =attachment.Type; 
            System.debug('feedAttachment '+feedAttachment); 
            insert feedAttachment;
        }}
    
    
    
}