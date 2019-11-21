@IsTest
public class TestSurveyQuestion {
    @IsTest
    public static void getQuestionAnswer1() {
        Demo_Question__c q = new Demo_Question__c();
       
        q.Question_Type__c='Loyalty';
        q.Question__c = 'hello?';
        insert q;
        Demo_Answer__c a = new Demo_Answer__c();
        a.Answer__c = 'ff';
        a.Answer_Type__c = 'Rating';
 a.Demo_Question__c=q.Id;
        a.Radio_Answer_Range__c = 8;
        insert a;
       
           
            SurveyQues2.getQuestionAnswer();
           
        }
      
}