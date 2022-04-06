({
    doInit: function (component, event, helper){
        component.set('v.accountColumns', 
                      {label: 'Account Name', fieldName: 'linkName',type: 'url', 
                       typeAttributes:{label: { fieldName: 'Name' }, target: '_blank'}});
        var action=component.get("c.accountListResult");
        action.setCallback(this,function(response){            
            if(response.getState()=='SUCCESS'){
                var results=response.getReturnValue();
                if(results.length>0){
                    results.forEach(function(record){
                        record.linkName = '/lightning/cmp/c__accountDetails?c__recordId='+record.Id;//'/'+record.Id;
                    });
                    component.set('v.mydata', results); 
                }
            }
        });
        $A.enqueueAction(action);
    }
})