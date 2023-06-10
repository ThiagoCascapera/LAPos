global without sharing class LP_LeadConversion implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'assignLeads') {             
            assignLeads(inputMap, outMap, options);                
        }
        return true;        
    }
    
    global static void assignLeads(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        
        String leadId = String.valueOf(inputMap.get('LeadId'));
        
        Lead leadRecord = [SELECT Id, FirstName, LastName, IsConverted, ConvertedOpportunityId, ConvertedAccountId, ConvertedContactId FROM Lead WHERE Id =: leadId LIMIT 1];
        
        if (leadRecord.IsConverted) {
            outMap.put('opportunityId', leadRecord.ConvertedOpportunityId);
            outMap.put('contactId', leadRecord.ConvertedContactId);
            outMap.put('accountId', leadRecord.ConvertedAccountId);
        } else {
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            Database.LeadConvert LeadConvert = new Database.LeadConvert();
            LeadConvert.setLeadId(leadId);
            LeadConvert.setConvertedStatus(convertStatus.MasterLabel);
            LeadConvert.setDoNotCreateOpportunity(false);
            Database.LeadConvertResult lcr = Database.convertLead(LeadConvert);
            outMap.put('opportunityId', lcr.getOpportunityId());
            outMap.put('contactId', lcr.getContactId());
            outMap.put('accountId', lcr.getAccountId());
            Account accRecord = [SELECT Id, LP_FirstName__c, LP_LastName__c FROM Account WHERE Id =: lcr.getAccountId() LIMIT 1];
            accRecord.LP_FirstName__c = leadRecord.FirstName;
            accRecord.LP_LastName__c = leadRecord.LastName;
            update accRecord;
        }
        
    }
    
}