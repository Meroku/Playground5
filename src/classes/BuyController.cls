public class BuyController {
    public List<Product__c> Records {get; set;}
    public List<Contacts__c> cnts {get; set;}
    public Contacts__c cnt {get; set;}
    public Discount__c dst {get; set;}
    public string BuyID {get; set;}
    public Boolean acc {get; set;}
    public Discount__c dd {get; set;}
    
    public BuyController(){
        acc = false;
        dd = new Discount__c();
        string un = UserInfo.getUserName();
        
        List<Discount__c> discounts = [select Name, Percentes_of_discount__c, Static_discount__c from Discount__c where Account__r.Name = :un];
        for(Discount__c discount : discounts) {
            acc = true;
            dd = discount;
        }
                
        cnt = new Contacts__c();
        dst = new Discount__c();
        BuyID = ApexPages.currentPage().getParameters().get('id');
        Records =
            [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where ID = :BuyID];
        String message = '' + ApexPages.CurrentPage().GetParameters().Get('message');
        String pageHeaderReferer = ApexPages.currentPage().getHeaders().get('Referer'); 
        
        // Use the referrer parameter to only show the message when coming from Page 1
        if(pageHeaderReferer != null && pageHeaderReferer.containsIgnoreCase('PageName') && message != 'null')
        {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, message)); 
        }
    }
    public PageReference buy() {
        string putid = '';
        cnts = [Select Name, Phone__c, Email__c From Contacts__c Where Email__c = :cnt.Email__c Limit 1];
        if (cnts.size() == 0){
            insert cnt;
            putid = cnt.id;
        } else {
            for(Contacts__c c : cnts) {
                c.Name = cnt.Name;
                c.Phone__c = cnt.Phone__c;
                update c;
                putid = c.id;
            }
        }
        List<Product__c> newPr1 = [select Name, Title__c, Description__c, Price__c, Link_to_Image__c, Amount__c from Product__c where ID = :BuyID];
        for(Product__c pr : newPr1) {
            pr.Amount__c--;
            update pr;
        }
        
        List<Discount__c> dsts = [Select Discount_Code__c, Percentes_of_discount__c, Static_discount__c From Discount__c Where Discount_Code__c = :dst.Discount_Code__c Limit 1];
        string pid = '';
        Product__c prti = new Product__c();
        RecordType[] rt1 = [SELECT Id, Name from RecordType where name = 'Sold' AND SObjectType = 'Product__c'];
        RecordType rt = new RecordType(Id = null, Name = 'Sold');
        if(rt1.size() > 0) {rt.Id = rt1[0].Id;}
        List<Product__c> newPr = [select Name, Title__c, Description__c, Price__c, Cost_with_discount__c, Link_to_Image__c from Product__c where ID = :BuyID];
        for(Product__c pr : newPr) {
            prti.Name = pr.Name + '(Sold)';
            prti.Title__c = pr.Title__c;
            prti.Description__c = pr.Description__c;
            prti.Price__c = pr.Price__c;
            prti.Link_to_Image__c = pr.Link_to_Image__c;
            prti.Amount__c = 1;
            prti.RecordTypeId = rt.Id;
            prti.Contacts__c = putid;
            if(acc = false) {
                if(dsts.size() != 0){
                    for(Discount__c d : dsts){
                        prti.Cost_with_discount__c = pr.Price__c*(100 - d.Percentes_of_discount__c)*0.01 - d.Static_discount__c;
                    }
                }
            } else {
                prti.Cost_with_discount__c = pr.Price__c*(100 - dd.Percentes_of_discount__c)*0.01 - dd.Static_discount__c;
            }
            
            
            if(prti.Cost_with_discount__c < 0) {prti.Cost_with_discount__c = 0;}
            insert prti;
        }
        PageReference pg = new PageReference('/apex/Ok?id=' + prti.Id);
        //pg.getParameters().put('message', 'Your Message here');
        return pg;
    }
}