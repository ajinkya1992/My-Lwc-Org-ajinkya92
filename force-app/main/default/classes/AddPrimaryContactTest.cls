@isTest 
public class AddPrimaryContactTest  {
      
  @isTest  static void setup() {
     List<Account> acclist =new  List<Account> ();
    for(Integer i=0;i<50;i++){
        acclist.add(new Account(BillingState ='NY',Name='test'+i));
    } 
     for(Integer j=0;j<50;j++){
       acclist.add(new Account(BillingState ='CA',Name='test'+j));
    }
    insert acclist;
    Contact c= new Contact();
        c.FirstName='aj';
        c.LastName='th';
    String State='CA';
    
    AddPrimaryContact ac=new AddPrimaryContact(c, State);
     Test.startTest();        
        System.enqueueJob(ac);
        Test.stopTest();  
     
}
}