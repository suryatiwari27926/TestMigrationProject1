({
 myAction : function(component, event, helper) 
     {

 component.set('v.columns', [
            {label: 'Full Name', fieldName: 'Name', type: 'text' },
            {label: 'Last Name', fieldName: 'LastName', type: 'text' }
         ]);

         var ConList = component.get("c.getRelatedList");
         ConList.setParams
         ({
             recordId: component.get("v.recordId")
         });
        
         ConList.setCallback(this, function(data) 
                           {
                               component.set("v.ContactList", data.getReturnValue());
                           });
         $A.enqueueAction(ConList);
 }
})