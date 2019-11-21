public class SaveAccDetails {
@AuraEnabled
    public static void saveAcc(String nameId,String LnameId,String AddressId,String phnId){
       
        
        Account acc= new Account();
        acc.Name=nameId;
        acc.Phone=phnId;
       System.debug('acc   '+acc);
       insert acc;
        
    }
    
    
  
}