public class AddPrimaryContact implements Queueable{
  private Contact con;
    private String  State;
    public  AddPrimaryContact(Contact con , String  State){
        this.con=con;
        this.State=State;
    }
 
    public void execute(QueueableContext context) {
         List<Contact> contlist=new  List<Contact> ();
        List<Account> acc=[select Id ,Name,(Select Id,FirstName,LastName from Contacts) from Account where BillingState =:State Limit 200];
        for (Account account : acc) {
         Contact co=con.clone(false,false,false,false);
            co.AccountId=account.Id;
            contlist.add(co);

        }
        if(contlist.size()>0){
            insert contlist;
        }
        
    }
}