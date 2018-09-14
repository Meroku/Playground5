public class TestDisplayQueryList {
    public List<Product__c> Records {get; set;}
    //public String IdToRedirect {get; set;}
    public String selected{get;set;}
    public List<SelectOption> Options {get; set;}
    
    public TestDisplayQueryList(){
        Options = new List<SelectOption>();
        Options.add(new SelectOption('None','None'));
        Options.add(new SelectOption('Name','Name'));
        Records =
            [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where RecordType.Name = 'Made'];
    }
    public PageReference redirect()
    {
        PageReference pr = new PageReference('/apex/ProductPage?id=' + ApexPages.currentPage().getParameters().get('IdToRedirect'));
        pr.setRedirect(true);
        return pr;
    }
    public PageReference redirectbuy()
    {
        PageReference pr = new PageReference('/apex/BuyProduct?id=' + ApexPages.currentPage().getParameters().get('IdToRedirect1'));
        return pr;
    }
    public void orderby() {
        if(selected.equals('Name')){
            Records = [select Name, Title__c, Description__c, Price__c, Link_to_Image__c 
                       from Product__c where RecordType.Name = 'Made' Order by Name];
}
        else { 
            Records = [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where RecordType.Name = 'Made'];
        }
    }
}