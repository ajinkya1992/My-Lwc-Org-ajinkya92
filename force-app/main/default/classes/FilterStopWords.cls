public class FilterStopWords {
   
    public static String[] myStringArray= new String[]{'a','an','the','in'}; 
   public static  String[] stopWords = new String[]{'very', 'having', 'with', 'they', 'own', 'an'};
    public static String[] stopSym = new String[]{'@', '#', '*', '%', '!', '^'};
     public static String[] htmlTags = new String[]{'<html>', '</html>'};
    
    
    @AuraEnabled
    public static String getCompair(String textarea){
      String[] strText=textarea.split(' ');
        String test='';    
            for(Integer i=0;i<strText.size();i++){
                for(Integer j=0;j<myStringArray.size();j++){
                if(strText[i].equals(myStringArray[j])) {
                    strText[i]=strText[i].replace(myStringArray[j],'');
                } 
             }
                
              for(Integer j=0;j<stopSym.size();j++){
                if(strText[i].equals(stopSym[j])) {
                    strText[i]=strText[i].replace(stopSym[j],'');
                }
             }   
               
               for(Integer j=0;j<htmlTags.size();j++){
                if(strText[i].equals(htmlTags[j])) {
                    strText[i]=strText[i].replace(htmlTags[j],'');
                }
             }    
                
                
            }
        for(String obj:strText){
            test+=obj+' ';
        }
        System.debug('test========>>'+test);
        return test; 
    }  
}