@IsTest
public class TestAj_LI_AccountController {
    
    
    @IsTest
    public static void amtofparAcc() {
        
        Set<Id> accid=new  Set<Id>();     
        
        
        
        Account acc1= new Account();
        acc1.Name ='HCL';
        insert  acc1;
        
        List<Account> acclit  = new  List<Account>();
        acclit.add(acc1);
        
        Contact con = new Contact();
        con.FirstName ='ajinkya';
        con.LastName ='th';
        con.Phone ='654646656';
        con.Email ='aj@jjf.com';
        
        con.AccountId = acc1.Id;
        insert con;
        List<Id> conList =new  List<Id>();
        
        Show_Booking__c book= new Show_Booking__c();
        book.Amount__c='1000';
        insert book; 
        
        
        
        List<Id> actList = new List<Id>();
        actList.add(acc1.Id);
        
        Aj_LI_AccountController.WraperBooking wraperBook = new Aj_LI_AccountController.WraperBooking();
        wraperBook.isselectbook = true;
        wraperBook.book =book ;
        
        
        List<Aj_LI_AccountController.WraperBooking> wrpblist = new List<Aj_LI_AccountController.WraperBooking>();
        wrpblist.add(wraperBook);
        String wrpblistjson = JSON.serialize(wrpblist);
        
        Aj_LI_AccountController.WraperCont wraperCon = new Aj_LI_AccountController.WraperCont();
        List<Aj_LI_AccountController.WraperCont> wrpaContlist ;
        wraperCon.isselectforCont = true;  
        wraperCon.cont =con; 
        
        //  string output = JsonConvert.SerializeObject(acclit);
        String gCalJSON = JSON.serialize(acclit);
        
        conList.add(con.Id);
        String conjson = JSON.serialize(conList);
      
        Aj_LI_AccountController.getAcc();
        List<Contact> contlist;
      
        Aj_LI_AccountController.WraperAccount wraperAcc = new Aj_LI_AccountController.WraperAccount();
        wraperAcc.acc = acc1;
        wraperAcc.isselect =true;
        List<Aj_LI_AccountController.WraperAccount> aWrapList=new  List<Aj_LI_AccountController.WraperAccount>();
        aWrapList.add(wraperAcc);
         String aWrapJSON = JSON.serialize(aWrapList);
        
        System.debug('wraperAcc-->>'+wraperAcc);
        Aj_LI_AccountController.showContacts(aWrapJSON);
        
        Aj_LI_AccountController.saveBooking(wrpblistjson, wraperCon.cont.Id) ; 
          Aj_LI_AccountController.getBooking(wraperCon.cont.Id) ;   
        
        
        
    }
    
    
    
}