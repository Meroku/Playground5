@isTest(SeeAllData=true)
private class TestBuyController {
    @isTest static void TestController() {
        BuyController bc = new BuyController();
        RecordType[] rt1 = [SELECT Id, Name from RecordType where name = 'Sold' AND SObjectType = 'Product__c'];
        Store__c st = new Store__c(Name = 'Store', Start_Period__c = System.today(), End_Period__c = System.today() + 30);
        Contacts__c cn = new Contacts__c(Name = 'Test');
        insert cn;
        insert st;
        if(rt1.size() > 0){
            Product__c Pr = new Product__c(Name='Test', Store__c = st.Id, Amount__c = 15, RecordTypeId = rt1[0].Id, Contacts__c = cn.Id,
                                          Price__c = 100, Cost_with_discount__c = 0);
            insert Pr;
            Test__c t = new Test__c(Number_of_days__c = 15);
            bc.BuyId = Pr.Id;
        }
        PageReference prTest = bc.buy();
        System.assert(bc.dd != null);
        System.assert(bc.Records != null);
    }
    
}