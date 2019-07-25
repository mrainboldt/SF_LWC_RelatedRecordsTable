import { LightningElement, wire, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import initTable from '@salesforce/apex/LightningTableController.initTable';
import no_records from '@salesforce/label/c.RelatedRecords_Table_No_Records_Message';

const actions = [{label: 'View', name:'viewRecord'}];
export default class RelatedRecords extends NavigationMixin(LightningElement)
{
    
    @api relatedObject;
    @api label;
    @api recordId;
    @api relatedField;
    @api icon;
    @api fieldSet;
    @api where_clause = '';

    @api objectApiName;
    @api inlineEdit = false;
    @api colAction = false;
    @track columns;
    @track records;
    @track loadMoreStatus;
    @track totalNumberOfRows = 0;
    @track sortDirection;
    @track sortedBy;
    @track table;
    
    @api labels = {
        no_records
    };
    
    @wire(initTable, { recordId: '$recordId'
                        , relatedField: '$relatedField'
                        , relatedObject: '$relatedObject'
                        , fieldSetName: '$fieldSet'
                        , whereClause: '$where_clause'
                        }
        )
        wiredTable({error, data})
        {
            if(data)
            {
                this.table = JSON.parse(JSON.stringify(data));
                this.records = this.table && this.table.rowCount > 0 ? JSON.parse(JSON.stringify(this.table.records)) : undefined;
                this.totalNumberOfRows = this.table ? this.table.rowCount : 0;
                this.columns = this.table.columns;
                this.columns.push({ type: 'action', typeAttributes: { rowActions: actions, menuAlignment: 'right' } })
            }
            else
            {
                this.table = undefined;
                this.totalNumberOfRows = 0;
                console.log(error);
            }
            
        }

    getSelectedName(event) {
        // var selectedRows = event.detail.selectedRows;
        // var recordIds=[];
        // if(selectedRows.length > 0) {
        //     for(var i =0 ; i< selectedRows.length; i++) {
        //         recordIds.push(selectedRows[i].Id);
        //     }
            
        //    const selectedEvent = new CustomEvent('selected', { detail: {recordIds}, });
        //    // Dispatches the event.
        //    this.dispatchEvent(selectedEvent);
        // }
        
    }

    loadMoreData(event) {
            //Display a spinner to signal that data is being loaded
            //Display "Loading" when more data is being loaded
            // this.loadMoreStatus = 'Loading';
            // const currentRecord = this.data;
            // const lastRecId = currentRecord[currentRecord.length - 1].Id;
            // getRelatedRecords({ recordId: '$recordId', fields: '$fieldSOQL', relatedField: '$relatedField'})
            // .then(result => {
            //     const currentData = result.sobList;
            //     //Appends new data to the end of the table
            //     const newData = currentRecord.concat(currentData);
            //     this.records = newData; 
            //     if (this.records.length >= this.totalNumberOfRows) {
            //         this.loadMoreStatus = 'No more data to load';
            //     } else {
            //         this.loadMoreStatus = '';
            //     }
            // })
            // .catch(error => {
            //     console.log('-------error-------------'+error);
            //     console.log(error);
            // });
        }

        handleRowAction(event) {
            const actionName = event.detail.action.name;
            const row = event.detail.row;
            switch (actionName) {
            // case 'edit':
            //     this.editRecord(row);
            //     break;
            // case 'view':
            //     this.viewRecord(row);
            //     break;
            // case 'delete':
            //     this.deleteRecord(row);
            //     break;
            default:
                this.viewRecord(row);
                break;
            }
        }
    
		//currently we are doing client side delete, we can call apex tp delete server side
        deleteRecord(row) {
            // const { id } = row;
            // const index = this.findRowIndexById(id);
            // if (index !== -1) {
            //     this.records = this.records
            //         .slice(0, index)
            //         .concat(this.records.slice(index + 1));
            // }
        }
    
        findRowIndexById(id) {
            // let ret = -1;
            // this.records.some((row, index) => {
            //     if (row.id === id) {
            //         ret = index;
            //         return true;
            //     }
            //     return false;
            // });
            // return ret;
        }
    

        editRecord(row) {
            // this[NavigationMixin.Navigate]({
            //     type: 'standard__recordPage',
            //     attributes: {
            //         recordId: row.Id,
            //         actionName: 'edit',
            //     },
            // });
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

            // var draftValuesStr = JSON.stringify(event.detail.draftValues);
            // updateRecords({ sobList: this.records, updateObjStr: draftValuesStr, objectName: this.relatedObject })
            // .then(result => {
                
            //     this.dispatchEvent(
            //         new ShowToastEvent({
            //             title: 'Success',
            //             message: 'Records updated',
            //             variant: 'success'
            //         })
            //     );
            //     // Clear all draft values
            //     this.draftValues = [];
            //     return refreshApex(this.wiredsObjectData);
            // })
            // .catch(error => {
            //     console.log('-------error-------------'+error);
            //     console.log(error);
            // });

        }

        // The method will be called on sort click
        updateColumnSorting(event) {
            this.sortedBy = event.detail.fieldName;
            this.sortDirection = event.detail.sortDirection; 
            //this.records = this.sortData(this.sortedBy, this.sortDirection, this.records); 
            const data = sortData(this.sortedBy, this.sortDirection, this.records);
            this.records = JSON.parse(JSON.stringify(data));
       }

       sortData = function(sortBy, sortDirection, data)
       {
            //function to return the value stored in the field
            var key = function(a) { return a[sortBy]; }
            var reverse = sortDirection === 'asc' ? 1: -1;
            data.sort(function(a,b){ 
                var a = key(a) ? key(a) : '';//To handle null values , uppercase records during sorting
                var b = key(b) ? key(b) : '';
                return reverse * ((a>b) - (b>a));
            });
            return data;
       }
}