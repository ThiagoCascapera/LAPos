@isTest 
public with sharing class LP_CreateQuoteServiceTest {

    @IsTest
    static void createQuoteMethodTest() {
        Quote qq = LP_TestData.insertQuote();
        Lead ll = LP_TestData.insertLead();
        Product2 pp = LP_TestData.insertProduct();
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = pp.Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        inputMap.put('leadId', ll.Id);
        inputMap.put('accountId', qq.AccountId);
        inputMap.put('contactId', qq.ContactId);
        inputMap.put('opportunityId', qq.OpportunityId);
        Test.startTest();
        Boolean invokeBatchMethodTest = new LP_CreateQuoteService().invokeMethod('createQuoteMethod', inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(invokeBatchMethodTest, true);
    }
    
}