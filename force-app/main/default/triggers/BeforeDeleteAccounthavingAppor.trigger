trigger BeforeDeleteAccounthavingAppor on Account (before delete) {

    for(Account a:[Select Id from Account where Id In(Select AccountId from Opportunity) And Id In :Trigger.old]){
        Trigger.oldMap.get(a.Id).addError('Account has Related apportunity!!');
    }
}