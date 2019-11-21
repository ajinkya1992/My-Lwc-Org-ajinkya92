public class FetchAccountRelCont {
    
      @AuraEnabled
    public static void test(){
        
        Map<Id,Id> mapval = new Map<Id,Id>();
        List<Map<Id,Id>> listOfMap= new   List<Map<Id,Id>>();
            List<Contact> contList = new List<Contact>();
         List<Account> accList = new List<Account>();
  
  
         accList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) From Account];
       
          for(Account acc :accList){
              for(Contact con :acc.Contacts){
               mapval.put(acc.Id,con.Id);
              }
    } 
        listOfMap.add(mapval);
        
    
    }
  
}