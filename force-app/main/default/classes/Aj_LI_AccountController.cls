public class Aj_LI_AccountController {
    //@AuraEnabled
    /*public static List<Account> getAccountNew(){
List<Account> accountList=new List<Account>();
accountList=[Select id,name from Account  limit 10];
return accountList;
}*/
    
    @AuraEnabled
    public static List<WraperBooking> wrpbookingtg {set;get;}

    @AuraEnabled
    public static List<WraperCont> wrpaCont {set;get;}
    @AuraEnabled
    public static List<Contact> contlist{get;set;}
    @AuraEnabled
    public static List<WraperAccount> wrpacc {set;get;}
    @AuraEnabled 
    List<Account> acclist{get;set;}
    @AuraEnabled 
    public boolean check{get;set;}
    
    public  class WraperAccount{
        @AuraEnabled 
        public  Account acc{get;set;}
        @AuraEnabled 
         public  Boolean isselect{get;set;}
        
        public WraperAccount(){
            isselect=false;
            
            acc=new Account(); 
            
        }
    } 
    
    public class WraperCont{
        @AuraEnabled 
        List<WraperCont> accWrapList{get;set;}
        @AuraEnabled 
        public Contact cont{get;set;}
        @AuraEnabled 
        public Boolean isselectforCont{get;set;}
        
        public WraperCont(){
            accWrapList=new  List<WraperCont>();
            isselectforCont=false;
            
            cont=new Contact();
        }
    } 
    
   
   public class WraperBooking{
        @AuraEnabled 
        List<WraperBooking> bookWrapList{get;set;}
        @AuraEnabled 
        public Show_Booking__c book{get;set;}
       
        @AuraEnabled 
        public Boolean isselectbook{get;set;}
        
        public WraperBooking(){
            bookWrapList=new  List<WraperBooking>();
            isselectbook=true;
            
            book=new Show_Booking__c();
        }
    }  
    
    
    /* public Aj_LI_AccountController(ApexPages.StandardController controller){
wrpacc=new List<WraperAccount>();
List<Account> acclist= new List<Account>();
wrpaCont=new List<WraperCont>();
} */
     
    
    @AuraEnabled
    public static List<WraperAccount> getAcc(){
        List<WraperAccount> wrpacc=new  List<WraperAccount>();
        List<Account> acclist=[select Id, Name,AccountNumber, ParentId FROM Account where ID IN (Select AccountId from Contact) LIMIT 15];
        
            for(Account acc1:acclist) {
                WraperAccount wrap=new WraperAccount();
                wrap.acc=acc1;
                wrpacc.add(wrap) ;
            }
      
        return wrpacc;
    }
    @AuraEnabled 
    public static List<WraperCont> showContacts(String accWrapList ){
        System.debug('accWrapList===='+accWrapList);
        List<WraperCont> wrpaCont=new  List<WraperCont>();
        List<WraperAccount> accid1=(List<WraperAccount>)System.JSON.deserialize(accWrapList,List<WraperAccount>.class);
        System.debug('accid1============'+accid1);
        Set<Id> accid=new  Set<Id>();
        for(WraperAccount wrp1:accid1){
            if(wrp1.isselect==true){
                accid.add(wrp1.acc.id);   
            }
        }
        
        if(!accid.isEmpty()){
            contlist=[Select FirstName,AccountId, LastName, Phone,Email From Contact Where AccountId In :accid];
            
            System.debug('contlist============'+contlist);
            
            if(!contlist.isEmpty()){
                for(Contact acc2:contlist) {
                    WraperCont wrap2=new WraperCont();
                    wrap2.cont=acc2;
                    wrpaCont.add(wrap2);
                }
            }
            
        }
        return wrpaCont; 
    }  
    
    
    @AuraEnabled
    public static List<WraperBooking> getBooking(String allconBooktIdList){
        
        List<WraperBooking> bookingList = new  List<WraperBooking>();
        List<Show_Booking__c> bookList=[select Id, Name,Amount__c, Calculated__c,Description__c,Contact__c FROM Show_Booking__c Where Contact__c =:allconBooktIdList   LIMIT 15];
        System.debug('bookList===1=>>> '+bookList);
        
        for(Integer i=0;i<bookList.size();i++){
            System.debug('bookList[i]====>>> '+bookList[i]);
            WraperBooking wrapBlist=new WraperBooking();
            if(i>0){
                if((bookList[i].Calculated__c == bookList[i-1].Calculated__c) &&(bookList[i].Amount__c=='0')){
                    wrapBlist.isselectbook =false;
                } else{
                    wrapBlist.isselectbook =true;
                }  
            }else{
                 if((bookList[i].Calculated__c == '0') && (bookList[i].Amount__c=='0')){
                    wrapBlist.isselectbook =false;
                } else{
                    wrapBlist.isselectbook =true;
                }  
            }
           
            wrapBlist.book=bookList[i];
            System.debug('wrapBlist====>>> '+wrapBlist);
            bookingList.add(wrapBlist);
            
        }
        System.debug('bookingList====>>> '+bookingList);
        
        return bookingList;
    }  
    
    
    
   
     @AuraEnabled  
   public static void saveBooking1(String Listbook,String ConId){
         List<Show_Booking__c> bookobjList=new   List<Show_Booking__c>();
        
        List<WraperBooking> BookList = (List<WraperBooking>)System.JSON.deserialize(Listbook,List<WraperBooking>.class);
        System.debug('BookList== '+BookList);
        System.debug('ConId== '+ConId);
        set<ID> con=new  set<ID>();
        
        
        for(WraperBooking B:BookList)
        {  
            B.book.Contact__c=ConId;
            
            //con.add(B.book.id);
        }
       for(WraperBooking b:BookList)
       {
           Show_Booking__c ansObj=new Show_Booking__c();
           if((b.book.Id)!=null){
              ansObj.Id=b.book.Id; 
           }
           
           ansObj.Amount__c=b.book.Amount__c;
           ansObj.Description__c =b.book.Description__c;
           ansObj.Calculated__c=b.book.Calculated__c;
           ansObj.Contact__c=B.book.Contact__c;
           bookobjList.add(ansObj);
           System.debug('bookobjList== '+bookobjList);
       }
       
         System.debug('final  bookobjList== '+bookobjList);
   if (!bookobjList.isEmpty()) {
        upsert bookobjList;
   }
      List<Show_Booking__c> Instance =[SELECT Id ,Contact__c FROM Show_Booking__c WHERE Id NOT IN :bookobjList and Contact__c=:ConId];
       delete Instance;
        
    }
    
    
    
    
     @AuraEnabled  
     public static void saveBooking(String Listbook,String ConId){
         System.debug('hiiiiiiiiii== ');
         
         List<Show_Booking__c> bookobjList=new   List<Show_Booking__c>();
        
          List<Show_Booking__c> Instance =[SELECT Id ,Amount__c,Description__c,Contact__c,Calculated__c FROM Show_Booking__c WHERE  Contact__c=:ConId];
         
        List<WraperBooking> BookList = (List<WraperBooking>)System.JSON.deserialize(Listbook,List<WraperBooking>.class);
        System.debug('BookList== '+BookList);
        System.debug('ConId== '+ConId);
        set<ID> con=new  set<ID>();
        
        for(WraperBooking B:BookList)
        {  
            B.book.Contact__c=ConId;
            
            //con.add(B.book.id);
        }
         set<Id> ids=new set<Id>();
         
         for(WraperBooking b:BookList)
         {
             for(Show_Booking__c b1:Instance)
             {
                 if(b.book.Id == b1.Id){
                     if(b.book.Amount__c !=b1.Amount__c){
                         ids.add(b1.Id); 
                           System.debug('inner ids'+ids);
                             }
                 }
                 
                 
             }
         }
         System.debug('ids'+ids);
      List<Show_Booking__c> Instance1 =[SELECT Id,Amount__c  FROM Show_Booking__c WHERE Id In:ids and Contact__c=:ConId];
       delete Instance1;
         System.debug('delete'+Instance1);
         
           List<Show_Booking__c> bookobjList1=new   List<Show_Booking__c>();
         
         
          for(WraperBooking b:BookList)
         {
             for(Show_Booking__c b1:Instance)
             {
                 if(b.book.Id == b1.Id){
                     if(b.book.Amount__c !=b1.Amount__c){
                         Show_Booking__c ansObj=new Show_Booking__c();
                         
                         
                         ansObj.Amount__c=b.book.Amount__c;
                         ansObj.Description__c =b.book.Description__c;
                         ansObj.Calculated__c=b.book.Calculated__c;
                         ansObj.Contact__c=B.book.Contact__c;
                         bookobjList1.add(ansObj);
                         
                             }
                 }
                 
             }
         }
         if (!bookobjList1.isEmpty()) {
             insert bookobjList1;
               System.debug('bookobjList1 insert'+bookobjList1);
         }
         
}
}