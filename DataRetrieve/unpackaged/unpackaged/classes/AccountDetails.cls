public class AccountDetails {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> accountListResult(){
        return [SELECT Id, Name, Phone, AccountNumber, Website, Industry,  CreatedDate FROM Account];
    }
}