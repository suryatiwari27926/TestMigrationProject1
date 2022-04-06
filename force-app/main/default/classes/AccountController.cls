public with sharing class AccountController {
    public static List<Account> getAllActiveAccounts() {
      return [SELECT Id,Name, Company, Active__c FROM Account WHERE Active__c = 'Yes'];
    }
  }