import { LightningElement,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import getContactList from '@salesforce/apex/customSearchController.getContactList';

export default class SearchInTable extends LightningElement {

    @track contacts;
    sVal = '';
    dateval='';
    // update sVal var when input field value change
    updateSeachKey(event) {
        this.sVal = event.target.value;
    }
    updateSeachKey1(event) {
        this.dateval = event.target.value;
    }


    // call apex method on button click 
    handleSearch() {
        // if search input value is not blank then call apex method, else display error msg 
      
            getContactList({
                    searchKey: this.sVal,
                    seardate:this.dateval

                })
                .then(result => {
                    // set @track contacts variable with return contact list from server  
                    this.contacts = result;
                })
                .catch(error => {
                    // display server exception in toast msg 
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.body.message,
                    });
                    this.dispatchEvent(event);
                    // reset contacts var with null   
                    this.contacts = null;
                });
       
    }

}