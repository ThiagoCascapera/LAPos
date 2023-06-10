@isTest 
public class LP_LeadConversionTest {
    
    @isTest
    static void assignLeadsTest() {

        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        Test.startTest();
        Lead ll = LP_TestData.insertLead();
        LP_EconomicActivities__c ecac = LP_TestData.insertEconomicActivities();
        inputMap.put('LeadId', ll.Id);
        inputMap.put('leadId', ll.Id);
        Boolean assignLeadsResponse = new LP_LeadConversion().invokeMethod('assignLeads', inputMap, outputMap, options);
        Boolean convertLeadResponse = new LP_ManualLeadConversion().invokeMethod('convertLeadMethod', inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(assignLeadsResponse, true);
    }

    @isTest
    static void convertLeadMethodTest() {

        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        Test.startTest();
        Lead ll = LP_TestData.insertLead();
        LP_EconomicActivities__c ecac = LP_TestData.insertEconomicActivities();
        inputMap.put('leadId', ll.Id);
        Boolean convertLeadResponse = new LP_ManualLeadConversion().invokeMethod('convertLeadMethod', inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(convertLeadResponse, true);
    }

}