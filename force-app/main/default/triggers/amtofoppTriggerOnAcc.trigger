trigger amtofoppTriggerOnAcc on Opportunity (after insert,after update) {
Account acc=new Account();
    list<Account> listacc=new List<Account>();
    double calAmount =0;
    for(Opportunity opp : Trigger.new)
    {
                   acc = [SELECT Id,Total_Amount__c FROM Account WHERE Id= :opp.AccountId];
                   System.debug('Account is=======>> '+ acc);
                   if(acc != null){
                       List<Opportunity> oppListOfAccount = [SELECT Id, Amount FROM Opportunity where AccountId=:acc.Id];
                       System.debug('Opportunities Are=====>> '+ oppListOfAccount);
                       for(Opportunity opportunity : oppListOfAccount){
                           if(Opportunity.Amount != null){
                               calAmount += opportunity.Amount;
                           }
                        }
                        System.debug('**calAmount Are '+ calAmount);
                        acc.Total_Amount__c= calAmount;   
                        listacc.add(acc) ;
                        System.debug('**listacc '+ listacc);
                  
                }
    }
  
if(!listacc.isEmpty()){
try{
update listacc;
}catch(Exception ex){
System.debug(ex);
}
}

}