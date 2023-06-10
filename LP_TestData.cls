public class LP_TestData {

    public static Account insertAccount(){
        Account acc = new Account();
        acc.Name = 'Test';
        acc.LP_DocumentType__c = 'DNI';
        acc.LP_DocumentNumber__c = '12345678';
        insert acc;
        return acc;
    }

    public static LP_EconomicActivities__c insertEconomicActivities(){
        LP_EconomicActivities__c ea = new LP_EconomicActivities__c();
        ea.Name = 'Test';
        ea.LP_RiskLevel__c = 'II';
        ea.LP_Description__c = 'Test';
        insert ea;
        return ea;
    }

    public static Contact insertContact(Id accId){
        Contact ccc = new Contact();
        ccc.FirstName = 'Test';
        ccc.LastName = 'Test';
        ccc.AccountId = accId;
        ccc.LP_DocumentType__c = 'DNI';
        ccc.LP_DocumentNumber__c = '12345678';
        insert ccc;
        return ccc;
    }

    public static Opportunity insertOpportunity(){
        Account acc = insertAccount();
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.AccountId = acc.Id;
        opp.StageName = 'Pendiente';
        opp.CloseDate = System.today() + 15;
        insert opp;
        return opp;
    }

    public static Lead insertLead(){
        Lead ll = new Lead();
        ll.FirstName = 'Test';
        ll.LastName = 'Test';
        ll.Company = 'Test';
        ll.LP_CompanyActivity__c = 'Test'; 
        ll.Phone = '999999999';
        ll.Street = 'Av Street';
        ll.Email = 'test@gmail.com';
        ll.MobilePhone = '999999999';
        ll.NumberOfEmployees = 100;
        ll.LP_DocumentNumber__c = '99999999';
        ll.LP_DocumentType__c = 'RUC';
        ll.LP_Department__c = '01';
        ll.LP_Province__c = '01_01';
        ll.LP_District__c = 'LIMA';
        ll.LP_Range0to40__c = 1;
        ll.LP_Range41to50__c = 2;
        ll.LP_Range51to65__c = 3;
        ll.LP_Range66__c = 4;
        insert ll;
        return ll;
    }

    public static Quote insertQuote(){
        Account acc = insertAccount();
        Contact ccc = insertContact(acc.Id);
        Opportunity opp = insertOpportunity();
        vlocity_ins__GroupCensus__c gc = insertGroupCensus(acc.Id);
        Quote qq = new Quote();
        qq.Name = 'Test';
        qq.OpportunityId = opp.id;
        qq.vlocity_ins__GroupCensusId__c = gc.Id;
        qq.ContactId = ccc.Id;
        insert qq;
        return qq;
    }

    public static Product2 insertProduct(){
        Product2 pp = new Product2();
        pp.Name = 'Plan Bolsa Básico';
        pp.vlocity_ins__AttributeDefaultValues__c = 'Test';
        pp.vlocity_ins__Type__c = 'Salud';
        insert pp;
        return pp;
    }

    public static vlocity_ins__GroupCensus__c insertGroupCensus(Id accountId){
        vlocity_ins__GroupCensus__c gc = new vlocity_ins__GroupCensus__c();
        gc.Name = 'Test';
        gc.vlocity_ins__GroupId__c = accountId;
        gc.vlocity_ins__CensusStatus__c = 'Active';
        insert gc;
        insertGroupCensusMembers(gc.Id);
        return gc;
    }

    public static void insertGroupCensusMembers(Id censusId){
        vlocity_ins__GroupCensusMember__c gcm = new vlocity_ins__GroupCensusMember__c();
        gcm.LP_DocumentNumber__c = '12345678';
        gcm.LP_DocumentType__c = 'DNI';
        gcm.vlocity_ins__FirstName__c = 'Test';
        gcm.LP_MotherLastName__c = 'Test';
        gcm.LP_FatherLastName__c = 'Test';
        gcm.vlocity_ins__CensusId__c = censusId;
        gcm.LP_District__c = 'MIRAFLORES';
        gcm.LP_Address__c = 'Test';
        gcm.LP_PhoneNumber__c = '246785843';
        gcm.LP_Department__c = 'LIMA';
        gcm.LP_Province__c = 'LIMA';
        insert gcm;

        vlocity_ins__GroupCensusMember__c gcm2 = new vlocity_ins__GroupCensusMember__c();
        gcm2.LP_DocumentNumber__c = '12345688';
        gcm2.LP_DocumentType__c = 'DNI';
        gcm2.vlocity_ins__FirstName__c = 'Test';
        gcm2.LP_MotherLastName__c = 'Test';
        gcm2.LP_FatherLastName__c = 'Test';
        gcm2.vlocity_ins__RelatedCensusMemberId__c = gcm.Id;
        gcm2.vlocity_ins__CensusId__c = censusId;
        gcm2.LP_District__c = 'MIRAFLORES';
        gcm2.LP_Address__c = 'Test';
        gcm2.LP_PhoneNumber__c = '246785843';
        gcm2.LP_Department__c = 'LIMA';
        gcm2.LP_Province__c = 'LIMA';
        insert gcm2;
    }

}