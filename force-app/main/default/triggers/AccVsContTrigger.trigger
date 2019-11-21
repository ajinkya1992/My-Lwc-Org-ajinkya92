trigger AccVsContTrigger on Account (before insert,before update) {
   Map<String,String> acc_map = new  Map<String,String>();
    List<String> accList = new  List<String>();
    for(Account accobj:trigger.new){
        if(accobj.Description !=  trigger.oldMap.get(accobj.Id).Description){
            System.debug('trigger.oldMap.get(accobj.Id).Description=== '+trigger.oldMap);
            accList.add(accobj.Id);
            acc_map.put(trigger.oldMap.get(accobj.Id).Description, accobj.Description);
        }
        
        List<Case> caseList =[Select Id , Description,AccountId from Case Where AccountId IN :accList ];
         System.debug('caseList'+caseList);
        if(caseList != null && caseList.size()>0){
        for(Case cs:caseList){

        cs.Description =acc_map.get(cs.Description);
             System.debug('cs.Description'+cs.Description);
        update cs;
        
        }
        }
    }
    
}