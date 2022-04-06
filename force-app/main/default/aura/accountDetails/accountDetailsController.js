({
    doInit: function (component, event, helper){
        component.set('v.myColumns', [
            {label: 'Account Name', fieldName: 'Name',type: 'text'},            
            {label: 'Phone', fieldName: 'Phone',type: 'text'},
            {label: 'AccountNumber', fieldName: 'AccountNumber',type: 'text'},
            {label: 'Created Date', fieldName: 'CreatedDate',type: 'date'},
            {label: 'Website', fieldName: 'Website',type: 'url'},
            {label: 'Industry', fieldName: 'Industry',type: 'text'}]);
        
        var myPageRef = component.get("v.pageReference");
        var recId = myPageRef.state.c__recordId;
        
        var action=component.get("c.selectedAccountRecords");
        action.setParams({recordId: recId});
        action.setCallback(this,function(response){            
			var results=response.getReturnValue();        
			if(response.getState()=='SUCCESS'){
                component.set('v.mydata', results);
            }
        });
        $A.enqueueAction(action);
    },
    handleClick : function (component, event, helper){
    	 var myPageRef = component.get("v.pageReference");
        var recId = myPageRef.state.c__recordId;
        console.log('recId', recId);
        var createRecordEvent = $A.get("e.force:createRecord");
        
        createRecordEvent.setParams({
            "entityApiName": "Contact",
            "defaultFieldValues": {
                'AccountId' : recId
            }
        });
        createRecordEvent.fire();
    }
})