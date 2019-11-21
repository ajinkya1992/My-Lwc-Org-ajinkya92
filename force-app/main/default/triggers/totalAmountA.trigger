trigger totalAmountA on Account (after insert,after update,after delete) {
   String day = string.valueOf(system.now().day());

        String month = string.valueOf(system.now().month());

        String hour = string.valueOf(system.now().hour());

        String minute = string.valueOf(system.now().minute() + 5);

        String second = string.valueOf(system.now().second());

        String year = string.valueOf(system.now().year());

        String IndustryName = 'Industry' + second + '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;

        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;

      

     if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
          //  UpdateAmtAccParent.TotalOfOppAmt(Trigger.new);
           System.debug('IndustryName====='+IndustryName+'   strSchedule===='+strSchedule);
              System.schedule(IndustryName, strSchedule, new TestSchedularfor5min());
            
        
        }  
       
     } 
}