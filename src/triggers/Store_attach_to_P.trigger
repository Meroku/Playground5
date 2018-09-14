trigger Store_attach_to_P on Product__c (before insert) {
    for(Product__c pr : Trigger.New){
        pr.Store__c = Store_update_pr.add(pr);
    }
}