
public class LP_SendHealthDeclarationReminder implements Database.Batchable < vlocity_ins__GroupCensusMember__c > , Database.AllowsCallouts, Database.Stateful {

    List<vlocity_ins__GroupCensusMember__c> censusMembers = new List<vlocity_ins__GroupCensusMember__c>();

    public LP_SendHealthDeclarationReminder() {}

    public List < vlocity_ins__GroupCensusMember__c > start(Database.BatchableContext bc) {
        if (Test.isRunningTest()){
            censusMembers = [SELECT Id, Name, vlocity_ins__Email__c, vlocity_ins__FirstName__c, LP_DocumentType__c, LP_DocumentNumber__c, 
            LP_HealthDeclaration__c, LP_ReminderSent__c, vlocity_ins__CensusId__r.LP_Quote__r.AccountId, 
            vlocity_ins__CensusId__r.LP_Quote__r.ContactId, vlocity_ins__CensusId__r.LP_Quote__c 
            FROM vlocity_ins__GroupCensusMember__c 
                WHERE LP_HealthDeclaration__c = false 
                AND LP_ReminderSent__c = false 
                AND CreatedDate < LAST_N_DAYS:3 
                AND CreatedDate > LAST_MONTH 
                ORDER BY CreatedDate DESC LIMIT 10];        
        } else {
            censusMembers = [SELECT Id, Name, vlocity_ins__Email__c, vlocity_ins__FirstName__c, LP_DocumentType__c, LP_DocumentNumber__c, 
            LP_HealthDeclaration__c, LP_ReminderSent__c, vlocity_ins__CensusId__r.LP_Quote__r.AccountId, 
            vlocity_ins__CensusId__r.LP_Quote__r.ContactId, vlocity_ins__CensusId__r.LP_Quote__c 
            FROM vlocity_ins__GroupCensusMember__c 
                WHERE LP_HealthDeclaration__c = false 
                AND LP_ReminderSent__c = false
                AND CreatedDate < LAST_N_DAYS:3 
                AND CreatedDate > LAST_MONTH 
                ORDER BY CreatedDate DESC];
        }
        return censusMembers;
    }

    public void execute(Database.BatchableContext bc, List < vlocity_ins__GroupCensusMember__c > censusMembersRecords) {
        List <vlocity_ins__GroupCensusMember__c> membersToUpdate = new List<vlocity_ins__GroupCensusMember__c>();
        for (Integer i = 0; i < censusMembersRecords.size(); i++) {
            String procedureName = 'LP_IPSendHealthDeclarationReminder';
            Map < String, Object > ipInput = new Map < String, Object > ();
            Map < String, Object > ipOutput = new Map < String, Object > ();
            Map < String, Object > ipOptions = new Map < String, Object > ();
            ipInput.put('Name', censusMembersRecords[i].Name);
            ipInput.put('FirstName', censusMembersRecords[i].vlocity_ins__FirstName__c);
            ipInput.put('Email', censusMembersRecords[i].vlocity_ins__Email__c);
            ipInput.put('DocumentType', censusMembersRecords[i].LP_DocumentType__c);
            ipInput.put('DocumentNumber', censusMembersRecords[i].LP_DocumentNumber__c);
            ipInput.put('accountId', censusMembersRecords[i].vlocity_ins__CensusId__r.LP_Quote__r.AccountId);
            ipInput.put('contactId', censusMembersRecords[i].vlocity_ins__CensusId__r.LP_Quote__r.ContactId);
            ipInput.put('quoteId', censusMembersRecords[i].vlocity_ins__CensusId__r.LP_Quote__c);
            ipInput.put('Id', censusMembersRecords[i].Id);
            System.debug('ipInput: '+JSON.serializePretty(ipInput));
            ipOutput = (Map < String, Object > ) vlocity_ins.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
            if (!ipOutput.isEmpty()) {
                if (ipOutput.containsKey('message')) {
                    if (String.valueOf(ipOutput.get('message')).contains('recibida correctamente')) {
                        censusMembersRecords[i].LP_ReminderSent__c = true;
                        membersToUpdate.add(censusMembersRecords[i]);
                    }
                }
            }
            System.debug('ipOutput: '+JSON.serializePretty(ipOutput));
        }
        if (membersToUpdate.size() > 0) {
            update membersToUpdate;
        }
    }

    public void finish(Database.BatchableContext BC) {
        
    }
    
}