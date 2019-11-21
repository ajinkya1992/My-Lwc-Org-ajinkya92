public with sharing class jQueryDataTableCtrl {
@AuraEnabled
   public static List <KnowledgeArticleVersion> fetchOpportunity() {
         
      Return [SELECT Title,Summary,ArticleNumber,UrlName,LastPublishedDate,VersionNumber FROM KnowledgeArticleVersion LIMIT 100];
          
    }
}