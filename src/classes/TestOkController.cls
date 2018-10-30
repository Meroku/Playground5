@isTest
private class TestOkController {
    @isTest static void Test() {
        Store__c st = new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        insert st;
        Contacts__c cn = new Contacts__c(Name = 'Test', Email__c = 'test@mail.ru');
        insert cn;
        Product__c pr = new Product__c(Name='Test', Receipt_date__c=System.today(), Store__c = st.Id, Contacts__c = cn.Id);
        OkController ok = new OkController();
            System.assert(ok.Records != null);
        ok.Records.add(pr);
        PageReference pref = ok.Home();
    }
}