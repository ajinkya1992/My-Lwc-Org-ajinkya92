public class apticlass {

 public List<QuestionWrapper>  questiWrapperList{set;get;} 
    
    public apticlass(){
          questiWrapperList=new  List<QuestionWrapper>();
        QuestionWrapper wpobj=new QuestionWrapper();
         List<Question_set__c>  questionlist=new  List<Question_set__c>();
         questionlist= [SELECT Id,Add_Questions__c,Name,(select Id, Name,Add_Question__c,Option__c from Answer_sets__r) FROM Question_set__c Limit 10];
        
          for(Question_set__c oo : questionlist){
            QuestionWrapper wrap = new QuestionWrapper();
            wrap.ques1 = oo ;
           
            for(Answer_set__c opt: oo.Answer_sets__r){
                if(opt.Add_Question__c == oo.Id){ 
                    wrap.ans2.add(new SelectOption(opt.Id, opt.Option__c));
             
                }
            }
            questiWrapperList.add(wrap);  
          }
    /*    for(Question_set__c qlist:questionlist ) {
             QuestionWrapper wrapper=new QuestionWrapper(qlist);
         questiWrapperList.add(wrapper);
            System.debug('questiWrapperList=========='+questiWrapperList);
            
        }*/
        
    }
   
    Class QuestionWrapper{
      //  public Id ansIds{set;get;}
         public String isSelected1{get;set;}
          public List<SelectOption> ans2{get;set;}
         public Question_set__c ques1 {get;set;}
     
            public QuestionWrapper(){
              ans2 = new List<SelectOption>();
               ques1= new Question_set__c();
                isSelected1='';
              /*  for(Answer_set__c qlist1:qlist.Answer_sets__r){
                  ans2.add(new SelectOption(qlist1.Id,qlist1.Name));  
                }*/

            } 
         
        }
    
    
  /*  public void submit(){
        List<Aptiude_test__c>  questionlist=new  List<Aptiude_test__c>();  
        if(!questiWrapperList.isEmpty()){
            
            for(QuestionWrapper quswrp1:questiWrapperList){
                if(quswrp1.isSelected1!=''){
                    Aptiude_test__c apptest=new Aptiude_test__c();
                    apptest.Id=quswrp1.ansIds;
                    apptest.Answer_set__c=quswrp1.isSelected1;
                    apptest.Question_Set__c=quswrp1.ques1.id;
                     questionlist.add(apptest);
                }
            }
        }
        if(!questionlist.isEmpty())
                {
                    try
                    {
                        upsert questionlist;
                    }
                    catch(Exception ex)
                    {
                        System.debug(ex);
                    }
                }
        
    }*/
    
    

    
    public void save(){
       System.debug('hhhhhhhhhhh ');
        list<Aptiude_test__c> ansList =new list<Aptiude_test__c>();
        for(QuestionWrapper obj: questiWrapperList){
            Aptiude_test__c ansObj=new Aptiude_test__c();
            ansObj.Question_Set__c = obj.ques1.Id;
            // System.debug('ansObj.Question__c==>>'+ansObj.Question__c);
            // System.debug('obj.que.Name==>>'+obj.que.Name);
            ansObj.Answer_set__c = obj.isSelected1;
            ansObj.ExternalId__c =obj.ques1.Id;
            System.debug('ansObj** '+ansObj);
            ansList.add(ansObj);
        }
        if (!ansList.isEmpty()) {
                upsert ansList ExternalId__c;
		}
    }
       
}