@isTest
public class AnimalLocatorTest {
    
@isTest static void testPostCallout() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
   String result = AnimalLocator.getAnimalNameById(1);
    // Verify that the response received contains fake values

    String expectedValue = 'ajinkya';
    System.assertEquals(result, expectedValue);

}
}