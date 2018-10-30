@isTest
private class NewAccountTest {
    @isTest
    static void AccountCreationTest() {
        Profile pr = [Select Id From Profile Where Name='System Administrator'];
        Id profileId = pr.Id;
        User us = new User(Username = 'test123541@salesforce.com', Email = 'testmail@gmail.com', LastNAme = 'Boris', 
                          TimeZoneSidKey = 'Europe/Paris', LocaleSidKey = 'en_US', EmailEncodingKey = 'UTF-8',
                          ProfileId = profileId, LanguageLocaleKey = 'en_US', Alias = 'test');
        Test.startTest();
        Database.SaveResult res = Database.insert(us);
        //insert us;
        Test.stopTest();
        List<Account> ac = [Select Id, Name From Account Where Name = 'test123541@salesforce.com' limit 1];
        System.assertEquals(1, ac.size());
    }

}