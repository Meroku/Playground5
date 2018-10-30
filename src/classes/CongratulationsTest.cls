@isTest
private class CongratulationsTest {
    @isTest
    static void TestEmail() {
        Store__c st =  new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        insert st;
        Test__c t = new Test__c(Number_of_days__c = 15);
        insert t;
        Contacts__c cnt = new Contacts__c(Name = 'Test');
        Product__c pr = new Product__c(Name='Test',  Receipt_date__c=System.today(), Store__c = st.Id, Contacts__c= cnt.Id);
        Test.startTest();
        Database.SaveResult result = Database.insert(pr);
        //insert pr;
        Test.stopTest();
        List<FeedItem> feedItems = [SELECT Id FROM FeedItem WHERE CreatedById = :UserInfo.getUserId() ORDER BY CreatedDate DESC];
        System.assertEquals( 0, feedItems.size());
    }

}