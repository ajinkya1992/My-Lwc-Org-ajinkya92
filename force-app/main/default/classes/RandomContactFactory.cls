public class RandomContactFactory {
    public static  List<Contact> generateRandomContacts(Integer p,String s){
        
        List<Contact> contlist= new List<Contact>();
        for(Integer i=0;i<p;i++){
            Contact c = new Contact(firstName=''+s+' '+i,lastName=''+s+' '+i);
           
            contlist.add(c);
        }
        System.debug('contlist '+contlist);
        return contlist;
    }
}