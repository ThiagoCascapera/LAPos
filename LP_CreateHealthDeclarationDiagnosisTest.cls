@isTest(SeeAllData=true)
public with sharing class LP_CreateHealthDeclarationDiagnosisTest {

    @isTest
    static void saveSurgeryDiagnosisTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        LP_HealthDeclaration__c healthDeclaration = new LP_HealthDeclaration__c();
        insert healthDeclaration;
        inputMap.put('Block',JSON.deserializeUntyped('[{ "OncRecordTypeName": "Enfermedades Oncológicas", "OncDiagnosis": "Cáncer del pulmón", "OncYearsDiagnosed": "2" }]'));
        inputMap.put('BlockName','Surgery');
        inputMap.put('declaracionJuradaID',healthDeclaration.Id);
        Test.startTest();
            Boolean result = new LP_CreateHealthDeclarationDiagnosis().invokeMethod('saveDiagnosis', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void saveOncDiagnosisTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        LP_HealthDeclaration__c healthDeclaration = new LP_HealthDeclaration__c();
        insert healthDeclaration;
        inputMap.put('Block',JSON.deserializeUntyped('[{ "OncRecordTypeName": "Enfermedades Oncológicas", "OncDiagnosis": "Cáncer del pulmón", "OncYearsDiagnosed": "2" }]'));
        inputMap.put('BlockName','Onc');
        inputMap.put('genero','Masculino');
        inputMap.put('declaracionJuradaID',healthDeclaration.Id);
        Test.startTest();
            Boolean result = new LP_CreateHealthDeclarationDiagnosis().invokeMethod('saveDiagnosis', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void saveChronicDiagnosisTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        LP_HealthDeclaration__c healthDeclaration = new LP_HealthDeclaration__c();
        insert healthDeclaration;
        inputMap.put('Block',JSON.deserializeUntyped('[{ "OncRecordTypeName": "Enfermedades Oncológicas", "OncDiagnosis": "Cáncer del pulmón", "OncYearsDiagnosed": "2" }]'));
        inputMap.put('BlockName','Chronic');
        inputMap.put('declaracionJuradaID',healthDeclaration.Id);
        Test.startTest();
            Boolean result = new LP_CreateHealthDeclarationDiagnosis().invokeMethod('saveDiagnosis', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void saveAccidentDiagnosisTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        LP_HealthDeclaration__c healthDeclaration = new LP_HealthDeclaration__c();
        insert healthDeclaration;
        inputMap.put('Block',JSON.deserializeUntyped('[{ "OncRecordTypeName": "Enfermedades Oncológicas", "OncDiagnosis": "Cáncer del pulmón", "OncYearsDiagnosed": "2" }]'));
        inputMap.put('BlockName','Accident');
        inputMap.put('declaracionJuradaID',healthDeclaration.Id);
        Test.startTest();
            Boolean result = new LP_CreateHealthDeclarationDiagnosis().invokeMethod('saveDiagnosis', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

    @isTest
    static void saveObesityDiagnosisTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        LP_HealthDeclaration__c healthDeclaration = new LP_HealthDeclaration__c();
        insert healthDeclaration;
        inputMap.put('aparatoOSistema','ENDOCRINAS Y METABOLICAS');
        inputMap.put('diagnostcoEspecifico','OBESIDAD');
        inputMap.put('diagnosticoEnfCronicas','OBESIDAD');
        inputMap.put('dxEnfCronicas','Obesidad');
        inputMap.put('RecordTypeName','Obesidad');
        inputMap.put('declaracionJuradaID', healthDeclaration.Id);
        inputMap.put('BlockName', 'Obesity');
        Test.startTest();
            Boolean result = new LP_CreateHealthDeclarationDiagnosis().invokeMethod('saveDiagnosis', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

}