@isTest
private class StoreAttachTest {
    @isTest static void TestR1() {
        raw_material__c raw = new raw_material__c(Name='Test', Name__c='Test', Title__c='Main', Receipt_date__c=System.today(), Store__c = 'a026F00001NPqVTQA1');
        Test.startTest();
        insert raw;
        Test.stopTest();
        System.assertNotEquals('a026F00001NPqVTQA1', raw.Store__c);
    }
        @isTest static void TestR2() {
        raw_material__c raw = new raw_material__c(Name='Test', Name__c='Test', Title__c='Main', Receipt_date__c=date.parse('12/27/2020'), Store__c = 'a026F00001NPqVTQA1');
        Test.startTest();
        insert raw;
        Test.stopTest();
        System.assertNotEquals('a026F00001NPqVTQA1', raw.Store__c);
    }
        @isTest static void TestP1() {
        Product__c pr = new Product__c(Name='Test', Receipt_date__c=System.today(), Store__c = 'a026F00001NPqVTQA1');
        Test.startTest();
        insert pr;
        Test.stopTest();
        System.assertNotEquals('a026F00001NPqVTQA1', pr.Store__c);
    }
        @isTest static void TestP2() {
        Product__c pr = new Product__c(Name='Test', Receipt_date__c=date.parse('12/27/2020'), Store__c = 'a026F00001NPqVTQA1');
        Test.startTest();
        insert pr;
        Test.stopTest();
        System.assertNotEquals('a026F00001NPqVTQA1', pr.Store__c);
    }
}