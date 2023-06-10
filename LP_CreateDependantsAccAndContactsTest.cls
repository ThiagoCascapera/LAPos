@isTest 
public class LP_CreateDependantsAccAndContactsTest {
    
    @isTest
    static void createAccountsAndContactsTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        Test.startTest();
        List<Map<String,Object>> listMapTest = new List<Map<String,Object>>();
        Map<String,Object> mapTest = new Map<String,Object>();
        mapTest.put('LastName', 'Paterno Materno');
        mapTest.put('Name', 'Sin nombre');
        mapTest.put('RoleName', 'Titular');
        mapTest.put('Email', 'test@labsxd.com');
        mapTest.put('Gender', 'Femenino');
        mapTest.put('Province', 'LIMA');
        mapTest.put('PhoneNumber', '845845784');
        mapTest.put('Birthdate', Date.valueOf('1987-05-21'));
        mapTest.put('MotherLastName', 'Materno');
        mapTest.put('FatherLastName', 'Paterno');
        mapTest.put('DocumentType', 'DNI');
        mapTest.put('DocumentNumber', '18968969');
        mapTest.put('District', 'Test');
        mapTest.put('Department', 'LIMA');
        mapTest.put('Continuity', 'SI');
        mapTest.put('Address', 'Av 87');
        mapTest.put('Age', '20');
        mapTest.put('Plan', 'Plan Bolsa Basico');
        mapTest.put('PremiumPerPerson', 150);
        listMapTest.add(mapTest);
        inputMap.put('censusMembers', listMapTest);
        Boolean createAccAndContactResp = new LP_CreateDependantsAccountsAndContacts().invokeMethod('createAccountsAndContacts', inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(createAccAndContactResp, true);
    }

}