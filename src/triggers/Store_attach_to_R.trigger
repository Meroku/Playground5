trigger Store_attach_to_R on raw_material__c (before insert) {
    for(raw_material__c raw : Trigger.New){
        raw.Store__c = Store_update_raw.add(raw);
    } 
}