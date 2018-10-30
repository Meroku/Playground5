@isTest
private class TestFileUploader {
    @isTest static void Test(){
        FileUploader fu = new FileUploader();
        fu.nameFile = 'Test';
        PageReference pr = fu.ReadFile();
        List<raw_material__c> testList = fu.getuploadedAccounts();
    }

}