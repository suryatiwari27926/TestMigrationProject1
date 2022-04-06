({
    getDataHelper : function(component, event) {
        var action = component.get("c.getAccRecords");
        //Set the Object parameters and Field Set name and recordId
        action.setParams({
            strObjectName : 'Contact',
            strFieldSetName : 'Demo_Field_Set',
            recordId : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set("v.mycolumns", response.getReturnValue().lstDataTableColumns);
                component.set("v.mydata", response.getReturnValue().lstDataTableData);  
            }else if (state === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }else{
                console.log('Something went wrong, Please check with your admin');
            }
        });
        $A.enqueueAction(action);	
    },
    
    toastMsg : function( strType, strMessage ) {  
        var showToast = $A.get( "e.force:showToast" );   
        showToast.setParams({   
            message : strMessage,  
            type : strType,  
            mode : 'sticky'  
        });   
        showToast.fire();   
    }
})