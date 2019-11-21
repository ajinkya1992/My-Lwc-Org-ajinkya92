trigger totalAmount on Opportunity (after insert,after update,after delete) {
     String day = string.valueOf(system.now().day());

        String month = string.valueOf(system.now().month());

        String hour = string.valueOf(system.now().hour());

        String minute = string.valueOf(system.now().minute() + 5);

        String second = string.valueOf(system.now().second());

        String year = string.valueOf(system.now().year());

        String IndustryName = 'Industry' + second + '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;

        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;

      

     if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
          //  UpdateAmtAccParent.TotalOfOppAmt(Trigger.new);
           System.debug('IndustryName====='+IndustryName+'   strSchedule===='+strSchedule);
              System.schedule(IndustryName, strSchedule, new TestSchedularfor5min());
            
        
        }  
   
    
     if(Trigger.isDelete){
           UpdateAmtAccParent.deleteAcc(Trigger.old);
    }
      
     } 
}
  /*  List<Account> accList=new list<Account>();
    List<Opportunity> opplist=new list<Opportunity>(Trigger.new);
    decimal amt=0;
      if(Trigger.isAfter){
    //  System.debug('opplist==='+opplist);
    if(Trigger.isInsert || Trigger.isUpdate ){
        
        if(!opplist.isEmpty()){
            for(Opportunity opt:opplist){
                
                AggregateResult[] grpResult=[SELECT SUM(Amount)amt from Opportunity WHERE AccountId=:opt.AccountId];    
                amt=(decimal)grpResult[0].get('amt');
                
                for(Account acc:[SELECT Id from Account where Id=:opt.AccountId]){
                    Account ac1=new Account();
                    ac1.Id=acc.Id;
                    ac1.Total_Amount__c =amt;
                    accList.add(ac1);
                }
                if(!opplist.isEmpty()){
                    try{
                        update accList;
                    }
                    catch(Exception ex){
                        System.debug(ex);
                    }
                }
                
            }
            
        }  
        
    }
      } */
    
    
  /*  if(Trigger.isAfter){
 
    if(Trigger.isInsert || Trigger.isUpdate ){ 
    
   Set<Id> accids=new  Set<Id>();
  List<Account> acclist=new  List<Account>();
    for(Opportunity op:Trigger.new){
        accids.add(op.Id);
    }
    
    List<AggregateResult> grpResult=[SELECT SUM(Amount) totalamt, AccountId from Opportunity WHERE AccountId=:accids Group By AccountId];    
    
    for(AggregateResult arg:grpResult)  {
     id ids=(ID)arg.get('AccountId');
        if(ids != null){
         Account aca =new Account(id=ids);
            aca.Total_Amount__c=((Decimal)arg.get('totalamt'));
            
            acclist.add(aca);
        }
    }  
    
    
     try{
                update acclist;
            }
            catch(Exception ex){
                System.debug(ex);
            } 
    }
        
        
   
}*/