/*
* Based on OWD security can be handled over here, keeping it as with sharing as it is having SOQL query
* This class is being used to check the status of the Shipping
* fetchShippingInfo - This method is receiving recordId from wire method of ShipmentTracking LWC
* handleCallout - is a re-usable method to make the callout
* ERROR_MSG - Lengthy error message stored in a static variable
* Created on : 22 Apr 2024
* Created By : Saravanan Sekar
*/ 
public with sharing class ShipmentTracking_CC { 

    public static String ERROR_MSG = 'Looks like there\'s a problem. If the problem continues, get in touch with your administrator with the error ID shown here and any other related details.';

    //Method to do the callout to get the Shipping Info
    @AuraEnabled(cacheable=true)
    public static Map<String,String> fetchShippingInfo(String recordId) {
        Map<String,String> respMap = new Map<String,String>();
        try {
            List<Shipment__c> shipments = [SELECT Id, Shipment_Number__c FROM Shipment__c WHERE Id=:recordId];
            if(!shipments.isEmpty()) {
                //Using Named Credentials to access the Shipment Status System
                String endPointMethod = String.isNotBlank(shipments[0].Shipment_Number__c) ? 'trackingNumber='+shipments[0].Shipment_Number__c : '';
                HttpResponse res = handleCallout('callout:Merzcommunities/services/apexrest/mockShipmentStatus?'+endPointMethod , 'GET', null);
                //res.setStatusCode(201); //res.setBody('Error'); //For testing
                respMap.put(res.getStatusCode() == 200 ? 'Success' : 'Failed', res.getBody());
            } else {
                respMap.put('Failed', ERROR_MSG+' ID: '+recordId);
            }
            return respMap;
        } catch(Exception ex) {
            //Store the exception on the Custom Object for the tracking purpose
            respMap.put('Failed', ex.getMessage());
            return respMap;
        }
        
    }

    //Re-usable callout method, can be more generic.
    public static HttpResponse handleCallout(String endPoint, String reqMethod, String reqBody) {
        Http http = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod(reqMethod);
        if(String.isNotBlank(reqBody)) {
            req.setBody(reqBody);
        }

        HttpResponse res = http.send(req);

        return res;
    }
}