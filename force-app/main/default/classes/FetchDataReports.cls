public class FetchDataReports {
    @AuraEnabled
    public static  map<string,string>  reportData(){
        List <Report> reportList = [SELECT Id,Name,DeveloperName FROM Report where 
                                    DeveloperName = 'New_Accounts_Report_3jD' limit 10];
        System.debug('reportList==='+reportList);
        String reportId = (String)reportList.get(0).get('Id');
      
       
        // Run a report
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId);
        // Get the report extended metadata
        Reports.ReportExtendedMetadata rmd =   results.getReportExtendedMetadata();
        
        // Get detail columns from extended metadata
        Map<String,Reports.DetailColumn> colMap = rmd.getDetailColumnInfo();
    
        map<string,string>myAMap = new map<string,string>();
        
        for(String key : colMap.KeySet()){
           
            System.debug('Key=' + Key + ' label=' + colMap.get(key).getLabel()+' Name=' + colMap.get(key).getName());
            
             myAMap.put('label',colMap.get(key).getLabel());
             myAMap.put('Name',colMap.get(key).getName());
          
        
        }
        return myAMap;
     /*   // Get the first down-grouping in the report
        Reports.Dimension dim = results.getGroupingsDown();
        Reports.GroupingValue groupingVal = dim.getGroupings()[0];
        System.debug('Key: ' + groupingVal.getKey());
        System.debug('Label: ' + groupingVal.getLabel());
        System.debug('Value: ' + groupingVal.getValue());
        
        // Construct a fact map key, using the grouping key value
        String factMapKey = groupingVal.getKey() + '!T';
        
        // Get the fact map from the report results
        Reports.ReportFactWithDetails factDetails =
            (Reports.ReportFactWithDetails)results.getFactMap().get(factMapKey);
        
        // Get the first summary amount from the fact map
        Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
        System.debug('Summary Value: ' + sumVal.getLabel());
        
        // Get the field value from the first data cell of the first row of the report
        Reports.ReportDetailRow detailRow = factDetails.getRows()[0];
        System.debug(detailRow.getDataCells()[0].getLabel());  */
    }
}