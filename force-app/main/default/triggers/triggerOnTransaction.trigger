trigger triggerOnTransaction on Transaction__c (after insert) {
    List<String> trsnList=new  List<String>();
    for(Transaction__c tr:trigger.new){
        trsnList.add(tr.Merchandise__c);
    }

     Map<id,String> revMap=new  Map<id,String>();
     Map<Id,Decimal> discMap=new  Map<id,Decimal>();
    for(Merchandise__c mr:[SELECT Id,Discounted_Prise__c,overall_revenue__c from Merchandise__c WHERE Id IN:trsnList]){
        discMap.put(mr.Id, mr.Discounted_Prise__c);
         revMap.put(mr.Id, mr.overall_revenue__c);
    }
    
      for(Transaction__c tr:trigger.new){
      Merchandise__c mar=new Merchandise__c();
          mar.overall_revenue__c =String.valueOf(tr.Amount__c * discMap.get(tr.Merchandise__c));
          mar.Id=tr.Merchandise__c;
          update mar;
    }
    
}