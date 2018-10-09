trigger Congratulations on Product__c (after insert) {
    for(Product__c pr : [select Id, Contacts__c from Product__c where Id in :Trigger.New and RecordType.Name = 'Sold']) {
            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), pr.Contacts__c, ConnectApi.FeedElementType.FeedItem, 'I hope this works!');
    }
}