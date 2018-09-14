trigger Congratulations on Product__c (before insert) {
    for(Product__c pr : Trigger.New) {
                    Contacts__c c = [Select Email__c From Contacts__c Where Id = :pr.Contacts__c];
        if(pr.RecordType.Name == 'Sold'){
                    EmailManager.sendMail('maxim53shkrob@gmail.com', 'Congratulations on your purchase', 
                    'Your ship name is ' + pr.Name + ' and it is price is ' +  pr.Price__c);
        }    
    }
}