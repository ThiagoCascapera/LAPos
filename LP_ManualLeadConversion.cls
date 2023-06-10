global without sharing class LP_ManualLeadConversion implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'convertLeadMethod') {             
            convertLeadMethod(inputMap, outMap, options);                
        }
        return true;        
    }

    public static void convertLeadMethod(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options) {
        String leadId = String.valueOf(inputMap.get('leadId'));
        List<Lead> leadRecordList = [SELECT Id, Phone, Company, LP_ActivityCiiu__c, LP_MotherLastName__c, LP_FatherLastName__c, LP_CompanyActivity__c, IsConverted, Street, FirstName, LastName, ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId, Email, MobilePhone, NumberOfEmployees, LP_DocumentNumber__c, LP_DocumentType__c, Status, LP_Department__c, LP_Province__c, LP_District__c, LP_Range0to40__c, LP_Range41to50__c, LP_Range51to65__c, LP_Range66__c FROM Lead WHERE Id =: leadId];
        LP_EconomicActivities__c economicActivity = [SELECT Id, LP_RiskLevel__c FROM LP_EconomicActivities__c WHERE LP_Description__c =: leadRecordList[0].LP_CompanyActivity__c LIMIT 1];
        Id businessRecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND DeveloperName = 'IndustriesBusiness' LIMIT 1].Id;
        Id standardContactId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Contact' LIMIT 1].Id;
        if (!leadRecordList.isEmpty()) {
            if (leadRecordList[0].IsConverted) {
                outMap.put('accountId', leadRecordList[0].ConvertedAccountId);
                outMap.put('contactId', leadRecordList[0].ConvertedContactId);
                outMap.put('opportunityId', leadRecordList[0].ConvertedOpportunityId);
            } else {
                Account accRecord = new Account();
                accRecord.Name = leadRecordList[0].Company;
                accRecord.Phone = leadRecordList[0].Phone;
                accRecord.LP_DocumentType__c = 'RUC';
                accRecord.LP_DocumentNumber__c = leadRecordList[0].LP_DocumentNumber__c;
                accRecord.vlocity_ins__Email__c = leadRecordList[0].Email;
                accRecord.LP_Department__c = leadRecordList[0].LP_Department__c;
                accRecord.LP_Province__c = leadRecordList[0].LP_Province__c;
                accRecord.LP_District__c = leadRecordList[0].LP_District__c;
                accRecord.NumberOfEmployees = leadRecordList[0].NumberOfEmployees;
                accRecord.BillingStreet = leadRecordList[0].Street;
                accRecord.LP_CompanyActivity__c = leadRecordList[0].LP_CompanyActivity__c;
                accRecord.LP_ActivitiesRiskLevel__c = economicActivity.LP_RiskLevel__c;
                accRecord.LP_CIUCode__c = leadRecordList[0].LP_ActivityCiiu__c;
                accRecord.RecordTypeId = businessRecordTypeId;
                insert accRecord;
                outMap.put('accountId', accRecord.Id);

                Contact conRecord = new Contact();
                conRecord.AccountId = accRecord.Id;
                conRecord.FirstName = leadRecordList[0].FirstName;
                conRecord.LastName = leadRecordList[0].LastName;
                conRecord.LP_FatherLastName__c = leadRecordList[0].LP_FatherLastName__c;
                conRecord.LP_MotherLastName__c = leadRecordList[0].LP_MotherLastName__c;
                conRecord.Email = leadRecordList[0].Email;
                conRecord.MobilePhone = leadRecordList[0].Phone;
                //conRecord.Phone = leadRecordList[0].Phone; 
                conRecord.LP_DocumentType__c = 'RUC';
                conRecord.LP_DocumentNumber__c = leadRecordList[0].LP_DocumentNumber__c;
                conRecord.RecordTypeId = standardContactId;
                insert conRecord;
                outMap.put('contactId', conRecord.Id);

                Opportunity oppRecord = new Opportunity();
                oppRecord.AccountId = accRecord.Id;
                oppRecord.ContactId = conRecord.Id;
                oppRecord.Name = accRecord.Name;
                oppRecord.Probability = 50;
                oppRecord.StageName = 'En proceso';
                oppRecord.CloseDate = System.today()+15;
                insert oppRecord;
                outMap.put('opportunityId', oppRecord.Id);
            }
        }
    }

}