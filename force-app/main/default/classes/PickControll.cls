public class PickControll {
 @AuraEnabled 
     public static List<Contact> getPicklistFieldValues(String recId){
     
          return [select Id, Name FROM Contact limit 10];
         
    }
    
    
    @AuraEnabled 
     public static Id getRecId(String recId){
     
        Contact c=new Contact();
         c.LastName='new777';
         insert c;
         System.debug('ssssss '+c);
        return c.Id;
         
    }
     @AuraEnabled 
     public static void saveFileInAcc(String myRecordId,String recordId){
     
        List<Contact> contList=[SELECT Id,Name,AccountId FROM Contact WHERE Id = :recordId ];
            
           
         
          List<ContentDocumentLink> lstContent;
            
            lstContent=[SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :myRecordId ];
          
         for(Integer i=0;i<lstContent.size();i++){
            ContentDocumentLink cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = lstContent[i].ContentDocumentId;//Add ContentDocumentId
            cDocLink.LinkedEntityId = contList[0].AccountId;//Add attachment parentId
            cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
              System.debug('cDocLink '+cDocLink);
            Insert cDocLink;
             
              List<Contact> contList2=[SELECT Id,Name,AccountId FROM Contact WHERE Id = :myRecordId ];
             delete contList2;
         }
    }
    
    
}