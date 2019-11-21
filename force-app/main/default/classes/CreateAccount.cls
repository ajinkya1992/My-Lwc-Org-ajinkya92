public class CreateAccount {
@AuraEnabled 
    public static Id saveAccData(String description,String phoneField, String approvalstatus,String type,String Industry,String accName,Id recId ){
       
         List<Account> accList;
       System.debug('accName '+accName);
          System.debug('recTypeId '+recId);
        accList=[SELECT Id, Name, OwnerId FROM Account WHERE Id =:recId LIMIT 1];
         Account accobj = new Account();
     // if(accList != null && accList.size() > 0)
     //   {
       
        accobj.Name = accName;
        accobj.Description = description;
        accobj.Phone = phoneField;
        accobj.Type = type;
        accobj.Industry = Industry;
       accobj.approval_Status__c =approvalstatus ;
    
        
       System.debug('accobj'+accobj); 
     insert accobj;
      
   //}
        return accobj.Id;
    }
     @AuraEnabled 
    public static user fetchUser(){
     // query current user information  
      User oUser = [select id,Name,TimeZoneSidKey,Username,Alias,Country,Email,FirstName,LastName,IsActive,IsPortalEnabled 
                 FROM User Where id =: userInfo.getUserId()];
        return oUser;
    }
}