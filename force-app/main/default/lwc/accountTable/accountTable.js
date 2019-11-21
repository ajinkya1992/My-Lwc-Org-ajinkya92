import {LightningElement, wire } from 'lwc';
// import toast message event .

// import apex class and it's methods. 
import getAccounts from '@salesforce/apex/LWCApexMethodDemoController.getAccounts'

export default class AccountTable extends LightningElement {
   

    @wire(getAccounts) Accounts;
    
}