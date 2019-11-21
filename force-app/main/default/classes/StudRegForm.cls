public class StudRegForm { 
 @AuraEnabled
   
    public static void saveRegStud(String FirstName,String LastName,String email,Id recordId)
    {
        
     
       
                    
        if(recordId!= null){
             Contact co =new Contact ();
            
            co.Id=recordId;
                    co.FirstName=FirstName;
                    co.LastName=LastName;
                 co.Email=email;
                   System.debug('co '+co); 
                   
                    update co;
             
        }  
                  
           
       
    }
}