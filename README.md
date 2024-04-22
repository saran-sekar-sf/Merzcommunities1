# Merzcommunities
Salesforce Developer Project
Shipment Tracking Lightning Web Component

## Description
Merz Aesthetics Customer Service representatives must quickly get the updated status of a
customer shipment. When viewing the standard Shipment page in Salesforce, the rep wants to be
able to view a Lightning Web Component that displays the latest status of the Shipment based on
the tracking number of the Shipment record.


## Getting Started
Develop an LWC that calls the mock shipping status service defined below and displays the
response to the end user. Provide a link to a repository that contains the code along with
documentation in the ReadMe file to tina.weeks@merz.com at least 24 hours before your coding
interview. Be prepared to demo the solution and answer questions during the interview.

### Dependencies

* VS Code

### Executing program
1. Setup -> Goto Shipment__c Object and Click 'Lightning Record Pages'
2. Create New or Select the 'Lightning Record Page' which is Assigned (Here I am not creating Record Page for this Object)
3. Drag and Drop the 'shipmentTracking' custom component into the Record Page
4. Click Save and Activate it
5. Goto 'Shipment__c' record and Observe the presence of 'shipmentTracking' LWC with the Lightning Card title of 'Shipment Info'
6. As per the 'Shipment_Number__c' value, response will be rendered in this component
7. If Success, then Green text
8. If Error or Exception, then red text will be displayed

## Help

Named Credential:
Merzcommunities.namedCredential-meta.xml - To access the 3rd Party

Apex:
1. ShipmentTracking_CC - Main Class where the callout is happening
2. ShipmentTracking_Test - Test Class for ShipmentTracking_CC
3. API_MockGenerator_CC - CalloutMock for ShipmentTracking_CC

LWC:
1. shipmentTracking - Component with @api, @track & @wire decorators.
    @api recordId - will hold the Shipping Record id
    @track - as it is not mandatory, I am not decorating the track attributes with @track
    @wire shippingInfo - Accessing the server which initiating the Callout
   
Label:
1. Shipment_Info - Value of "Shipment Info" which is being used in the LWC's HTML to show the Card Title


Object:
1. Shipment__c - Base Object which holds the Shipment_Number__c

## Authors
Saravanan Sekar
https://www.linkedin.com/in/saravanan-sekar-crm/

## Version History

* 1.0
    * Initial Release

## License

This project is not licensed

## Acknowledgments
Salesforce Documents & Trailhead
