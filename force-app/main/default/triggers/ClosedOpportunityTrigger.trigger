trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

          
    List<Task> taskList = new List<Task>();
    // Iterate over the related opportunities
    for(Opportunity opp : Trigger.New) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.StageName =='Closed Won') ) {
           Task t=new Task();
            t.subject='Follow Up Test Task';
            t.WhatId=opp.Id;
            
            taskList.add(t);
        }
    }
    if(taskList.size() >0){
        
     insert   taskList;
    }
    // Perform DML on a collection
   
}