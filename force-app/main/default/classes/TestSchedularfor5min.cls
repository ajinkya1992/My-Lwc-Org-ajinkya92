//this TestSchedularfor5min is schedular class to  update  Industry to Consulting & trigger from totalAmount trigger
//and ''(new TestSchedular(q,f,v,o),5)" is apex batch class
//




global class TestSchedularfor5min implements Schedulable {
    String q = 'SELECT Industry FROM Account LIMIT 10';
String o = 'Account';
String f = 'Industry';
String v = 'Banking';
    global  void execute(SchedulableContext ctx) {
      Database.executeBatch(new TestSchedular(q,f,v,o),5);  
       // TestSchedular schedual= new TestSchedular(q,f,v,o);
      
    }
}