@isTest
public class TestVerifyDate {
 @isTest static void CheckDates1() {
        Date  pri = VerifyDate.CheckDates(date.newInstance(1990, 2, 2),date.newInstance(1990, 2, 10));
        System.assertEquals(date.newInstance(1990, 2, 10), pri);
    }
    
    @isTest static void DateWithin30Days1() {
        Date  pri1 = VerifyDate.CheckDates(date.newInstance(1990, 3, 1),date.newInstance(1990,3, 10));
        System.assertEquals(date.newInstance(1990, 3,10), pri1);
    }
    
    @isTest static void SetEndOfMonthDate1() {
        Date  pri2 = VerifyDate.CheckDates(date.newInstance(1990, 1, 1),date.newInstance(1990, 2, 10));
        System.assertEquals(date.newInstance(1990, 1, 31), pri2);
    }
}