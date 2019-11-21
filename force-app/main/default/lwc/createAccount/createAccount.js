import { LightningElement, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import Description from '@salesforce/schema/Account.Description';
import Type from '@salesforce/schema/Account.Type';
export default class CreateAccount extends LightningElement {
    @track recordId;
    accountObject = ACCOUNT_OBJECT;
    nameField = NAME_FIELD;
    websiteField = WEBSITE_FIELD;
    Description = Description;
    Type = Type;
    handleAccountCreated(evt){
        const recordId = evt.detail.data.id;
        this.recordId = recordId;
    }

    myFields = [NAME_FIELD, WEBSITE_FIELD];

    /** Handles successful Account creation. */
    handleAccountCreated1(evt) {
        this.createStatus = `Account record created. Id is ${evt.detail.id}.`;

        const event = new CustomEvent('newrecord', {
            detail: { data: evt.detail },
        });
        this.dispatchEvent(event);
    }
}