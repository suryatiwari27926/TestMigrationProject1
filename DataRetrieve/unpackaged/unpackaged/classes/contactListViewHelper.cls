public with sharing class contactListViewHelper {
    
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

    @AuraEnabled
    public static List<Contact> getContactData(String recordId){
            system.debug('recordId ---- '+recordId);
            return [SELECT Id, FirstName, LastName, Birthdate, MailingAddress, Account.Name, Account.AccountNumber  FROM Contact WHERE Id =: recordId];
        

    }
}