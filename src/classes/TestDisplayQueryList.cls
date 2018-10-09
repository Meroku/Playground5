public class TestDisplayQueryList {
    public List<Product__c> Records {get; set;}
    public List<Product__c> Products {get; set;}
    public String selected{get;set;}
    public List<SelectOption> Options {get; set;}
    public List<SelectOption> Pages {get; set;}
    public String col{get;set;}
    public Integer colI{get;set;}
    public Integer num{get;set;}
    
    public TestDisplayQueryList(){
        
        Options = new List<SelectOption>();
        Options.add(new SelectOption('None','None'));
        Options.add(new SelectOption('Name','Name'));
        
        Pages = new List<SelectOption>(); // Here we add col of records at one page
        Pages.add(new SelectOption('5', '5'));
        Pages.add(new SelectOption('10', '10'));
        Pages.add(new SelectOption('15', '15'));
        Records = new List<Product__c>();
        col = '5';
        selected = 'None';
        num = 1;
        Products = [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where RecordType.Name = 'Made'];
        for(Integer i = 0; i < Integer.valueOf(col); i++){
            Records.add(Products.get(i));
        }
        colI = Products.size()/Integer.valueOf(col) + 1;
        //Records =
        //    [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where RecordType.Name = 'Made' limit 15];
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
        Integer i;
        Integer n;
        if(num == 1){
            i = 0;
            n = 1;
        }
        else {
            i = (num-1)*Integer.valueOf(col);
            n = num;
        }
        if(selected.equals('Name')){
            Records.clear();
            List<Product__c> Products = [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where RecordType.Name = 'Made' Order by Name];
            for(; i < n*Integer.valueOf(col); i++){
                if(i>=Products.size()) {break;} else {
                    Records.add(Products.get(i));
                }
                
            }
        }
        else { 
            Records.clear();
            Products = [select Name, Title__c, Description__c, Price__c, Link_to_Image__c from Product__c where RecordType.Name = 'Made'];
            for(; i < n*Integer.valueOf(col); i++){
                if(i>=Products.size()) {break;} else {
                    Records.add(Products.get(i));
                }
            }
        }
        colI = Products.size()/Integer.valueOf(col) + 1;
    }

    public void next(){
        num++;
        orderby();
    }
    
    public void back(){
        num--;
        orderby();
    }
    public void toorderby(){
        orderby();
    }
        public void tostart(){
            num = 1;
        orderby();
    }    public void toend(){
        num = Products.size()/Integer.valueOf(col) + 1;
        orderby();
    }
}