trigger CreateContBaseOnLocationsOfAcc on Account (after insert ,after update) {
Map<Id,Decimal> Accmap =new Map<Id,Decimal>();
 List<Contact> contlist=new    List<Contact>();
    
    for(Account ac:trigger.new){
        Accmap.put(ac.Id, ac.Number_of_Locations__c);
    }
   if(Accmap !=null && Accmap.size()>0)
    for(Id accid:Accmap.keySet()){
        for(Integer i=0;i<Accmap.get(accid);i++){
           Contact cont=new Contact();
            cont.AccountId =accid;
            cont.LastName='tempCont'+i;
            contlist.add(cont);
          
        }           
    }
    if(contlist !=null && contlist.size()>0)
        System.debug('contlist******'+contlist);
     insert contlist; 
    
}