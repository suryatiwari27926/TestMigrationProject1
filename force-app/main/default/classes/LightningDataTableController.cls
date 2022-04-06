public class LightningDataTableController {
    
    @AuraEnabled
    public static DataTableResponse getAccRecords(String strObjectName, String strFieldSetName, String recordId){                
        //Get the fields from FieldSet
        Schema.SObjectType SObjectTypeObj = Schema.getGlobalDescribe().get(strObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();            
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(strFieldSetName);
        
        //To hold the table hearders 
        List<DataTableColumns> lstDataColumns = new List<DataTableColumns>();
        
        //Field to be queried - fetched from fieldset
        List<String> lstFieldsToQuery = new List<String>();
        
        //The final wrapper response to return to component
        DataTableResponse response = new DataTableResponse();
        
        for( Schema.FieldSetMember eachFieldSetMember : fieldSetObj.getFields() ){
            String dataType = String.valueOf(eachFieldSetMember.getType()).toLowerCase();
            //This way we can set the type of a column
            //We do not get the exact type from schema object which matches to lightning:datatable component structure
            if(dataType == 'datetime'){
                dataType = 'date';
            }
            
            //Create a wrapper instance and store label, fieldname, type and editable.
            DataTableColumns datacolumns = new DataTableColumns();
            datacolumns.label =String.valueOf(eachFieldSetMember.getLabel());
            datacolumns.fieldName =String.valueOf(eachFieldSetMember.getFieldPath());
            datacolumns.type =String.valueOf(eachFieldSetMember.getType()).toLowerCase();
            datacolumns.editable ='true';
            
            lstDataColumns.add(datacolumns);
            lstFieldsToQuery.add(String.valueOf(eachFieldSetMember.getFieldPath()));
        }
        List<rowActionWrapper> actList = new List<rowActionWrapper>();
        rowActionWrapper act = new rowActionWrapper();
        act.label = 'Edit';
        act.name = 'edit';
        actList.add(act);
        
        rowActionWrapper act1 = new rowActionWrapper();
        act1.label = 'View';
        act1.name = 'view';
        actList.add(act1);
        rowActionWrapper act2 = new rowActionWrapper();
        act2.label = 'Delete';
        act2.name = 'delete';
        actList.add(act2);
        
        typeAttributesWrapper typeAtt = new typeAttributesWrapper();
        typeAtt.rowActions = actList;
        DataTableColumns datacolumns = new DataTableColumns();
        datacolumns.type ='action';
        datacolumns.typeAttributes = typeAtt;
        lstDataColumns.add(datacolumns);
        system.debug('datacolumnssssssssssssssssssssssssss------'+datacolumns);
        
        //Form an SOQL to fetch the data - Set the wrapper instance and return as response
        if(! lstDataColumns.isEmpty()){            
            response.lstDataTableColumns = lstDataColumns;
            String query = 'SELECT Id, ' + String.join(lstFieldsToQuery, ',') + ' FROM Contact Where AccountId =: recordId';
            System.debug(query);
            response.lstDataTableData = Database.query(query);
        }
        return response;
    }
    
    //Wrapper class to hold Columns with headers
    public class DataTableColumns {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String fieldName {get;set;}
        @AuraEnabled public String type {get;set;}
        @AuraEnabled public String editable {get;set;}
        @AuraEnabled public typeAttributesWrapper typeAttributes {get;set;}
    }
    
    public class typeAttributesWrapper {
        @AuraEnabled public List<rowActionWrapper> rowActions {get;set;}
    }
    public class rowActionWrapper {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String name {get;set;}
    }
    
    
    //Wrapper class to hold response - This response is used in the lightning:datatable component
    public class DataTableResponse {
        @AuraEnabled
        public List<DataTableColumns> lstDataTableColumns {get;set;}
        @AuraEnabled
        public List<sObject> lstDataTableData {get;set;}                
        
        public DataTableResponse(){
            lstDataTableColumns = new List<DataTableColumns>();
            lstDataTableData = new List<sObject>();
        }
    }
    @AuraEnabled    
    public static List < Contact > updateContacts( List < Contact > updatedContactList ) {    
        try {  
            update updatedContactList;  
            system.debug('updatedContactList----'+updatedContactList);
            
        } catch(Exception e) {  
            
        }  
        return updatedContactList;
    }    
    @AuraEnabled    
    public static boolean deleteContacts(String recordId) {    
        try {  
            system.debug('recordId ---- '+recordId);
            delete [SELECT Id FROM Contact WHERE Id =:recordId];  
            return true;
        } catch(Exception e) {  
            return false;
            
        }  
        
    }    
}