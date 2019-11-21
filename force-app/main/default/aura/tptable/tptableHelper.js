({
addRecord: function(component, event) {
//get the account List from component 
var index = event.getSource().get("v.title");
var ProjectLcdList= component.get("v.ProjectLcdList");
var editList=ProjectLcdList[index].HeadcountmodalList;
editList.push({

'Month__c': 'Jan',

});
component.set("v.ProjectLcdList",ProjectLcdList);

},
})