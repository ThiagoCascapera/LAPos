@isTest
public with sharing class LP_UpdateObjectsFromCommunitiesTest {
    @isTest
    public static void updateAccountAddressTest(){
        Account acc = LP_TestData.insertAccount();
        Test.startTest();
        LP_UpdateObjectsFromCommunities.updateAccountAddress('Test', acc.Id);
        Test.stopTest();
        System.assertEquals([SELECT BillingStreet FROM Account WHERE Id =: acc.Id].BillingStreet, 'Test');
    }

    @isTest
    public static void updateContactFieldsTest(){
        Account acc = LP_TestData.insertAccount();
        Contact con = LP_TestData.insertContact(acc.Id);
        Map<String,String> values = new Map<String,String>();
        values.put('FirstName', 'Test');
        values.put('Phone', '98767839');
        values.put('Email', 'jvalenti@labsxd.com');
        Test.startTest();
        LP_UpdateObjectsFromCommunities.updateContactFields(con.Id, values);
        Test.stopTest();
        System.assertEquals([SELECT FirstName FROM Contact WHERE Id =: con.Id].FirstName, 'Test');
    }

    @isTest
    public static void getContactByAccountIdTest(){
        Account acc = LP_TestData.insertAccount();
        Contact con = LP_TestData.insertContact(acc.Id);
        Test.startTest();
        Contact contc = LP_UpdateObjectsFromCommunities.getContactByAccountId(acc.Id);
        Test.stopTest();
        System.assertEquals(contc.Id, con.Id);
    }
}