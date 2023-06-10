public without sharing class LP_UpdateObjectsFromCommunities {
    @AuraEnabled
    public static void updateAccountAddress(String address, String accountId) {
        Account acc = [SELECT BillingStreet FROM Account WHERE Id =: accountId LIMIT 1];
        acc.BillingStreet = address;
        update acc;
    }

    @AuraEnabled
    public static void updateContactFields(String accountId, Map<String,String> values) {
        Contact conc = [SELECT FirstName, Account.BillingStreet, LP_FatherLastName__c, LP_MotherLastName__c, Phone, Email, Title FROM Contact WHERE AccountId =: accountId ORDER BY CreatedDate DESC LIMIT 1];
        conc.FirstName = values.get('FirstName');
        conc.LP_FatherLastName__c = values.get('LP_FatherLastName__c');
        conc.LP_MotherLastName__c = values.get('LP_MotherLastName__c');
        conc.Phone = values.get('Phone');
        conc.Email = values.get('Email');
        conc.Title = values.get('Title');
        conc.Account.BillingStreet = values.get('Address');
        update conc;
    }

    @AuraEnabled
    public static Contact getContactByAccountId(String accountId) {
        Contact conc = [SELECT Id, Title, FirstName, LP_FatherLastName__c, LP_MotherLastName__c, Account.BillingStreet, Account.Name,Account.LP_DocumentNumber__c,  Account.LP_CompanyActivity__c, Phone, Email FROM Contact WHERE AccountId =: accountId LIMIT 1];
        return conc;
    }

    @AuraEnabled
    public static Account getAccountInformation(String accountId) {
        Account acc = [SELECT Id, Name, BillingStreet, LP_Department__c, LP_MotherLastName__c, LP_FatherLastName__c, LP_DocumentType__c, LP_Birthdate__c, LP_DocumentNumber__c, Phone, vlocity_ins__Email__c, LP_District__c, LP_Province__c FROM Account WHERE Id =: accountId LIMIT 1];
        return acc;
    }

    @AuraEnabled
    public static void updateAccountFields(String accountId, Map<String,String> values) {
        Account acc = [SELECT Phone, vlocity_ins__Email__c, LP_Department__c, LP_Province__c, LP_District__c, BillingStreet FROM Account WHERE Id =: accountId LIMIT 1];
        acc.Phone = values.get('Phone');
        acc.vlocity_ins__Email__c = values.get('Email');
        acc.BillingStreet = values.get('Address');
        acc.LP_Department__c = values.get('Department');
        acc.LP_Province__c = values.get('Province');
        acc.LP_District__c = values.get('District');
        update acc;
    }
}