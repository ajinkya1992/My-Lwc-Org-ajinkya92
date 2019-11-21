public class ContData {
     public  class WraperCont{
        @AuraEnabled 
        public  Contact acc{get;set;}
        @AuraEnabled 
         public  Boolean isselect{get;set;}
        
        public WraperCont(){
            isselect=false;
            
            acc=new Contact(); 
            
        }
    } 
 @AuraEnabled 
     public static List<WraperCont> getCont(String oppId){
           List<WraperCont> wrpacc=new  List<WraperCont>();
        List<Contact> acclist=[select Id, Name,Phone,Email,AccountId FROM Contact where ID = :oppId LIMIT 15];
        
            for(Contact acc1:acclist) {
                WraperCont wrap=new WraperCont();
                wrap.acc=acc1;
                wrpacc.add(wrap) ;
            }
      
        return wrpacc;
         
    }
}