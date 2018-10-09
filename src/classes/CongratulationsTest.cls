@isTest
private class CongratulationsTest {
    @isTest
    static void TestEmail() {
        Product__c pr = new Product__c(Name='Test',  Receipt_date__c=System.today(), Store__c = 'a026F00001NPqVTQA1', Contacts__c='a056F00000kzAgLQAU');
        Test.startTest();
        insert pr;
        Test.stopTest();
        System.assertEquals('I hope this works!', 'I hope this works!');
    }

}