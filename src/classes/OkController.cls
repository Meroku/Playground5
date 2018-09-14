public class OkController {
    public string BuyID {get; set;}
    public List<Product__c> Records {get; set;}
    public OkController() {
        BuyID = ApexPages.currentPage().getParameters().get('id');
        Records =
            [select Name, Title__c, Cost_with_discount__c, Price__c, Link_to_Image__c, Contacts__c from Product__c where Id = :BuyID];
        /*for(Product__c pr : Records) {
Contacts__c c = [Select Email__c From Contacts__c Where Id = :pr.Contacts__c];
EmailManager.sendMail(c.Email__c, 'Congratulations on your purchase', 
'Your ship name is ' + pr.Name + ' and it is price is ' +  pr.Price__c);
}*/
        Send();
    }
    
    public PageReference Home() {
        for(Product__c pr : Records) {
            Contacts__c c = [Select Email__c From Contacts__c Where Id = :pr.Contacts__c];
            EmailManager.sendMail(c.Email__c, 'Congratulations with your purchase', 
                                  'Your ship name is ' + pr.Name + ' and it is price is ' +  pr.Price__c);
        }
        PageReference pg = new PageReference('/apex/TestTable');
        return pg;
    }
    public void Send() {
        for(Product__c pr : Records) {
            Contacts__c c = [Select Email__c From Contacts__c Where Id = :pr.Contacts__c];
            EmailManager.sendMail(c.Email__c, 'Congratulations with your purchase', 
                                  'Your ship name is ' + pr.Name + ' and it is price is ' +  pr.Price__c);
        }
    }
}