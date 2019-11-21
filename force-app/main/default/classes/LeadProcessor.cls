global  class LeadProcessor implements Database.Batchable<sObject> {
    
    // instance member to retain state across transactions
    global Integer count = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id,LeadSource from Lead');
            }
        
        
        global void execute(Database.BatchableContext bc, List<Lead> lpp){
              List<Lead> Leadlist = new List<Lead>();
            for(Lead lld:lpp){
                
            lld.LeadSource='Dreamforce';
                Leadlist.add(lld);
                count++;
            }
           update Leadlist;
            
        }
    
    global void finish(Database.BatchableContext bc){
        System.debug('lead'+count);
    }
}