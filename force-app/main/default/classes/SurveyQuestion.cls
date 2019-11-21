public class SurveyQuestion {
    @AuraEnabled
    public static List<QuestionWrapper> queWrap{ set;get;}   
    @AuraEnabled
    public static List<QuestionWrapper> getQuestions(){
        queWrap=new List<QuestionWrapper> ();
        
        List<Question_Sur__c> QuestionList=new  List<Question_Sur__c>();
        
        QuestionList=[SELECT Id, Name, Question_Type__c,Questions__c,(SELECT Id,Name,Answe__c,Question__c,Radio_Answer_Range__c,Answer_Type__c, Sub_Question__c,From_Detractors__c,To_Dtractors__c,Passives_Range_From__c,Passives_Range_To__c,Promoters_Range_From__c,Promoters_Range_To__c FROM Answers_Sur__r) FROM Question_Sur__c];
        System.debug('QuestionList '+QuestionList);
        for(Question_Sur__c questionObj : QuestionList)
        {
            QuestionWrapper wrap = new QuestionWrapper();
            wrap.queObj = questionObj ;
            wrap.Question_Type=questionObj.Question_Type__c;
            
            wrap.Ques=questionObj.Id;
            for(Answer_Sur__c ans:questionObj.Answers_Sur__r)
            {  
                wrap.Ans=ans.Question__c;
                wrap.ansOpt.add(ans);
                wrap.Answer_Type=ans.Answer_Type__c;
                wrap.AnsName=ans.Name;
                wrap.SubQuess=ans.Sub_Question__c;
                wrap.Answe=ans.Answe__c;
                
                wrap.option=ans.Radio_Answer_Range__c;
            }
            queWrap.add(wrap);
        }
        
        System.debug('queWrap-->'+queWrap);
        return queWrap;
        
    }
    
    
    public class QuestionWrapper{
        @AuraEnabled       List<Answer_Sur__c> ansOpt{get;set;}
        @AuraEnabled  public  List<Question_Sur__c> QueList{get; set;}
        @AuraEnabled    Question_Sur__c queObj{get; set;}
        @AuraEnabled  public String Answer_Type{get; set;}
        @AuraEnabled  public String Ques{get; set;}
        @AuraEnabled  public String Answe{get; set;}
        @AuraEnabled  public String AnsName{get; set;}
        @AuraEnabled  public String SubQuess{get; set;}
        @AuraEnabled  public String Question_Type{get; set;}
        @AuraEnabled  public  String Ans{get; set;}
        @AuraEnabled  public Decimal  option{get; set;}
        @AuraEnabled  public List<Id> Selected{get; set;}
        @AuraEnabled  List<String> textGet{get; set;}
        public QuestionWrapper(){
            textGet=new List<String>();
            Selected = new  List<Id>();
            queObj= new Question_Sur__c ();   
            ansOpt=new List<Answer_Sur__c>();
            QueList=new   List<Question_Sur__c>();
        }
    }
    
    @AuraEnabled    
    public static void saveSurvey(String surveyWrapList){
        System.debug('surveyWrapList====== '+surveyWrapList);
  
        List<SUR_Response_Details__c> QuestionSurList = new   List<SUR_Response_Details__c>();
        List<QuestionWrapper> surveyList = (List<QuestionWrapper>)JSON.deserialize(surveyWrapList,List<QuestionWrapper>.class);
  
        
        System.debug('surveyList '+surveyList);
        for(QuestionWrapper b:surveyList)
        {
            SUR_Response_Details__c surObj = new SUR_Response_Details__c();
            
            surObj.Question__c=b.queObj.Name;
            surObj.Id=b.queObj.Id;
             
            for(Answer_Sur__c ans:b.ansOpt)
            {  
                System.debug('inner ');
                
                
                surObj.Answer_Sur__c=ans.Name;
                surObj.Answer_Values__c=ans.Answe__c;
                if( b.queObj.Question_Type__c =='Sub Question'){
                  surObj.Question_Sub__c=ans.Sub_Question__c;
                surObj.Sub_Answer__c=ans.Name;
                surObj.Sub_Answer_Value__c=ans.Answe__c;
            }
              
                 QuestionSurList.add(surObj);
            }
            
          //  surObj.Comment__c =  b.textGet;
            
            // surObj.SUR_Response__c=ans.Selected; 
            
            
            // for(Id id:b.Selected)
       // { 
         //   surObj.SUR_Response__c=id; 
        //}
        
        }  
        System.debug('QuestionSurList== '+QuestionSurList);
        
        if (!QuestionSurList.isEmpty()) {
            upsert QuestionSurList;
        }
    }
    
    
 


    
}