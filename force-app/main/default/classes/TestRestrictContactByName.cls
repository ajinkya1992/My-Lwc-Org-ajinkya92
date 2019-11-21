@isTest
public class TestRestrictContactByName {
    
     @isTest static void testTestRestrictCont(){
        Contact c = new Contact(LastName = 'INVALIDNAME');
        Test.startTest();
         try{
             insert c;
          
            }catch(Exception e){
              Test.stopTest();
         }   
         
          
       
       
    }
}