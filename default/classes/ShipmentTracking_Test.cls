/**
@ClassName		- ShipmentTracking_CC 
@Purpose		- This is the Test Class for ShipmentTracking_CC class
@CreatedDate	- 22/Apr/2024
* @Author		- Saravanan Sekar
**/ 
@isTest
private class ShipmentTracking_Test {

    @testSetup static void testSetupMethod() {
        Shipment__c shipment = new Shipment__c();
        shipment.Shipment_Number__c = '123455';
        shipment.Name='Shipping to Texas';
        insert shipment;
    }
    
    @istest
    static void fetchShippingInfoPositive() {
        Shipment__c shipment = [SELECT Id,Shipment_Number__c FROM Shipment__c Limit 1];
        Test.startTest();
        API_MockGenerator_CC mock = new API_MockGenerator_CC(200, 'OK', 'Shipped- On Time');
        Test.setMock(HttpCalloutMock.class, mock);
        Map<String,String> respMap = new Map<String,String>();
        respMap = ShipmentTracking_CC.fetchShippingInfo(shipment.Id);
        System.assertEquals('Shipped- On Time', respMap.get('Success'));
        Test.stopTest();
    }
    
    @istest
    static void fetchShippingInfoNegative() {
        Shipment__c shipment = [SELECT Id,Shipment_Number__c FROM Shipment__c Limit 1];
        Test.startTest();
        Map<String,String> respMap = new Map<String,String>();
        respMap = ShipmentTracking_CC.fetchShippingInfo(shipment.Id+'ABCD');
        
        System.assert(respMap.get('Failed')!=null);
                                    
        Test.stopTest();
    }
}