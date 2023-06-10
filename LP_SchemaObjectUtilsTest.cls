@isTest
public with sharing class LP_SchemaObjectUtilsTest {

    @isTest
    static void getLabelFromPicklistAccountDepartamentAPINameTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        LP_HealthDeclaration__c healthDeclaration = new LP_HealthDeclaration__c();
        insert healthDeclaration;
        inputMap.put('valueInput', '01');
        Test.startTest();
            Boolean result = new LP_SchemaObjectUtils().invokeMethod('getLabelFromPicklistAccountDepartamentAPIName', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void getLabelFromPicklistAccountProvinceAPINameTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        inputMap.put('valueInput', '01_01');
        Test.startTest();
            Boolean result = new LP_SchemaObjectUtils().invokeMethod('getLabelFromPicklistAccountProvinceAPIName', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void getCodeFromLabelDepartamentTest() {
        String departmentName = 'LIMA';
        Test.startTest();
        String result = LP_SchemaObjectUtils.getCodeFromLabelDepartament(departmentName);
        Test.stopTest();
        System.assertEquals(result, '15');
    }

    @isTest
    static void getCodeFromLabelProvinceTest() {
        String provinceName = 'LIMA';
        Test.startTest();
        String result = LP_SchemaObjectUtils.getCodeFromLabelProvince(provinceName);
        Test.stopTest();
        System.assertEquals(result, '01_15');
    }

    @isTest
    static void getCodeFromLabelDepartamentVlocityTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        inputMap.put('valueInput', 'AMAZONAS');
        Test.startTest();
        Boolean result = new LP_SchemaObjectUtils().invokeMethod('getCodeFromLabelDepartamentVlocity', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void getAllProvincesFromDepartmentTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        inputMap.put('departmentCode', '01');
        Test.startTest();
        Boolean result = new LP_SchemaObjectUtils().invokeMethod('getAllProvincesFromDepartment', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }
}