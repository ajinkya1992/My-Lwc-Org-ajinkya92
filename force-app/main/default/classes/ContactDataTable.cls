public class ContactDataTable {
    class WraperCont{
        @AuraEnabled 
        public Contact cont{get;set;}
        @AuraEnabled 
        public Boolean isselectforCont{get;set;}
        public WraperCont(){
            isselectforCont=true;
            Contact cont = new Contact();
        }
         
    }
    
    
    
     @AuraEnabled 
    public static List<WraperCont> showContacts(){
        List<WraperCont> conWrapList =new  List<WraperCont>();
        List<Contact> conlist = [SELECT FirstName,LastName,AccountId,Id from Contact LIMIT 15];
        if(conlist != null && conlist.size()>0){
        for(Contact conObj :conlist){
            WraperCont conwrp = new WraperCont();
           conwrp.cont =conObj;
           conWrapList.add(conwrp);
        }
            }
        return conWrapList;
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
    
     @AuraEnabled 
    public static List<WraperBooking> showbooking(Id ConId){
        List<WraperBooking> bookingList =new  List<WraperBooking>();
        List<Show_Booking__c> bookList = [select Id, Name,Amount__c, Calculated__c,Description__c,Contact__c FROM Show_Booking__c Where Contact__c =:ConId   LIMIT 15];
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
    
    
    
}