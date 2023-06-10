@isTest
public class CustomSearchControllerTest {
	    @IsTest
    public static void TestRecord(){
        String searchKey = 'Cultivo de trigo';
        String objectName = 'Actividad__c';
        
        
        Test.startTest();
            CustomSearchController.findRecords(searchKey,objectName);
        Test.stopTest();
    }
        
        
        
}