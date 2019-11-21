({
    addTab: function(component, event) {
        var detail = component.get("v.moretabs");
        var newlst =[];
        newlst.push(detail);
        for(var i=0; i <4; i++){
            $A.createComponent("lightning:tab", {
                "label": "New Tab"+i,
                "id": "new"+i,
                "onactive": component.getReference("c.addContent")
            }, function (newTab, status, error) {
                if (status === "SUCCESS") {
                    
                    newlst.push(newTab);
                    
                    component.set("v.moretabs", newlst);
                } else {
                    throw new Error(error);
                }
            });
        }
    },
    
    addContent : function(component, event) {
        var tab = event.getSource();
        switch (tab.get('v.id')){
            case 'new':
                $A.createComponent("lightning:badge", {
                    "label": "NEW"
                }, function (newContent, status, error) {
                    if (status === "SUCCESS") {
                        tab.set('v.body', newContent);
                    } else {
                        throw new Error(error);
                    }
                });
                break;
        }
    }
})