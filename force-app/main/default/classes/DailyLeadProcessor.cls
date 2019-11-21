global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead > LeadList  = [SELECT Id  FROM Lead  WHERE LeadSource = null Limit 200];
        List<Lead > Leadlst=new  List<Lead >();
        if(!LeadList.isempty()){
            for(Lead l:LeadList){
                l.LeadSource = 'Dreamforce';
                Leadlst.add(l);
            }
            update Leadlst;
            
        }
        
    }
    
}