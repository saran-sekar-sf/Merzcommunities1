import { LightningElement, api, wire } from 'lwc';
import fetchShippingInfo from '@salesforce/apex/ShipmentTracking_CC.fetchShippingInfo'
import shipmentInfo from '@salesforce/label/c.Shipment_Info';

export default class ShipmentTracking extends LightningElement {
    @api recordId; // Shipping Record id
    responseData; //success response
    exceptionData; //any exception or exception response from apex
    respVariant; //to render the response with slds style
    cardTitle = shipmentInfo; //from custom label
    shipmentStatus = 'Shipment Status : '; //label for message if success
    errorOccured = 'Error Occured! : '; //label for message if failed
    successVariant = 'slds-text-color_success'; //Green text
    errorVariant = 'slds-text-color_error'; //Red text
    showSpinner = true; //To Show and Hide Spinner. Default is ON

    /* wire to get the shipping info my making callout via apex by passing the recordId*/
    @wire(fetchShippingInfo, {recordId:'$recordId'})
    shippingInfo ({error, data}) {
        if (error) {
            // TODO: Error handling - Failure Case for Unhandled Exception if there any
            this.exceptionData = JSON.stringify(error);
            this.respVariant = this.errorVariant;
            this.showSpinner = false; //Turn OFF
        } else if (data) {
            // TODO: Data handling - Success Scenario
            this.responseData = data.Success != undefined ? data.Success : null;
            this.exceptionData = data.Failed != undefined ? data.Failed : null;
            this.respVariant = data.Success != undefined ? this.successVariant : this.errorVariant;
            this.showSpinner = false; //Turn OFF
        }
    }
    
    /** This Component is placed under Shipment__c custom object record page
     * Wire method will do the callout based on the recordId being passed
     * Success of Failure response will be rendered in the UI using Track Attributes
     */
}