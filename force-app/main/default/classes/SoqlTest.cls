public class SoqlTest {
    public List<WraperAccount> wrpacc {set;get;}
     public List<WraperCont> wrpaCont {set;get;}
    public List<Contact> contlist{get;set;}
   public boolean check{get;set;}
    
   public class WraperAccount{
      public Account acc{get;set;}
     
      public Boolean isselect{get;set;}
   
       public WraperAccount(){
           isselect=false;
         
           acc=new Account(); 
         
       }
    }
    public class WraperCont{
     
       public Contact cont{get;set;}
    
       public Boolean isselectforCont{get;set;}
       public WraperCont(){
        
           isselectforCont=false;
         
            cont=new Contact();
       }
    }
    
    
    public SoqlTest(ApexPages.StandardController controller){
        wrpacc=new List<WraperAccount>();
        List<Account> acclist=[select Id, Name,AccountNumber, AnnualRevenue from Account ];
        if(!acclist.isEmpty()){
            for(Account acc1:acclist) {
                WraperAccount wrap=new WraperAccount();
                wrap.acc=acc1;
                wrpacc.add(wrap) ;
            }
        }
    } 
    
    public  void showContact(){
        
           wrpaCont=new List<WraperCont>();
      Set<Id> accid=new  Set<Id>();
        for(WraperAccount wrp1:wrpacc){
            if(wrp1.isselect){
             accid.add(wrp1.acc.id);   
            }
        }
        
        if(!accid.isEmpty()){
            contlist=[Select FirstName, LastName, Phone,Email,AccountId From Contact Where AccountId In :accid];
           
            System.debug('contlist============'+contlist);
            
            if(!contlist.isEmpty()){
            for(Contact acc2:contlist) {
                WraperCont wrap2=new WraperCont();
                wrap2.cont=acc2;
                wrpaCont.add(wrap2) ;
            }
        }
           
        }
         
    }
    
    public  void SendEmail() {
 //List<contact> lstcon=[Select id from Contact limit 2];
   System.debug('wrpaCont======='+wrpaCont);
  List<Id> lstids= new List<Id>();
       
          for(WraperCont wrp2:wrpaCont){
             if(wrp2.isselectforCont){
             lstids.add(wrp2.cont.id);   
            }       
         
       }
        if(lstids.size()>0){
               System.debug('lstids======='+lstids);
              EmailTemplate et=[Select id from EmailTemplate where name = 'Sales: New Customer Email' limit 1];
       
         Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
           
           mail.setTargetObjectIds(lstids);
           
          
           
           mail.setTemplateId(et.id);
           
           Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
        }
    
      
   }
    
   
    
    
    }