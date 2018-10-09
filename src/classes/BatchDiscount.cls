global class BatchDiscount implements 
    Database.Batchable<sObject>, Database.Stateful {
        global Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator('Select Start_Date__c, End_Date__c, Status__c ' +
                                           'From Discount__c');}
        global void execute(Database.BatchableContext bc, List<Discount__c> scope){
            List<Discount__c> disc = new List<Discount__c>();
            for(Discount__c d : scope) {
                if (d.Start_Date__c > system.today()) {
                    d.Status__c = 'Not Started';
                } else if(d.End_Date__c < system.today()) {
                    d.Status__c = 'Ended';
                } else {
                    d.Status__c = 'Active';
                }
                disc.add(d);
            }
            update disc;
        }
        global void finish(Database.BatchableContext bc){
             System.debug('Batch complete!');
        }
}