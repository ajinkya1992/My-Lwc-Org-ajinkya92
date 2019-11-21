public class TestTop {
    public String city{get;set;}
    public String temp{get;set;}
    public String press{get;set;}
    public String humi{get;set;}
    public String mxtemp{get;set;}
    public String mintemp{get;set;}
    
    
    public TestTop(ApexPages.StandardController stdController) {

        Account acct = (Account)stdController.getRecord();
         acct=[SELECT Id,Name,ShippingCity from Account where Id =:acct.Id];
        String AccCity =acct.ShippingCity;
        String apikey ='fee86bf8ff8b72d3cc5670ba6115e889';
        String requestEndPoint ='https://api.openweathermap.org/data/2.5/weather';
        requestEndPoint += '?q='+1273294;
        requestEndPoint += '&units=metric';
        requestEndPoint += '&APPID='+apikey;
        System.debug('requestEndPoint '+requestEndPoint);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(requestEndPoint);
        req.setMethod('GET');
       HttpResponse res = http.send(req);
        System.debug('res2'+res);
        if(res.getStatusCode()==200){
            System.debug('resssssss  '+res.getBody());
            // System.debug('res2'+res.HttpResponse());
            Map<String ,Object> result =(Map<String ,Object>)JSON.deserializeUntyped(res.getBody());
            city =String.valueOf(result.get('name'));
             Map<String ,Object> mainResult =(Map<String ,Object>)(result.get('main'));
            temp =String.valueOf(mainResult.get('temp'));
            press =String.valueOf(mainResult.get('pressure'));
            humi =String.valueOf(mainResult.get('humidity'));
            mxtemp =String.valueOf(mainResult.get('temp_min'));
            mintemp =String.valueOf(mainResult.get('temp_max'));
             System.debug(temp+  ' press   '+ press);
        } else{
            ApexPages.Message msg =new ApexPages.Message(ApexPages.Severity.ERROR,'THERE WAS ERROR READING DATA');
            ApexPages.addMessage(msg);
        }
        
    }

}