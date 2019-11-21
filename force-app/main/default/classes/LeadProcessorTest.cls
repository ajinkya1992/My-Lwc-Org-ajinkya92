@isTest
public class LeadProcessorTest {
@isTest
    
    public static void test(){
        List<Lead> Leadlist = new List<Lead>();
        
        for(Integer i=0;i<200;i++){
        Lead ld   =new Lead();
            ld.LastName='thakre'+i;
            ld.Company='techno';
            ld.Status='randum';
           Leadlist.add(ld); 
        }
         insert Leadlist;
        
        
         Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
    }  
    
    
    
}