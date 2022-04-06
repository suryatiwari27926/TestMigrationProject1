trigger ClosingStageTrigger on Contact (before insert, before update) {
    
    For(Contact con : trigger.new){
        
        If ((trigger.isInsert || 
             (trigger.isUpdate && con.Amount_Check__c != trigger.oldMap.get(con.Id).Amount_Check__c)) 
             && con.Amount_Check__c){
            Decimal TotalAmount = (con.interested__c != null ? con.interested__c : 0)  
                                    + (con.signed__c != null ? con.signed__c : 0) 
                                    + (con.funded__c != null ? con.funded__c : 0);
            Decimal InvestAmount = ((con.Investment_Amount__c != null ? con.funded__c : 0) * 5) / 100;
            If(TotalAmount > InvestAmount && con.Closing_Stage__c == 'Active'){
                con.Closing_Stage__c = 'Waitlist';
            }
        }
    }
}