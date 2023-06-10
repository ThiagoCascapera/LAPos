@isTest(seeAllData=true)
public class LP_SendHealthDeclarationReminderTest {

    @isTest
    public static void executeBatchTest() {
        List<vlocity_ins__GroupCensusMember__c> censusMemberList = new List<vlocity_ins__GroupCensusMember__c>();
        vlocity_ins__GroupCensus__c cg = new vlocity_ins__GroupCensus__c();
        cg.Name = 'Test';
        Account acc = LP_TestData.insertAccount();
        cg.vlocity_ins__GroupId__c = acc.Id;
        cg.vlocity_ins__CensusStatus__c = 'Activa';
        insert cg;
        for (Integer i=0; i<10; i++) {
            vlocity_ins__GroupCensusMember__c cm = new vlocity_ins__GroupCensusMember__c();
            cm.vlocity_ins__FirstName__c = 'ABSYZ';
            cm.LP_MotherLastName__c = 'ABSYZ';
            cm.LP_FatherLastName__c = 'ABSYZ';
            cm.LP_DocumentNumber__c = '12345678';
            cm.LP_DocumentType__c = 'DNI';
            cm.vlocity_ins__Email__c = 'testlpreminder@yopmail.com';
            cm.vlocity_ins__CensusId__c = cg.Id;
            censusMemberList.add(cm);
        }
        insert censusMemberList;
        Test.startTest();
        Database.executeBatch(new LP_SendHealthDeclarationReminder(), 40);
        Test.stopTest();
    }

}