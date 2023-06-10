@isTest 
public class LP_InvokeBatchInsurancePoliciesTest {
    
    @isTest
    static void invokeBatchMethodTest() {

        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        Quote qq = LP_TestData.insertQuote();
        Test.startTest();
        inputMap.put('quoteId', qq.Id);
        inputMap.put('productConfigurationDetail', JSON.deserializeUntyped('[{"test":1234},{"test":1234}]'));
        Boolean invokeBatchMethodTest = new LP_InvokeBatchInsurancePolicies().invokeMethod('invokeBatchMethod', inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(invokeBatchMethodTest, true);
    }

}