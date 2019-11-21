import { LightningElement, api,wire } from 'lwc';
import getCasetList from '@salesforce/apex/CaseController.getCasetList';
import case_obj from '@salesforce/schema/Case';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Supplied_Name from '@salesforce/schema/Case.SuppliedName';
import Supplied_Email from '@salesforce/schema/Case.SuppliedEmail';
import Desc_ription from '@salesforce/schema/Case.Description';
import Subj_ect from '@salesforce/schema/Case.Subject';
import Contact_Id from '@salesforce/schema/Case.ContactId';

export default class LwcCreateCase extends LightningElement {
    CaseObject = case_obj;
    
    SuppliedName =Supplied_Name;
    
    
     SuppliedEmail=Supplied_Email;
    Description=Desc_ription;
    Subject=Subj_ect;
    ContactId=Contact_Id;
    @api recordId;
   // @api objectApiName;
    @wire(getCasetList,{
        recordId: '$recordId'
      })contacts;
 
   
    handleSuccess(event) {
        
            const evt = new ShowToastEvent({
                title: "Case created",
                message: "Record ID: "+ event.detail.id,
                variant: "success"
            });
            this.dispatchEvent(evt);
        }
        
    }