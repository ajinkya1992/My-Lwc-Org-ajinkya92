trigger Checkbox on Contact (before insert,before delete,before update,after update) {
   List<Contact > cont1 =new List<Contact >();
       List<Contact > cont2 =new List<Contact>();
    set<Contact > idss =new set<Contact>();
      List<Contact> contlist4 =new List<Contact>();

    
 public static  List<Contact>  cont20 = new List<Contact>([select id,Name,Is_Primary__c,AccountId from Contact  where Is_Primary__c=:true]);
    
    if(trigger.isBefore){
        
      if(trigger.isInsert){   

    
  //first record of account shold b primary
      List<Contact> newlist = new List<Contact>(Trigger.new);
    cont2 = [SELECT Id, Is_Primary__c FROM Contact WHERE (AccountId= :newlist[0].AccountId) ];
            
            if(cont2.isEmpty()){
                newlist[0].Is_Primary__c = true;
            }
    
      //    only one record can  primary.
         
          
          for(Contact cont: Trigger.new){
              
              if(cont.Is_Primary__c==true){ 
                  for(Contact cont18: cont20){
                      if(cont18.Is_Primary__c==cont.Is_Primary__c && cont18.AccountId==cont.AccountId){
                         cont.Adderror('One of Record already Is-Primary');   
                      }
                  }
              }
             
          }        
        }   
  /*for(Contact cont: Trigger.new){
        
        if(cont.Is_Primary__c==true){
            cont1 = [select id,Is_Primary__c from Contact  WHERE Is_Primary__c  =: true AND AccountId=:cont.AccountId];
            
            
            if(cont1.size() > 0 ){
                
                cont.Adderror('One of Record already activated');   
                
            }
          
        }
       
    }*/
   
   
		 
        //primary record can't deleted
        if(trigger.isDelete){ 
            for(Contact cont5: Trigger.old){
                
                if(cont5.Is_Primary__c==true){
             
                    cont5.Adderror('Current record is primery one,Can not deleted!!' );   
                }
                
            }
        }
      
        
         if(trigger.isUpdate){
       for(Contact cont11: Trigger.new){
                  for(Contact cont12: Trigger.old){
                      
                      if((cont11.AccountId!=cont12.AccountId && cont11.Id==cont12.Id && cont12.Is_Primary__c==true)){
                         cont11.Adderror('Current record is primery one,Can not Update Account !!' ); 
                      }
                   
                      List<Contact> newList =new List<Contact>();
                      For(Contact uu:cont20){
                           System.debug('uu==='+uu);
                          if(uu.AccountId==cont12.AccountId && uu.Is_Primary__c==true){
                              newList.add(uu);
                          }
                      }  
                      System.debug('newList==='+newList);
                      if(newList.size()<=1){
                          if((cont11.AccountId==cont12.AccountId  && cont12.Is_Primary__c!=cont11.Is_Primary__c )){
                              
                              cont11.Adderror('Current record is primery one,Can not Update Is_Primary !!' ); 
                          }
                      } 
                  }
                  
       }  
            } 
  
        
        
    }
   
    //update primary record with another one
    if(trigger.isAfter){
        if(trigger.isUpdate){
            
            List<Contact> contlist4 =new List<Contact>();
            
            for(Contact cont13: Trigger.new){
                for(Contact cont15: cont20){
                    if(cont13.Is_Primary__c==true && cont15.AccountId==cont13.AccountId && cont13.Id!=cont15.Id){
                        Contact c3=new Contact();
                        c3.id=cont15.Id;
                        c3.Is_Primary__c=false;
                       
                        contlist4.add(c3);
                        
                    }
                }                      
            }
            
          System.debug('contlist4==='+contlist4);
            update contlist4;
        }
        
        
        
              /* if(trigger.isUpdate){
             List<Contact> contlist4 =new List<Contact>();
             for(Contact cont7: Trigger.new){
                 if(cont7.Is_Primary__c==true){
             cont1 = [select id,Is_Primary__c from Contact  WHERE   AccountId=:cont7.AccountId and Id!=:cont7.id];
                 for(Integer i=0;i<cont1.size();i++){
                 cont1[i].Is_Primary__c =false;  
                     
                     contlist4.add(cont1[i]);
                 }
           }
                
             }
          update contlist4;
        } */
      }                                                                                                                                                          
    
    
}