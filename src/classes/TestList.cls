@isTest(SeeAllData=true)
private class TestList {
    @isTest static void test() {
        RecordType[] rt = [SELECT Id, Name from RecordType where name = 'Made' AND SObjectType = 'Product__c'];
        if(rt.size() > 0){
            Product__c pr = new Product__c(Name = 'Test', Title__c = 'Test', Description__c = 'Test', Price__c = 200,
                                           Link_to_Image__c = 'https://www.popsci.com/sites/popsci.com/files/styles/1000_1x_/public/images/2018/03/senna.jpg?itok=eYNPMGjA&fc=50,50',
                                          RecordTypeId = rt[0].Id);
            insert pr;
        }
        TestDisplayQueryList test = new TestDisplayQueryList();
        test.colI = 10;
        PageReference pr = TestDisplayQueryList.redirect();
        PageReference pr1 = TestDisplayQueryList.redirectbuy();
        test.orderby();
        test.next();
        test.back();
        test.toorderby();
        test.tostart();
        test.toend();
    }
}