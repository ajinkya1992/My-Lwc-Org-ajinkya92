trigger WorkFeedTrigger on FeedItem (after insert) {
    if(TaskHelper.alreadyCreatedTasks){
        TaskHelper.alreadyCreatedTasks= false;
   Set<Id> parentCase=new Set<Id>();
 Id aj;
    for (FeedItem feedList: Trigger.new)
    { 
        System.debug('feedList  '+feedList);
        parentCase.add(feedList.ParentId);
       
    } 
    Attachment att;
   CaseComment caseComm;
   List <Case> caseDate ;
    caseDate = [SELECT Id,CaseNumber,OwnerId,agf__ADM_Work__c FROM Case WHERE agf__ADM_Work__c =: parentCase];
    System.debug('caseDate'+caseDate);
        Map<Id, Id> Mapval = new Map<Id, Id>();
     for (Case c: caseDate)
    { 
     Mapval.put(c.agf__ADM_Work__c,c.Id);
      }
    
    try {
        
 
         for (FeedItem feedList: Trigger.new)
    {
        
          Id caseId=Mapval.get(feedList.ParentId);
             System.debug('caseId '+caseId);   
                caseComm = new CaseComment();
               
               caseComm.ParentId = caseId ;
               caseComm.commentbody = feedList.body;
                 
        }
        insert caseComm;
            
        
         
       aj = caseComm.Id;
        System.debug('aj==== '+aj);
         List<FeedAttachment> attachments =  [SELECT Id, Title, Type,RecordId, FeedEntityId  FROM FeedAttachment
                                              WHERE FeedEntityId IN :Trigger.new ];
        
   
        for (FeedAttachment attachment : attachments) {
            FeedAttachment feedAttachment = new FeedAttachment();
            
            feedAttachment.FeedEntityId = aj;
            feedAttachment.RecordId = attachment.RecordId; 
            feedAttachment.Title = attachment.Title;
            feedAttachment.Type =attachment.Type; 
             System.debug('feedAttachment '+feedAttachment); 
            insert feedAttachment;
        }
       
        
    } catch(DmlException e) {
        
        System.debug('The following exception has occurred: ' + e.getMessage());  
    }    
    
}
}