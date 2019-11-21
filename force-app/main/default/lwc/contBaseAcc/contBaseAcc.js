import { LightningElement,wire,api,track } from 'lwc';
import getAccountList from '@salesforce/apex/ContBaseAcc.getAccountList';
import getContactList from '@salesforce/apex/ContBaseAcc.getContactList';
import getBookingList from '@salesforce/apex/ContBaseAcc.getBookingList';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
];

const columns = [
    { label: 'Name', fieldName: 'Description__c' },
    { label: 'Website', fieldName: 'Amount__c', type: 'currency' },
    { label: 'Phone', fieldName: 'Calculated__c', type: 'phone' },
   
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

    

export default class ContBaseAcc extends LightningElement {
    @wire(getAccountList) accountList;
    @wire(getContactList) contactList;
  
   // @api contactList;
    @api indexVar;
    @api getAccountList;
   
    @api fieldNamesStr;
    @api inlineEdit = false;
    @api colAction = false;
    @api totalNumberOfRows;
    @track i=0;
    @track ii=0;
    @track len;
    @track accObjIds=[];
    @track conObjId='';
    @track accIdNew=[];
    @track newContacts=[];
    @track newBookings=[];
    @track conBtn='';
    @track bookBtn='';
    @track error;
   
    @track actions =[];
    
    @track data = [];
  
    @track columns = columns;
    @track record = {};
    @track tableLoadingState = true;

    wiredsObjectData;



    onAccCheck(event) {
    
      

        
    if((event.target.checked)+''==='true'){
        this.accIdNew = (event.target.id).split("-");
        this.accObjIds.push(this.accIdNew[0]);
        //console.log('accObjIds# push==>>'+this.accObjIds);
        
    }else if((event.target.checked)+''==='false'){
        for( this.i = this.accObjIds.length; this.i--;){
            this.accIdNew = (event.target.id).split("-");
          
            if ( (this.accObjIds[this.i])+'' === this.accIdNew[0]) 
            this.accObjIds.splice(this.i, 1);
            //alert('this.accObjIds.splice(this.i, 1) '+this.accObjIds.splice(this.i, 1));
            }
        
      //  console.log('accObjIds# pop==>>'+this.accObjIds);
        this.selAccId=this.accObjIds;

        
    }
     
    this.newContacts=[];
    this.newBookings=[];  
    }

    onShowContactClick( ){
        getContactList({ selAccId: this.accObjIds })
        .then(result => {
           // console.log('TCL: dseContactManagementForSelectedAccountLwc -> buttonClicked -> result', result)
           //  this.contactList = result;
           // refreshApex(this.contactList);
           this.contactList=JSON.parse(JSON.stringify(result));
         //  console.log('wanted-->>'+ JSON.parse(JSON.stringify(result)));
           this.newContacts=result;
         //  console.log('newContacts==>>'+this.newContacts);
        })
        .catch(error => {
            console.log('TCL: dseContactManagementForSelectedAccountLwc -> buttonClicked -> error', error)

        });
    }


    onConCheck(event) {
        this.accIdNew = (event.target.id).split("-");
            this.conObjId=(this.accIdNew[0]);
            console.log('conObjId# push==>>'+this.conObjId);

            this.newBookings=[];
            
    }

    onShowBookingClick( ){
        getBookingList({ selConId: this.conObjId })
        .then(result => {
            console.log('TCL: dseContactManagementForSelectedAccountLwc -> buttonClicked -> result', result)
           
           this.newBookings=result;


           this.data = this.newBookings;
           alert("this.data "+this.data);
          // this.tableLoadingState = false;
           console.log(this.data);
        })
        .catch(error => {
            console.log('TCL: dseContactManagementForSelectedAccountLwc -> buttonClicked -> error', error)

        });
        this.book=[];
      
    }

    getSelectedName(event) {
        var selectedRows = event.detail.selectedRows;
        var recordIds=[];
        if(selectedRows.length > 0) {
            for( this.ii =0 ; this.ii< selectedRows.length; this.ii++) {
                recordIds.push(selectedRows[this.ii].Id);
            }
            
           const selectedEvent = new CustomEvent('selected', { detail: {recordIds}, });
           // Dispatches the event.
           this.dispatchEvent(selectedEvent);
        }
        
    }


    
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
        case 'edit':
            this.editRecord(row);
            break;
        case 'view':
            this.viewRecord(row);
            break;
        case 'delete':
            this.deleteRecord(row);
            break;
        default:
            this.viewRecord(row);
            break;
        }
    }

    //currently we are doing client side delete, we can call apex tp delete server side
    deleteRecord(row) {
        const { id } = row;
        const index = this.findRowIndexById(id);
        if (index !== -1) {
            this.data = this.data
                .slice(0, index)
                .concat(this.data.slice(index + 1));
        }
    }

    findRowIndexById(id) {
        let ret = -1;
        this.data.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }


    editRecord(row) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                actionName: 'edit',
            },
        });
    }
    
    viewRecord(row) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                actionName: 'view',
            },
        });
    }

    //When save method get called from inlineEdit
    handleSave(event) {

        var draftValuesStr = JSON.stringify(event.detail.draftValues);
        updateRecords({ sobList: this.data, updateObjStr: draftValuesStr, objectName: this.objectApiName })
        .then(result => {
            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records updated',
                    variant: 'success'
                })
            );
            // Clear all draft values
            this.draftValues = [];
            return refreshApex(this.wiredsObjectData);
        })
        .catch(error => {
            console.log('-------error-------------'+error);
            console.log(error);
        });

    }

    // The method will be called on sort click
    updateColumnSorting(event) {
        var fieldName = event.detail.fieldName;
        var sortDirection = event.detail.sortDirection;    
   }









    
   /* addbooking ( ){
        
        this.book = this.newBookings;
        alert("this.book " +this.book);
        this.len = this.book.length;
        this.book.push({
             'srNo':'0'+ this.len,
             'Contact__r.Name':'',
             'Description__c':'',
             'Amount__c':0.0,
            
             'Calculated__c':0.0  
         }); 
         this.newBookings = this.book;
        
     }*/

    
      
   
    
}