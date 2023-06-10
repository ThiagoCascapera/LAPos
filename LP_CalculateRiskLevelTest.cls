@IsTest
public with sharing class LP_CalculateRiskLevelTest {

    @isTest
    static void calculateRiskLevelTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        inputMap.put('formulaIMC','OBESIDAD');
        inputMap.put('OncBlock',JSON.deserializeUntyped('[ { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Problemas de las válvulas", "SpecificSurgeryDiag": "ENFERMEDAD DE LAS VÁLVULAS", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmHUAQ", "riskLevel": "R2" } } }, { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Hernia de la ingle", "SpecificSurgeryDiag": "HERNIA INGUINAL", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmMUAQ", "riskLevel": "R1" } } } ]'));
        inputMap.put('SurgeryBlock',JSON.deserializeUntyped('[ { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Problemas de las válvulas", "SpecificSurgeryDiag": "ENFERMEDAD DE LAS VÁLVULAS", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmHUAQ", "riskLevel": "R2" } } }, { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Hernia de la ingle", "SpecificSurgeryDiag": "HERNIA INGUINAL", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmMUAQ", "riskLevel": "R1" } } } ]'));
        inputMap.put('ChronicBlock',JSON.deserializeUntyped('[ { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Problemas de las válvulas", "SpecificSurgeryDiag": "ENFERMEDAD DE LAS VÁLVULAS", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmHUAQ", "riskLevel": "R2" } } }, { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Hernia de la ingle", "SpecificSurgeryDiag": "HERNIA INGUINAL", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmMUAQ", "riskLevel": "R1" } } } ]'));
        inputMap.put('AccidentBlock',JSON.deserializeUntyped('[ { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Problemas de las válvulas", "SpecificSurgeryDiag": "ENFERMEDAD DE LAS VÁLVULAS", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmHUAQ", "riskLevel": "R2" } } }, { "SurgeryRecordTypeName": "Procedimientos Quirúrgicos", "SurgeryDiag": "Hernia de la ingle", "SpecificSurgeryDiag": "HERNIA INGUINAL", "SurgeryYearsDiagnosed": "2", "IPResponse": { "error": "OK", "errorCode": "INVOKE-200", "result": { "diagnosticoId": "a0B8F000003ekmMUAQ", "riskLevel": "R1" } } } ]'));
        Test.startTest();
            Boolean result = new LP_CalculateRiskLevel().invokeMethod('calculateRiskLevel', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

}