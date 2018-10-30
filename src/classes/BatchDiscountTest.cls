@isTest private class BatchDiscountTest {
   @testSetup
    static void setup() {
        Discount__c dt = new Discount__c(Name = 'Test',
                                        Start_Date__c = System.now(),
                                        End_Date__c = System.now()+1);
        insert dt;
    }
    static testmethod void test() {
        Test.startTest();
        BatchDiscount bd = new BatchDiscount();
        Id batchId = Database.executeBatch(bd);
        Test.stopTest();
        Discount__c actual = [select Status__c from Discount__c where Name = 'Test' limit 1];
        System.assertEquals('Not Started', actual.Status__c);
    }
}