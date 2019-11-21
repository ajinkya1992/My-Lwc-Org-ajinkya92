trigger CreateCandInfoInPosition on Account (before update) {
Set<Id> ids= new Set<Id>();
    Map<Id,String> maps= new Map<Id,String>();
    for(Account acc:trigger.new){
       ids.add(acc.Id);
        
    }
    
   List<Candidate__c> candList =[select Id,First_Name__c,Account__c,Email_ID__c from Candidate__c where Account__c In:ids]; 

    for(Candidate__c cn:candList){
        for(Account ac1:trigger.new){
            if(ac1.approval_Status__c =='Approved'){
        Position__c posObj=new Position__c();
        posObj.Name=cn.First_Name__c;
        posObj.Company__c=cn.Account__c;
        posObj.Email__c=cn.Email_ID__c;
                System.debug('********  '+posObj);
        insert posObj;
                }
    }
    }
}