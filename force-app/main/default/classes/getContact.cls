@RestResource(urlMapping='/v1/getContacts')
global with sharing class getContact {
    @Httpget
    global static list<contact> fetchAccount(){
          System.debug('lstcontact==>>');
        RestRequest req = RestContext.request;
         System.debug('req222222222222==>>'+req);
        RestResponse res = Restcontext.response;
         System.debug('res11111111111111==>>'+res);
       
        list<contact> lstcontact =[Select id,Name,Phone,Fax,Email from contact];
        System.debug('lstcontact==>>'+lstcontact);
        return lstcontact ;
    }
}