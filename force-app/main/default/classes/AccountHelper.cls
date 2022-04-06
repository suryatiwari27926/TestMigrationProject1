public with sharing class AccountHelper {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Type, Rating,
                Phone, Website, AnnualRevenue
            FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Phone, Title, FirstName, LastName, AccountId, account.name, MailingStreet, 
                        MailingCity, MailingState, MailingPostalCode, MailingCountry, Email  
                FROM Contact
                ];
        /*return [SELECT Id, Name, Phone, Title, Email
            FROM Contact];*/
    }
 
    @AuraEnabled(cacheable=true)
    public static List<Lead> getLeadList() {
        return [SELECT Id, Name, Company, Status, Phone
            FROM Lead];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return [SELECT Id, FirstName, LastName, AccountId, account.name, MailingStreet, 
                        MailingCity, MailingState, MailingPostalCode, MailingCountry, Email  
                FROM Contact
                ];
    }

    @AuraEnabled(cacheable=True)
    public static List<Contact> searchContact(String searchString){
        List<List<SObject>> contacts = [FIND :searchString IN ALL FIELDS RETURNING Contact(FirstName, LastName, Email, mailingStreet,
                                        mailingCity, mailingCountry, mailingPostalCode, account.Name)];
                                        
        return (List<Contact>) contacts[0];
                                        
        
    }

    @AuraEnabled
    public static void deleteContacts(List<Id> contactIds){
        if (contactIds.size() >0 ) {
            delete [SELECT Id FROM Contact WHERE Id in: contactIds];
        }

    }

}