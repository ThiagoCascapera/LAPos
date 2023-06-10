@IsTest
public with sharing class LP_CalculatePremiumPerPersonTest {

    @isTest
    static void calculatePremiumTest() {
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> opstions = new Map<String, Object>();
        inputMap.put('PlanBolsa',100);
        inputMap.put('PlanBolsaComp1',150);
        inputMap.put('PlanBolsaComp2',120);
        inputMap.put('Members',JSON.deserializeUntyped('[ { "Plan": "Plan Bolsa Básico + Complementario 1", "CensusMemberId": "a448F0000000TexQAE", "PremiumPerPerson": 150 }, { "Plan": "Plan Bolsa Básico + Complementario 1", "CensusMemberId": "a448F0000000TeyQAE", "PremiumPerPerson": 150 }, { "Plan": "Plan Bolsa Básico", "CensusMemberId": "a448F0000000TewQAE", "PremiumPerPerson": 150 } ]'));
        Test.startTest();
            Boolean result = new LP_CalculatePremiumPerPerson().invokeMethod('calculatePremium', inputMap, outputMap, opstions);
        Test.stopTest();
        System.assertEquals(result, true);
    }

}