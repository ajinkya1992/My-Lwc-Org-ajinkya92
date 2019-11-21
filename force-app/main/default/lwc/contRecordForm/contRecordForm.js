import { LightningElement, api,wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Name from '@salesforce/schema/Contact.Name';
import Phone from '@salesforce/schema/Contact.Phone';
import Description from '@salesforce/schema/Contact.Description';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
export default class ContRecordForm extends LightningElement {
  
    @api recordId;
    @api objectApiName;
    @wire(getContactList, {
        recordId: '$recordId'
      }) contacts;
    fields = [Name, Phone,Description];
    
    handleSuccess(event) {
        
        const evt = new ShowToastEvent({
            title: "Case created",
            message: "Record ID: "+ event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);


    }
}