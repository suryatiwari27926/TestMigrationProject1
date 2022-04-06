public with sharing class Contact_Pagination {

    @AuraEnabled
    public static List<Contact> getContacts(String recordId){
        return [SELECT Id, Name, FirstName, LastName, Account.Name, Phone, Email
                FROM Contact 
                WHERE AccountId=: recordId];
    }
}