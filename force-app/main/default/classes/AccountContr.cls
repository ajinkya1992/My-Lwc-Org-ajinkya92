public class AccountContr {
    public  Id recId;
    public  boolean show {get; set;}
    public  List<Account> acc {set;get;}
    public AccountContr(ApexPages.StandardController  controller){
        recId = controller.getId();
        show = false;
       // acc = [select id,name,industry from AccountContr];
    }
    public  void getdata(){
        acc = [select id, name, industry from Account limit 5];
    }
    
    
    public   void showInfo(){
        show = true;
    }
    
    class AccountWrapper{
        public boolean isSelected{get; set;}
        public Account acc{get; set;}
    }
    
    
    
}