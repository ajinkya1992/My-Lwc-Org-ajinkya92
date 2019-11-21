import { LightningElement,wire,track } from 'lwc';
import getAccountList from '@salesforce/apex/ContBaseAcc.getAccountList';
const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
];

const columns = [
    { label: 'Name', fieldName: 'name' },
 
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
   
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];
export default class LightningDataablRowAction extends LightningElement {
    @wire(getAccountList) accountList;

    @track data = [];
    @track columns = columns;
    @track record = {};
    @track tableLoadingState = true;

    async connectedCallback() {
        this.data = await fetchDataHelper({ amountOfRecords: 100 });
        this.tableLoadingState = false;
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRow(row);
                break;
            case 'show_details':
                this.showRowDetails(row);
                break;
            default:
        }
    }

    deleteRow(row) {
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

    showRowDetails(row) {
        this.record = row;
    }
}