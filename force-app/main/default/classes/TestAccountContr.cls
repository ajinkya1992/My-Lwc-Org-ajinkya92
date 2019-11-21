@IsTest
public class TestAccountContr {
 @IsTest
    public static void amtofparAcc() {
    
        
        
    Account acc = new Account();
        acc.name='asd';
        acc.industry='asd';
        insert acc;
        
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
       AccountContr accont = new AccountContr(sc) ;
        
        accont.getdata();
    accont.showInfo();
        
    }
}