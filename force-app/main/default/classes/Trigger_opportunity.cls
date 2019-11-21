public class Trigger_opportunity {
    public static void trigOpp(List<Opportunity> opp){
       Double tottalAmount=0;
        for( Opportunity ops:[select Amount from Opportunity where CloseDate=TODAY ]){
       
             tottalAmount=tottalAmount+ops.Amount;
        }
        for(Opportunity ops1:opp){
             tottalAmount=tottalAmount+ops1.Amount;
            if(tottalAmount>1000){
                ops1.addError('overe value thean todays limit');
            }
        }
    }
}