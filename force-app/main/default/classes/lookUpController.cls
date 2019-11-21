public class lookUpController {
  @AuraEnabled
 public static List <Knowledge__kav> fetchAccount1(String searchKeyWord) {
  String searchKey = searchKeyWord + '%';
  List <Knowledge__kav> returnList = new List <Knowledge__kav> ();
  List <Knowledge__kav> lstKnowledge = [select id, 	Title,VersionNumber from Knowledge__kav where (Title LIKE: searchKey)];
 
  for (Knowledge__kav acc: lstKnowledge) {
     returnList.add(acc);
     }
  return returnList;
 }
    
    
     @AuraEnabled
 public static List<Knowledge__kav> fetchAccount(String searchKeyWord) {
  String searchKey = searchKeyWord + '%';
  List <List<Knowledge__kav>> returnList = new List <List<Knowledge__kav>> ();
 List<Knowledge__kav> tempList = new List<Knowledge__kav>();
 List<List<Knowledge__kav>> searchList = [FIND :searchKey IN ALL FIELDS RETURNING Knowledge__kav(Title, ArticleNumber, Id, UrlName, VersionNumber, Summary, OwnerId)];
     
  for (List<Knowledge__kav> acc: searchList) {
     returnList.add(acc);
      tempList.addAll(acc);
     }
     System.debug('returnList'+returnList);
  return tempList;
 }
    
    
    @AuraEnabled
 public static List<KnowledgeArticleVersion> fetchArticle() {

  List <KnowledgeArticleVersion> returnList = new List <KnowledgeArticleVersion> ();
  List <KnowledgeArticleVersion> lstKnowledge = [SELECT Title, Summary
FROM KnowledgeArticleVersion
WHERE PublishStatus='Online'];
 
  for (KnowledgeArticleVersion acc: lstKnowledge) {
     returnList.add(acc);
     }
  return returnList;
 }   
    
    
}