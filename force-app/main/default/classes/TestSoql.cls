@IsTest
public class TestSoql {
    @IsTest
    public static void getSoqlwer() {
       
        Account acc= new Account();
        acc.Name='hcl';
       acc.AccountNumber='12123';
          acc.AnnualRevenue= 232;
        insert acc;
        Contact con = new Contact();
        con.FirstName='mr';
       con.AccountId =acc.id;
        con.Phone ='432432';
           con.Email='aj@jh.com';
        Con.LastName='ajt';
        insert con;
       
       
         ApexPages.StandardController sc = new ApexPages.StandardController(acc);
   
      /*  List<SoqlTest.WraperAccount> wrpAcclist = new    List<SoqlTest.WraperAccount>();
        
      SoqlTest.WraperAccount wrpAcc =new  SoqlTest.WraperAccount();
        
        for(Account AccTest : [SELECT Id, Name,AccountNumber, AnnualRevenue from Account ]){
          wrpAcc =new  SoqlTest.WraperAccount();
            wrpAcc.acc=AccTest;
            wrpAcclist.add(wrpAcc);
            
        }*/
        
        
        SoqlTest WE= new SoqlTest(sc);
        WE.wrpacc[0].isselect=true;
      /*   Set<Id> accid=new  Set<Id>();
        for(SoqlTest.WraperAccount WATest :wrpAcclist)
            
        {
            if(WATest.isselect){
             accid.add(wrpAcc.acc.id);   
            }
        }
        
         
         SoqlTest.WraperCont wrpcon =new   SoqlTest.WraperCont();
        
     
        List<SoqlTest.WraperCont> wrpconlist = new    List<SoqlTest.WraperCont>();
       
        for(Contact con1 : [Select FirstName, LastName,AccountId, Phone,Email From Contact Where AccountId = :accid]){
           
            wrpcon.cont=con1;
            wrpconlist.add(wrpcon);
            
        }*/
       WE.showContact();
     WE.wrpaCont[0].isselectforCont=true;
         
      /*   List<Id> lstids= new List<Id>();
       // SoqlTest.WraperCont.isselectforCont = true;
        for(SoqlTest.WraperCont WATest :wrpconlist)
            
        {
           
            if(WATest.isselectforCont){
            lstids.add(WATest.cont.id);  
            }
        }
System.debug('lstids==='+lstids);*/
        
        WE.SendEmail();
        
      
        
    }

  
    }