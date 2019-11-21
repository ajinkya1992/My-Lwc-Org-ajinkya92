@IsTest
public class TestFetchAccountRelCont {
 @IsTest
    public static void amtofparAcc() {
        
     Account acc= new Account();
        acc.Name='as';
        insert acc;
        
     Contact con=new Contact();
       con.FirstName='sad';
        con.LastName='adssa';
        con.AccountId=acc.Id;
        insert con;
      FetchAccountRelCont.test();  
        
    }
}