({
    doInit : function(component, event, helper){
        var action = component.get("c.getContacts");    
        var pageSize = component.get("v.pageSize");
        action.setParams({
            recordId : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if (component.isValid() && state === "SUCCESS"){                
                component.set('v.ContactList', response.getReturnValue());
                component.set("v.totalSize", component.get("v.ContactList").length);
                component.set("v.start",0);
                component.set("v.end",pageSize-1);
                var paginationList = [];
                
                for(var i=0; i< pageSize; i++){
                    paginationList.push(response.getReturnValue()[i]);
                }
                component.set('v.paginationList', paginationList);
            }
        });
        $A.enqueueAction(action);
    },
    
    onSelectChange : function(component, event, helper) {
        var selected = component.find("records").get("v.value");
        var paginationList = [];
        var oppList = component.get("v.ContactList");
        
        for(var i=0; i< selected; i++){
            paginationList.push(oppList[i]);
        }
        component.set('v.paginationList', paginationList);
    },
    
    first : function(component, event, helper){
        var oppList = component.get("v.ContactList");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        for(var i=0; i< pageSize; i++){
            paginationList.push(oppList[i]);
        }
        component.set('v.paginationList', paginationList);
    },
    
    last : function(component, event, helper){
        var oppList = component.get("v.ContactList");
        var pageSize = component.get("v.pageSize");
        var totalSize = component.get("v.totalSize");
        var paginationList = [];
        
        for(var i=totalSize-pageSize+1; i< totalSize; i++){
            paginationList.push(oppList[i]);
        }
        component.set('v.paginationList', paginationList);
    },
    
    next : function(component, event, helper){
        var oppList = component.get("v.ContactList");
        var end = component.get("v.end");
        var start = component.get("v.start");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        var counter = 0;
        
        for(var i=end+1; i<end+pageSize+1; i++){
            if(oppList.length > end){
                paginationList.push(oppList[i]);
                counter ++ ;
            }
        }
        start = start + counter;
        end = end + counter;
        component.set("v.start",start);
        component.set("v.end",end);
        component.set('v.paginationList', paginationList);
    },
    
    previous : function(component, event, helper){
        var oppList = component.get("v.ContactList");
        var end = component.get("v.end");
        var start = component.get("v.start");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                paginationList.push(oppList[i]);
                counter ++;
            } else {
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.start",start);
        component.set("v.end",end);
        component.set('v.paginationList', paginationList);
    }
})