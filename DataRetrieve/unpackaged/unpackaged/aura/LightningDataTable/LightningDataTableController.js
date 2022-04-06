({
    doInit : function(component, event, helper) {
        helper.getDataHelper(component, event);
    },
    
    onSave : function( component, event, helper ) {   
        var updatedRecords = component.find( "conTable" ).get( "v.draftValues" );
        var action = component.get( "c.updateContacts" );
        action.setParams({  
            'updatedContactList' : updatedRecords
        }); 
        
        action.setCallback( this, function(response) {  
            var state = response.getState();   
            
            if ( state === "SUCCESS" ) {  
                component.set('v.mydata', response.getReturnValue());
                if ( response.getReturnValue().length != 0 ) {  
                    helper.toastMsg( 'success', 'Records Saved Successfully.' );  
                    component.find( "conTable" ).set( "v.draftValues", null ); 
                    $A.get("e.force:refreshView").fire();
                } else {   
                    helper.toastMsg( 'error', 'Something went wrong. Contact your system administrator.' );  
                }  
            } else {  
                helper.toastMsg( 'error', 'Something went wrong. Contact your system administrator.' );  
            }  
        });  
        $A.enqueueAction( action );  
    },
    handleRowAction: function ( cmp, event, helper ) {
        
        var action = event.getParam( 'action' );
        var row = event.getParam( 'row' );
        var recId = row.Id;
        
        switch ( action.name ) {
            case 'edit':
                var editRecordEvent = $A.get("e.force:editRecord");
                editRecordEvent.setParams({
                    "recordId": recId
                });
                editRecordEvent.fire();
                break;
            case 'view':
                var viewRecordEvent = $A.get("e.force:navigateToURL");
                viewRecordEvent.setParams({
                    "url": "/" + recId
                });
                viewRecordEvent.fire();
                break;
                
            case 'delete': console.log('checking--------------1');
                var deleteAction = cmp.get('c.deleteContacts');
                console.log('checking--------------2',recId);
                deleteAction.setParams({
                    recordId: recId
                }); console.log('checking--------------3');
                
                deleteAction.setCallback( this, function(response) {  
                     console.log('checking--------------4');
                    var state = response.getState();   
                   
                    if ( state === "SUCCESS" ) {  
                        console.log('checking--------------5',state);
                        if ( response.getReturnValue() == true ) { 
                            console.log('checking--------------6');
                            helper.toastMsg( 'success', 'Records deleted Successfully.' );  
                            component.find( "conTable" ).set( "v.draftValues", null ); 
                            $A.get("e.force:refreshView").fire();
                        } else {   
                            helper.toastMsg( 'error', 'Something went wrong. Contact your system administrator.' );  
                        }  
                    } else {  
                        helper.toastMsg( 'error', 'Something went wrong. Contact your system administrator.' );  
                    } 
                }); 
         		$A.enqueueAction( deleteAction );  
        }
    }
})