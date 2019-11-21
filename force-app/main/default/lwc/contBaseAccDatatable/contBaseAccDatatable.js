import { LightningElement, wire, track } from 'lwc';
//import getAccList from '@salesforce/apex/ContBaseAcc.getAccounthasCont';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Name from '@salesforce/schema/Account.Name';
import Description from '@salesforce/schema/Account.Description';
import Phone from '@salesforce/schema/Account.Phone';


const cols = [
    { label: 'First Name', fieldName: 'Name', editable: true },
    { label: 'Last Name', fieldName: 'Description', editable: true },
    { label: 'Title', fieldName: 'Phone' }
   
];

export default class ContdataTabl extends LightningElement {

    @track error;
    @track columns = cols;
    @track draftValues = [];

    //@wire(getAccList)
   // Acclist;

    handleSave(event) {

        const fields = {};
        fields[Name.fieldApiName] = event.detail.draftValues[0].Name;
        fields[Description.fieldApiName] = event.detail.draftValues[0].Description;
        fields[Phone.fieldApiName] = event.detail.draftValues[0].Phone;
        
        const recordInput = {fields};

        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
            // Clear all draft values
            this.draftValues = [];

            // Display fresh data in the datatable
            return refreshApex(this.contact);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}