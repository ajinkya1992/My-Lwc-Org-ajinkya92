trigger CaseCommenttoChatter on CaseComment (after insert, after update) {
    if(TaskHelper.alreadyCreatedTasks){
        TaskHelper.alreadyCreatedTasks= false;
    
    for (CaseComment t: Trigger.new)
{

        Set<Id> parentCase=new Set<Id>();
    parentCase.add(t.ParentId);
   

       List<Case> lstCase=[Select Id,Status,agf__ADM_Work__c from case where Id in :parentCase ];

    for(case c :lstCase){
    
        FeedItem post = new FeedItem();
        post.ParentId = c.agf__ADM_Work__c;
        post.Body = t.commentbody;
        insert post;
}
} 
        }
}