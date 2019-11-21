trigger CandShareTrigger on Candidate__c (after insert,after update) {
  System.debug('GIIII ');
        // Create a new list of sharing objects for Job
        List<Candidate__Share> jobShrs  = new List<Candidate__Share>();
        
        // Declare variables for recruiting and hiring manager sharing
        Candidate__Share recruiterShr;
        Candidate__Share hmShr;
        
        for(Candidate__c job : trigger.new){
            // Instantiate the sharing objects
            recruiterShr = new Candidate__Share();
            hmShr = new Candidate__Share();
            
            // Set the ID of record being shared
            recruiterShr.ParentId = job.Id;
            hmShr.ParentId = job.Id;
            
            
             recruiterShr.Id = '02c6F0000XufdzVQQQ';
            hmShr.Id = '02c6F0000XuaycjQQA';
            
            // Set the ID of user or group being granted access
           // recruiterShr.UserOrGroupId = 'a046F00001xmSzFQAU';
           // hmShr.UserOrGroupId = 'a046F00001xmSzFQAU';
            
            // Set the access level
            recruiterShr.AccessLevel = 'read';
            hmShr.AccessLevel = 'edit';
            
            // Set the Apex sharing reason for hiring manager and recruiter
           // recruiterShr.RowCause = Schema.Candidate__Share.RowCause.Manual;
          //  hmShr.RowCause = Schema.Candidate__Share.RowCause.Manual;
            
            // Add objects to list for insert
            jobShrs.add(recruiterShr);
            jobShrs.add(hmShr);
        }
        System.debug('jobShrs** '+jobShrs);
        // Insert sharing records and capture save result 
        // The false parameter allows for partial processing if multiple records are passed 
        // into the operation 
        Database.SaveResult[] lsr = Database.update(jobShrs,false);
   
        
        // Create counter
        Integer i=0;
        
        // Process the save results
        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){
                // Get the first save result error
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level
                // Access levels equal or more permissive than the object's default 
                // access level are not allowed. 
                // These sharing records are not required and thus an insert exception is 
                // acceptable. 
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    // Throw an error when the error is not related to trivial access level.
                    trigger.newMap.get(jobShrs[i].ParentId).
                      addError(
                       'Unable to grant sharing access due to following exception: '
                       + err.getMessage());
                }
            }
            i++;
        }   
   
    
}