trigger TotalOfCase on Case (after insert ,after update,after delete) {
    Map<String,String> acc_map =new Map<String,String>();
    Double amt =0;
    Double totalAmount =0;
    List<Id> accontList = new List<Id>();
    List<Case> caseList = new List<Case>();
    if(Trigger.isDelete){
        for(Case con : Trigger.old){
            if(con.AccountId != null){
                accontList.add(con.AccountId);
              
            }
        }
    }
    
    if(Trigger.isInsert || Trigger.isUpdate){
        For(Case casobj:Trigger.new ){
          
            if(casobj.AccountId != null){
                acc_map.put(casobj.AccountId, casobj.Id);
                accontList.add(casobj.AccountId);
               /* amt=casobj.Amount__c;
                totalAmount = totalAmount + amt;
                System.debug('totalAmount1---- ' +totalAmount);*/
                
            }
        }
        
    }
    
    caseList =[SELECT  AccountId,Amount__c from Case WHERE AccountId IN : accontList];
    For(Case casobj1:caseList){
        
        amt=casobj1.Amount__c;
        totalAmount = totalAmount + amt;
        System.debug('totalAmount1---- ' +totalAmount);   
        
    }
    List<Account> accListAll = new  List<Account>();
    List<Account> accList =[SELECT Id, Name,Total_Case_Amount__c from Account WHERE Id IN : accontList];
    For(Account accobj:accList ){
        System.debug('totalAmount2---- ' +totalAmount);
         if(totalAmount!= null){
        accobj.Total_Case_Amount__c =totalAmount;
        accListAll.add(accobj);
         }}
    
    try{
        System.debug('accListAll----'+accListAll);
        update accListAll;
    }
    catch(Exception ex){
        System.debug('ex');
    }
}