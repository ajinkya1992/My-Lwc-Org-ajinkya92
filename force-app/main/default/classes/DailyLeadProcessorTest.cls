@isTest
public class DailyLeadProcessorTest {
@testSetup
    static  void  setup() {
        List<Lead> Leads=new List<Lead>(); 
        for (Integer i = 0; i < 200; i++) {
         Lead d=   new Lead(
                 LastName='Dream force'+i,Company='NY'+i );
           Leads.add(d) ;
        }
        insert Leads;
     
    }
    
    static testMethod void testScheduledJob(){
         String CRON_EXP='0 5 12 * * ?';

      Test.startTest();

    String jobId = System.schedule('ScheduledApexTest',CRON_EXP, new DailyLeadProcessor());  
         List<Lead > LeadList1  = [SELECT Id  FROM Lead  WHERE LeadSource = null LIMIT 200];
        System.assertEquals(200, LeadList1.size());
    Test.stopTest();
    }
    
   
}