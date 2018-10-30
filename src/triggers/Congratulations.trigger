trigger Congratulations on Product__c (after insert) {
    List<Product__c> products = [select Id, Contacts__c from Product__c where Id in :Trigger.New and RecordType.Name = 'Sold'];
    for(Product__c pr : products) {
            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), pr.Contacts__c, ConnectApi.FeedElementType.FeedItem, 'I hope this works!');
    }
}