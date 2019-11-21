public class SurveyQues2 {
    @AuraEnabled
    public static List<Qwrap> getQuestionAnswer(){
        List<Qwrap> qWrapperlist=new List<Qwrap>();
        List<Demo_Question__c> queList=new  List<Demo_Question__c>();
        
        queList=[Select Id ,Name,Question_Type__c,Question__c ,(Select Id,Name,Answer__c,Answer_Type__c,Demo_Question__c,Radio_Answer_Range__c From Demo_Answers__r) From Demo_Question__c order By Id];
       
        
        for(Demo_Question__c q:queList){
            
            Qwrap qr=new Qwrap(); 
            qr.queObjList=queList;
            qr.queObj=q;
             List<AnsWrapper> ansList1= new List<AnsWrapper>();
            for(Demo_Answer__c a:q.Demo_Answers__r)
            {
               
               AnsWrapper ans=new AnsWrapper();
                ans.AnsObj=a;
                ansList1.add(ans);
                
            }
            qr.ansList=ansList1;
             qWrapperlist.add(qr);
        }
    System.debug('qWrapperlist '+qWrapperlist);
         return qWrapperlist;
    }
        
    

    
    
        
        public class Qwrap{
            @AuraEnabled  public  Demo_Question__c queObj {get; set;}
             @AuraEnabled  public  Demo_SubQuestion__c subqueObj {get; set;}
            @AuraEnabled  public  List<Demo_Question__c> queObjList;
             @AuraEnabled  public  List<Demo_SubQuestion__c> subqueObjList;
            @AuraEnabled  public  	 List<AnsWrapper> ansList {get; set;}
            public Qwrap(){
                 subqueObjList= new List<Demo_SubQuestion__c>();
                queObjList=new  List<Demo_Question__c>();
                queObj=new Demo_Question__c();
                  subqueObj=new Demo_SubQuestion__c();
                ansList=new  List<AnsWrapper>();
            }
        }
    
    
        public class AnsWrapper{
            @AuraEnabled  public  Demo_Answer__c AnsObj{get; set;}
            @AuraEnabled  public boolean selected ;
             @AuraEnabled  public  Demo_SubAnswer__c SubAnsObj{get; set;}
            
            public AnsWrapper(){
                 SubAnsObj =new Demo_SubAnswer__c();
                AnsObj=new Demo_Answer__c();
                selected=false;
            }
        }
    }