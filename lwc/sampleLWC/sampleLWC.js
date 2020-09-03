import { LightningElement, api, track } from 'lwc';
import { LwcBase } from 'c/lwcBase';

export default class SampleLWC extends LwcBase {

    @track callbackMessage;
    @track showDialog = false;
    
    showInfo() {
        super.showInfo('This is an Info.');
    }

    showWarning() {
        super.showWarning('This is a Warning.');
    }

    showSuccess() {
        super.showSuccess('This is a Success.');
    }

    showError() {
        super.showError('This is an Error.');
    }

    navAccountHome() {
        super.navigateToObjectHome('Account');
    }

    navTab() {
        super.navigateToTab('batchjobsch__Scheduler_Configuration');
    }

    viewAccount() {
        super.viewRecord('Account', '0011s00000MBSOtAAP');
    }

    editAccount() {
        super.editRecord('Account', '0011s00000MBSOtAAP');
    }

    newAccount() {
        super.newRecord('Account');
    }

    handleClick(event) {

        if(event.target.name === 'openDialog'){
            //it can be set dynamically based on your logic
            this.callbackMessage = 'test message';
            //shows the component
            this.showDialog = true;
        }else if(event.target.name === 'confirmModal'){
            //when user clicks outside of the dialog area, the event is dispatched with detail value  as 1
            if(event.detail !== 1){
                //gets the detail message published by the child component
                //this.displayMessage = 'Status: ' + event.detail.status + '. Event detail: ' + JSON.stringify(event.detail.originalMessage) + '.';
                //you can do some custom logic here based on your scenario
                if(event.detail.status === 'ok') {
                    //do something
                } else if(event.detail.status === 'cancel'){
                    //do something else
                }
            }

            this.showDialog = false;
        }
    }



}