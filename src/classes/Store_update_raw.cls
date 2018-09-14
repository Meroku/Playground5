public class Store_update_raw {
        public static string add(raw_material__c Obj) {
        List<Store__c> st = [SELECT ID FROM Store__c WHERE Start_Period__c <= :Obj.Receipt_date__c AND End_Period__c >= :Obj.Receipt_date__c];
        if(st.size() == 0) { 
            Test__c mc = Test__c.getOrgDefaults();
            Store__c store = new Store__c(Name = 'New Store',
                                          Start_Period__c = system.today(),
                                          End_Period__c = system.today() + mc.Number_of_days__c.intValue());
            insert store;
            return store.Id;
        }
        else {
            return st.get(0).Id;
        }
    }
}