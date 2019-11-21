global class TestSchedular implements Database.Batchable<SObject>{
       global final String query;
    global final String field;
    global final String value;
    global final String s_object;
    
    public TestSchedular(String q,String f,String v,String o){
        query=q;
        field=f;
        value=v;
        s_object=o;
    }
global Database.QueryLocator Start(Database.BatchableContext bc){
 
return Database.getQueryLocator(query);
 
   } 
   
   global void execute(Database.BatchableContext Bc, List<SObject> batch) {
        
       for(SObject o:batch){
           o.put(field, value);
       }update 	batch;
   } 
   
     global void finish(Database.BatchableContext Bc) {
       
   }
}