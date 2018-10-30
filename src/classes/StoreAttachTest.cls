@isTest
private class StoreAttachTest {
    @isTest static void TestR1() {
        Store__c st = new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        insert st;
        raw_material__c raw = new raw_material__c(Name='Test', Name__c='Test', Title__c='Main', Receipt_date__c=System.today(), Store__c = st.Id);
        Test.startTest();
        Database.SaveResult res = Database.insert(raw);
        //insert raw;
        Test.stopTest();
        System.assertEquals(st.Id, raw.Store__c);
    }
    @isTest static void TestR2() {
        Store__c st = new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        insert st;
        Test__c t = new Test__c(Number_of_days__c = 15);
        insert t;
        raw_material__c raw = new raw_material__c(Name='Test', Name__c='Test', Title__c='Main', Receipt_date__c=date.parse('12/27/2020'), Store__c = st.Id);
        Test.startTest();
        Database.SaveResult res = Database.insert(raw);
        //insert raw;
        Test.stopTest();
        System.assertEquals(st.Id, raw.Store__c);
    }
    @isTest static void TestP1() {
        Store__c st = new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        insert st;
        Product__c pr = new Product__c(Name='Test', Receipt_date__c=System.today(), Store__c = st.Id);
        Test.startTest();
        Database.SaveResult res = Database.insert(pr);
        //insert pr;
        Test.stopTest();
        System.assertEquals(st.Id, pr.Store__c);
    }
    @isTest static void TestP2() {
        Store__c st = new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        insert st;
        Test__c t = new Test__c(Number_of_days__c = 15);
        insert t;
        Product__c pr = new Product__c(Name='Test', Receipt_date__c=date.parse('12/27/2020'), Store__c = st.Id);
        Test.startTest();
        Database.SaveResult res = Database.insert(pr);
        //insert pr;
        Test.stopTest();
        System.assertEquals(st.Id, pr.Store__c);
    }
}