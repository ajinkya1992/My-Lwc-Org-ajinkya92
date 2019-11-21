({
	loop : function(component, event, helper) {
    var spaceList = component.get("v.spaceTypeList");
        alert(spaceList);
    var detail = component.get("v.detailRecord");
    var newlst =[];
    for(var i in spaceList){
        console.log(i);
        var space = spaceList[i];
        var detailtemp = {};
        detailtemp = detail;
        detailtemp.Name = space;
        console.log("detail space subset "+detailtemp.Name);
        newlst.push(detailtemp);
        console.log("value after iteration"+i+JSON.stringify(newlst));
    }
    component.set("v.acclst",newlst);
},
})