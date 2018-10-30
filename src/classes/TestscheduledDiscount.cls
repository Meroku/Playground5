@isTest
private class TestscheduledDiscount {
    static testmethod void TestDiscountChange() {
        Discount__c dt = new Discount__c(Name = 'Test',
                                         Start_Date__c = System.now(),
                                         End_Date__c = System.now()+1);
        insert dt;
        
        Test.startTest();
        System.schedule('ScheduleApexTest', '0 0 0 11 10 ? 2019', new scheduledDiscount());
        Test.stopTest();
        
        List<Task> tsk = [SELECT Id FROM Task WHERE WhatId = :dt.Id];
        System.assertNotEquals(1, tsk.size());
    }
}