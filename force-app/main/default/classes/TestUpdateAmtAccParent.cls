@IsTest
public class TestUpdateAmtAccParent {
  @IsTest
    public static void amtofparAcc() {
 List<Account> accList = new List<Account>(); 
        Account acc= new Account();
        acc.Name='hcl';
        insert acc;
         Account acc1= new Account();
        acc1.Name='hcl';
        acc1.ParentId=acc.Id;
        insert acc1;
        accList.add(acc1);
        
        List<Opportunity> oppList = new List<Opportunity>(); 
        for(integer i=0;i<100;i++)
        {
            Opportunity opp =new Opportunity();
            opp.Amount =100+i;
            opp.AccountId=acc.Id;
            opp.Name='aj';
            insert opp;
            oppList.add(opp);
        } 
        
     //  UpdateAmtAccParent.TotalOfOppAmt(oppList);
        UpdateAmtAccParent.TotalOfOppAmtParent(accList);
    }

}