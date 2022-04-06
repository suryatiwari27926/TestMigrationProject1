public class AccountList {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> accountListResult(){
        return [SELECT Id, Name, Phone, AccountNumber, Website, Industry,  CreatedDate FROM Account];
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> selectedAccountRecords(String recordId){
        system.debug('recordId--------id----'+recordId);
        return [SELECT Id, Name, Phone, AccountNumber, Website, Industry,  CreatedDate 
                FROM Account WHERE Id =: recordId];
    }
}