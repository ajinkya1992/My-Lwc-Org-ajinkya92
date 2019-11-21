trigger attachmentCaseToWork on Attachment (after insert) {
     System.debug('bfor ');
 Set<ID> attId = new Set<ID>();
    Set<ID> casetID = new Set<ID>();
    /* ******This block collects all the attachment IDs*****************/
    for(Attachment att : trigger.New){
         //Check if added attachment is related to Contact or not
         if(att.ParentId.getSobjectType() == Case.SobjectType){
              attId.add(att.Id);
              casetID.add(att.ParentId);
               System.debug('after ');
           
         }
    }	
    /*****************************************/

    /*******************Below block creates the attachment on Account***************/
    list<attachment> workatt=new list<attachment>();
    List<Attachment> attachmentList = [SELECT Name, Id, ParentID,Body FROM Attachment WHERE ID IN :attID];
    Map<Id, Case> casetDetailMap = new Map<Id, Case>([Select Id, agf__ADM_Work__r.id from Case where Id IN :casetID]);
    for(Attachment att: attachmentList) {
        Attachment newFile = new Attachment(Name = att.name, body = 
        att.body,ParentId= casetDetailMap.get(att.ParentID).agf__ADM_Work__c);
        workatt.add(newFile);
        System.debug('workatt '+workatt);
    }

    if(workatt.size()>0){
     insert workatt;
    // DeleteAttachmentsForContact.deleteAttachment(attId); //Add this line if you want to delete the attachment from Contact Object
    }
}