public class CreateCase {
    @AuraEnabled
    public static List<String> getPickListValuesIntoList(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Case.Priority.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }
        
        System.debug('1111111111111'+pickListValuesList);
        return pickListValuesList;
    }
    
    @AuraEnabled
    public static Case saveCaseData(Case cse,String recId){
        
        cse.ContactId =recId;
        insert cse;
        
        CaseComment cc = new CaseComment(ParentId = cse.Id,CommentBody =cse.Description );
        insert cc;
        return cse;
        
        
        
    }
}