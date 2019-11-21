public class CnadidateData {
    
    public class WraperCont{
        @AuraEnabled 
        List<WraperCont> accWrapList{get;set;}
        @AuraEnabled 
        public Contact cont{get;set;}
        @AuraEnabled 
        public Boolean isselect{get;set;}
        
        public WraperCont(){
            accWrapList=new  List<WraperCont>();
            isselect=false;
            
            cont=new Contact();
        }
    } 
    
  public class WraperContNew{
        @AuraEnabled 
        List<WraperContNew> accWrapList{get;set;}
        @AuraEnabled 
        public Contact cont{get;set;}
       @AuraEnabled 
        public List<Contact> contLt{get;set;}
        @AuraEnabled 
        public Boolean isselect{get;set;}
        
        public WraperContNew(){
            contLt=new  List<Contact>();
            accWrapList=new  List<WraperContNew>();
            isselect=false;
            
            cont=new Contact();
        }
    } 
    
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
      
    
    
  @AuraEnabled
    public static Map<String,Object> getAccndopp(){
         Map<String,Object> mapOfObj= new Map<String,Object>();
        List<WraperAccount> wrpacc=new  List<WraperAccount>();
        List<Account> acclist=[select Id, Name,AccountNumber, ParentId FROM Account where ID IN (Select AccountId from Contact) LIMIT 15];
        
            for(Account acc1:acclist) {
                WraperAccount wrap=new WraperAccount();
                wrap.acc=acc1;
                wrpacc.add(wrap) ;
            }
        
      mapOfObj.put('AccWrp', wrpacc);
        
        return mapOfObj;
    }
    
    
     @AuraEnabled
    public static Map<String,Object> getCont(String accWrapList){
        System.debug('accWrapList============'+accWrapList);
         Map<String,Object> mapOfObj= new Map<String,Object>();
       List<WraperAccount> accid1=(List<WraperAccount>)System.JSON.deserialize(accWrapList,List<WraperAccount>.class);
        System.debug('accid1============'+accid1);
        Set<Id> accid=new  Set<Id>();
        for(WraperAccount wrp1:accid1){
            if(wrp1.isselect==true){
                accid.add(wrp1.acc.id);   
            }
        }
         System.debug('accid============'+accid);
         List<WraperCont> wrpaCon=new  List<WraperCont>();
        List<Contact> Contlist=[select Id, Name,Email FROM  Contact  where AccountId=:accid LIMIT 15];
        
            for(Contact acc1:Contlist) {
                WraperCont wrap=new WraperCont();
                wrap.cont=acc1;
                wrpaCon.add(wrap) ;
            }
        System.debug('wrpaCon============'+wrpaCon);
        mapOfObj.put('ContList', wrpaCon);
     
        return mapOfObj;
    }
    
    
       @AuraEnabled
    public static Map<String,Object> getNewCont(String newWrapList){
       
         Map<String,Object> mapOfObj= new Map<String,Object>();
       List<WraperContNew> accid1=(List<WraperContNew>)System.JSON.deserialize(newWrapList,List<WraperContNew>.class);
        System.debug('accid1============'+accid1);
        Set<Id> ContIdSet=new  Set<Id>();
        for(WraperContNew wrp1:accid1){
            if(wrp1.isselect==true){
                ContIdSet.add(wrp1.cont.id);   
            }
        }
         System.debug('ContIdSet============'+ContIdSet);
         List<WraperContNew> wrpaCon=new  List<WraperContNew>();
        List<Contact> Contlist=[select Id, Name,Email,Stage__c FROM  Contact  where Id=:ContIdSet LIMIT 15];
        
            for(Contact acc1:Contlist) {
                WraperContNew wrap=new WraperContNew();
                wrap.cont=acc1;
                wrpaCon.add(wrap) ;
            }
         List<String> stageList=getPicklistFieldValues('Contact', 'Stage__c');
        System.debug('wrpaCon============'+wrpaCon);
        mapOfObj.put('NewContList', wrpaCon);
        mapOfObj.put('stagePicklist', stageList);
     
        return mapOfObj;
    }
    
    
      public static List<String> getPicklistFieldValues(String objectName, String pickListFieldName){
        List<String> picklistValues = new List<String>();
        SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        List<Schema.PicklistEntry> pick_list_values = objectType.getDescribe().fields.getMap().get(pickListFieldName).getDescribe().getPickListValues();
        for (Schema.PicklistEntry aPickListValue : pick_list_values) {                   
            picklistValues.add(aPickListValue.getValue()); 
        }
        return picklistValues;
    }
    
      @AuraEnabled
    public static void saveContacts(String filteredEmpWrapp){
 
        List<WraperContNew> ContWrapLsit= (List<WraperContNew>)JSON.deserialize(filteredEmpWrapp, List<WraperContNew>.class);
        System.debug('ContWrapLsit==>>'+ContWrapLsit);
          List<Contact> ContList=new List<Contact>();
        
      /*   for(WraperContNew B:ContWrapLsit)
         {
        
            Contact ContObj=new Contact();
             ContObj.Id=B.cont.Id;
             ContObj.Stage__c=B.cont.Stage__c;
             
             ContList.add(ContObj);
         
         }*/
        for(integer i=0;i<ContWrapLsit.size();i++){
            if(ContWrapLsit[i].isselect == true){
             Contact ContObj=new Contact();
             ContObj.Id=ContWrapLsit[i].cont.Id;
             ContObj.Stage__c=ContWrapLsit[i].cont.Stage__c;
             
             ContList.add(ContObj);
            }
        }
        
        
        
       
        if(!ContList.isEmpty()){
             System.debug('ContList==>>'+ContList);
            update ContList;
        }
        
    }
}