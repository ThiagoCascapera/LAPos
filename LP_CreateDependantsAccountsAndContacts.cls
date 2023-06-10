global without sharing class LP_CreateDependantsAccountsAndContacts implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'createAccountsAndContacts') {             
            createAccountsAndContacts(inputMap, outMap, options);                
        }
        return true;
    }

    global static void createAccountsAndContacts(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        List<Object> censusMembersList = (List<Object>) inputMap.get('censusMembers');
        List<Map<String,Object>> censusMembers = new List<Map<String,Object>>();
        if (censusMembersList != null) {
            if (censusMembersList.size() > 0 && censusMembersList[0] != null) {
                for (Object element : censusMembersList) {
                    Map<String,Object> mapElement = (Map<String,Object>) element;
                    censusMembers.add(mapElement);
                }
            }
        }        
        createAccountsFromCensusMembers(censusMembers, outMap);
    }

    public static void createAccountsFromCensusMembers(List<Map<String,Object>> censusMembers, Map<String,Object> outMap){
        List<String> documentNumberList = new List<String>();
        for (Map<String,Object> mapVar : censusMembers) {
            documentNumberList.add(String.valueOf(mapVar.get('DocumentNumber'))); 
        }
        List<Account> existingAccounts = [SELECT Id, LP_DocumentType__c, LP_DocumentNumber__c FROM Account WHERE LP_DocumentNumber__c IN: documentNumberList];
        Id standardAccRCId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND DeveloperName = 'StandardAccount' LIMIT 1].Id;
        List<Account> accList = new List<Account>();
        for (Map<String,Object> mapVar : censusMembers) {
            if (String.valueOf(mapVar.get('RoleName')) == 'Titular') {
                outMap.put(String.valueOf(mapVar.get('DocumentNumber')),String.valueOf(mapVar.get('RoleName')));
                Account acc = new Account();
                acc.vlocity_ins__Email__c = String.valueOf(mapVar.get('Email'));
                acc.Phone = String.valueOf(mapVar.get('PhoneNumber'));
                acc.LP_FirstName__c = String.valueOf(mapVar.get('Name'));
                acc.LP_LastName__c = String.valueOf(mapVar.get('LastName'));
                acc.LP_MotherLastName__c = String.valueOf(mapVar.get('MotherLastName'));
                acc.LP_FatherLastName__c = String.valueOf(mapVar.get('FatherLastName'));
                acc.LP_Birthdate__c = Date.valueOf(String.valueOf(mapVar.get('Birthdate')));
                acc.Name = String.valueOf(mapVar.get('Name')) + ' ' + String.valueOf(mapVar.get('LastName'));
                acc.LP_DocumentType__c = String.valueOf(mapVar.get('DocumentType'));
                acc.LP_DocumentNumber__c = String.valueOf(mapVar.get('DocumentNumber'));
                acc.LP_Department__c = LP_SchemaObjectUtils.getCodeFromLabelDepartament(String.valueOf(mapVar.get('Department')));
                acc.LP_Province__c = LP_SchemaObjectUtils.getCodeFromLabelProvince(String.valueOf(mapVar.get('Province')));
                acc.LP_District__c = String.valueOf(mapVar.get('District'));
                acc.BillingStreet = String.valueOf(mapVar.get('Address'));
                acc.RecordTypeId = standardAccRCId;
                if (!existingAccounts.isEmpty()) {
                    for (Integer i = 0; i < existingAccounts.size(); i++) {
                        if (existingAccounts[i].LP_DocumentType__c == acc.LP_DocumentType__c && existingAccounts[i].LP_DocumentNumber__c == acc.LP_DocumentNumber__c) {
                            acc.Id = existingAccounts[i].Id;
                        }
                    }
                }
                accList.add(acc);
            }
        }
        upsert accList;
        createContactsFromCensusMembers(censusMembers, accList, documentNumberList);
    }

    public static void createContactsFromCensusMembers(List<Map<String,Object>> censusMembers, List<Account> accList, List<String> documentNumberList){
        List<Contact> existingContacts = [SELECT Id, LP_DocumentType__c, LP_DocumentNumber__c FROM Contact WHERE LP_DocumentNumber__c IN: documentNumberList];
        Id standardContcRCId = [SELECT Id FROM RecordType WHERE SobjectType = 'Contact' AND DeveloperName = 'Contact' LIMIT 1].Id;
        List<Contact> concList = new List<Contact>();
        for (Map<String,Object> mapVar : censusMembers) {
            Contact conc = new Contact();
            conc.FirstName = String.valueOf(mapVar.get('Name'));
            conc.LP_DocumentType__c = String.valueOf(mapVar.get('DocumentType'));
            conc.LP_DocumentNumber__c = String.valueOf(mapVar.get('DocumentNumber'));
            if (mapVar.get('FatherLastName') != null && mapVar.get('MotherLastName') != null) {
                conc.LastName = String.valueOf(mapVar.get('FatherLastName')) + ' ' + String.valueOf(mapVar.get('MotherLastName'));
            } else if (mapVar.get('FatherLastName') != null) {
                conc.LastName = String.valueOf(mapVar.get('FatherLastName'));
            } else {
                conc.LastName = String.valueOf(mapVar.get('MotherLastName'));
            }
            conc.LP_MotherLastName__c = String.valueOf(mapVar.get('MotherLastName'));
            conc.LP_FatherLastName__c = String.valueOf(mapVar.get('FatherLastName'));
            conc.Birthdate = Date.valueOf(String.valueOf(mapVar.get('Birthdate')));
            conc.Gender = String.valueOf(mapVar.get('Gender'));
            conc.Phone = String.valueOf(mapVar.get('PhoneNumber'));
            conc.Email = String.valueOf(mapVar.get('Email'));
            conc.RecordTypeId = standardContcRCId;
            for (Integer i = 0; i < accList.size(); i++) {
                if (String.valueOf(mapVar.get('RelatedDocumentNumber')) != null && String.valueOf(mapVar.get('RelatedDocumentNumber')) != '') {
                    if (String.valueOf(mapVar.get('RelatedDocumentNumber')) == accList[i].LP_DocumentNumber__c &&
                        String.valueOf(mapVar.get('RelatedDocumentType')) == accList[i].LP_DocumentType__c) {
                            conc.AccountId = accList[i].Id;
                    }
                } else {
                    if (String.valueOf(mapVar.get('DocumentNumber')) == accList[i].LP_DocumentNumber__c &&
                    String.valueOf(mapVar.get('DocumentType')) == accList[i].LP_DocumentType__c) {
                        conc.AccountId = accList[i].Id;
                    }
                }
            }
            if (!existingContacts.isEmpty()) {
                for (Integer i = 0; i < existingContacts.size(); i++) {
                    if (existingContacts[i].LP_DocumentType__c == conc.LP_DocumentType__c && existingContacts[i].LP_DocumentNumber__c == conc.LP_DocumentNumber__c) {
                        conc.Id = existingContacts[i].Id;
                    }
                }
            }
            concList.add(conc);
        }
        upsert concList;
    }
   
}