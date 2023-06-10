public class LP_CreateInsurancePoliciesBatch implements Database.Batchable < vlocity_ins__GroupCensusMember__c > , Database.AllowsCallouts, Database.Stateful {

    public Id quoteId;
    public List<Map<String,Object>> productConfigurationDetail = new List<Map<String,Object>>();
    RecordType recordTypeInfo = new RecordType();
    RecordType recordTypeInfo2 = new RecordType();
    List<vlocity_ins__GroupCensusMember__c> censusMembers = new List<vlocity_ins__GroupCensusMember__c>();
    List<Account> accountCensusMembers = new List<Account>();
    List<String> insurancePolicyIdListToUpdate = new List<String>();
    Quote quoteInfo = new Quote();

    public LP_CreateInsurancePoliciesBatch() {}

    public LP_CreateInsurancePoliciesBatch(Id quoteIdParam, List<Map<String,Object>> productConfigurationDetailParam) {
        quoteId = quoteIdParam;
        productConfigurationDetail = productConfigurationDetailParam;
    }

    public List < vlocity_ins__GroupCensusMember__c > start(Database.BatchableContext bc) {
        quoteInfo = [SELECT OpportunityId, AccountId, Account.Name, Account.LP_DocumentNumber__c, vlocity_ins__GroupCensusId__c FROM Quote WHERE Id =: quoteId ORDER BY CreatedDate DESC LIMIT 1];

        censusMembers = [SELECT Id, LP_RoleName__c, LP_Address__c, LP_Age__c, LP_Campus__c, LP_Continuity__c,
            LP_Department__c, LP_District__c, LP_DocumentNumber__c, LP_DocumentType__c,LP_FatherLastName__c, LP_JobType__c, LP_MaritalStatus__c,
            LP_MotherLastName__c,LP_PhoneNumber__c, LP_Plan__c, LP_PremmiumFinalPerPerson__c,  LP_Province__c, vlocity_ins__Birthdate__c, vlocity_ins__Email__c, 
            vlocity_ins__FirstName__c, vlocity_ins__Gender__c, vlocity_ins__LastName__c 
            FROM vlocity_ins__GroupCensusMember__c WHERE vlocity_ins__CensusId__c =: quoteInfo.vlocity_ins__GroupCensusId__c];

        List<String> documentNumbers = new List<String>();
        for (vlocity_ins__GroupCensusMember__c forVar : censusMembers) {
            documentNumbers.add(forVar.LP_DocumentNumber__c);
        }
        accountCensusMembers = [SELECT Id, LP_DocumentType__c, LP_DocumentNumber__c FROM Account WHERE LP_DocumentNumber__c IN: documentNumbers];

        recordTypeInfo = [SELECT Id FROM RecordType WHERE SobjectType = 'InsurancePolicy' AND DeveloperName = 'LP_OriginalPolicy' LIMIT 1];
        recordTypeInfo2 = [SELECT Id FROM RecordType WHERE SobjectType = 'InsurancePolicy' AND DeveloperName = 'LP_CollaboratorsPolicy' LIMIT 1];
        System.debug('size'+censusMembers.size());

        return censusMembers;
    }

    public void execute(Database.BatchableContext bc, List < vlocity_ins__GroupCensusMember__c > censusMembersRecords) {
        String procedureName = 'LP_CreateInsurancePolicies';
        Map < String, Object > ipInput = new Map < String, Object > ();
        Map < String, Object > ipOutput = new Map < String, Object > ();
        Map < String, Object > ipOptions = new Map < String, Object > ();
        ipInput.put('quoteId', quoteId);
        ipInput.put('productConfigurationDetail', productConfigurationDetail);
        ipInput.put('accountId', quoteInfo.AccountId);
        ipInput.put('accountName', quoteInfo.Account.Name);
        ipInput.put('accountDocumentNumber', quoteInfo.Account.LP_DocumentNumber__c);
        ipInput.put('recordTypeId', recordTypeInfo.Id);
        ipInput.put('today', System.today());
        ipInput.put('originalPolice', 'yes');
        ipOutput = (Map < String, Object > ) vlocity_ins.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
        System.debug('one'+JSON.serializePretty(ipOutput));
        System.debug('size'+censusMembersRecords.size());
        insurancePolicyIdListToUpdate.add(String.valueOf(ipOutput.get('originalPolicyId')));

        for (Integer i = 0; i < censusMembersRecords.size(); i++) {
            if (censusMembersRecords[i].LP_RoleName__c == 'Titular') {
                String accountId;
                for (Account forVar : accountCensusMembers) {
                    if (censusMembersRecords[i].LP_DocumentType__c == forVar.LP_DocumentType__c && censusMembersRecords[i].LP_DocumentNumber__c == forVar.LP_DocumentNumber__c) {
                        accountId = forVar.Id;
                        System.debug('accountId'+accountId);
                    }
                }
                String procedureNameTwo = 'LP_CreateInsurancePolicies';
                Map < String, Object > ipInputTwo = new Map < String, Object > ();
                Map < String, Object > ipOutputTwo = new Map < String, Object > ();
                Map < String, Object > ipOptionsTwo = new Map < String, Object > ();
                ipInputTwo.put('quoteId', quoteId);
                ipInputTwo.put('productConfigurationDetail', productConfigurationDetail);
                ipInputTwo.put('accountId', accountId);
                ipInputTwo.put('plan', censusMembersRecords[i].LP_Plan__c);
                ipInputTwo.put('name', censusMembersRecords[i].vlocity_ins__FirstName__c);
                ipInputTwo.put('lastName', censusMembersRecords[i].vlocity_ins__LastName__c);
                ipInputTwo.put('documentNumber', censusMembersRecords[i].LP_DocumentNumber__c);
                ipInputTwo.put('recordTypeId', recordTypeInfo2.Id);
                ipInputTwo.put('today', System.today());
                ipInputTwo.put('originalPolice', 'no');
                ipOutputTwo = (Map < String, Object > ) vlocity_ins.IntegrationProcedureService.runIntegrationService(procedureNameTwo, ipInputTwo, ipOptionsTwo);
                System.debug('two'+JSON.serializePretty(ipOutputTwo));
                insurancePolicyIdListToUpdate.add(String.valueOf(ipOutputTwo.get('policyId')));
            }
        }

    }

    public void finish(Database.BatchableContext BC) {
        System.debug('Ids insurancePolicies '+insurancePolicyIdListToUpdate);
        String originalPolicyId;
        List<InsurancePolicy> insurancePolicyListToUpdate = [SELECT Id, PolicyName, SourceQuoteId, SourceOpportunityId, RecordTypeId, OriginalPolicyId FROM InsurancePolicy WHERE Id IN: insurancePolicyIdListToUpdate];
        
        for (InsurancePolicy forVar : insurancePolicyListToUpdate) {
            if (forVar.RecordTypeId == recordTypeInfo.Id) { //Original Policy
                originalPolicyId = forVar.Id; // Get original policy id
            }
        }

        for (InsurancePolicy forVar : insurancePolicyListToUpdate) {
            if (forVar.RecordTypeId == recordTypeInfo.Id) { //Original Policy
                forVar.SourceOpportunityId = quoteInfo.OpportunityId;
                forVar.SourceQuoteId = quoteInfo.Id;
                forVar.PolicyName = 'Póliza matriz';
            } else { //Collaborator Policies
                forVar.SourceOpportunityId = quoteInfo.OpportunityId;
                forVar.SourceQuoteId = quoteInfo.Id;
                forVar.OriginalPolicyId = originalPolicyId;
            }
        }
        update insurancePolicyListToUpdate;
    }
    
}