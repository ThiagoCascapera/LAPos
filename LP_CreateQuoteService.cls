global without sharing class LP_CreateQuoteService implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'createQuoteMethod') {             
            createQuoteMethod(inputMap, outMap, options);                
        }
        return true;        
    }

    public static void createQuoteMethod(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options) {
        String leadId = String.valueOf(inputMap.get('leadId'));
        String accountId = String.valueOf(inputMap.get('accountId'));
        String contactId = String.valueOf(inputMap.get('contactId'));
        String opportunityId = String.valueOf(inputMap.get('opportunityId'));
        String recordTypeName = String.valueOf(inputMap.get('recordType'));
        String quoteId = String.valueOf(inputMap.get('quoteId'));
        List<String> leadIds = new List<String>{leadId};
        List<String> accountIds = new List<String>{accountId};
        List<String> contactIds = new List<String>{contactId};
        List<String> opportunityIds = new List<String>{opportunityId};

        //List<Lead> leadList = [SELECT Id, Email, Phone, NumberOfEmployees, Company, LP_OncologyCases__c, LP_MaternityCases__c, LP_CurrentInsurance__c, MobilePhone, LP_Range0to40__c, LP_Range41to50__c, LP_Range51to65__c, LP_Range66__c, LP_PercentageOfPaymentAssumedByCompany__c, LP_Department__c, LP_Province__c, LP_District__c  FROM Lead WHERE Id IN :leadIds];
        List<Lead> leadList = [SELECT Id, Email, Phone, NumberOfEmployees, Company, LP_OncologyCases__c, LP_MaternityCases__c, LP_CurrentInsurance__c, MobilePhone, LP_Range0to40__c, LP_Range41to50__c, LP_Range51to65__c, LP_Range66__c, LP_PercentageOfPaymentAssumedByCompany__c, LP_Department__c, LP_Province__c, LP_District__c,LP_Broker__c  FROM Lead WHERE Id IN :leadIds];
        List<Account> accList = [SELECT Id FROM Account WHERE Id IN :accountIds];
        List<Contact> ccList = [SELECT Id FROM Contact WHERE Id IN :contactIds];
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE Id IN :opportunityIds];
        Id recordTypeId; 
        if (recordTypeName == 'regular' || recordTypeName == null) {
            recordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Quote' LIMIT 1].Id;
        } else {
            recordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'LP_SCTRQuote' LIMIT 1].Id;
        }

        Product2 prodRecord = [SELECT Id, Name, vlocity_ins__Type__c, vlocity_ins__AttributeDefaultValues__c FROM Product2 WHERE Name = 'Plan Bolsa Básico' LIMIT 1];
        Id standardPricebookId = Test.isRunningTest() ? Test.getStandardPricebookId() : [SELECT Id, Name FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id;
        Id pricebookEntryId = [SELECT Id FROM PricebookEntry WHERE Product2Id =:prodRecord.Id LIMIT 1].Id;
        List<Quote> quoteList = new List<Quote>();
        List<QuoteLineItem> quoteLineItemList = new List<QuoteLineItem>();

        for (Integer i = 0; i < leadList.size(); i++) {
            Quote quoteRecord = new Quote();
            if (quoteId != null && quoteId != '') {
                quoteRecord.Id = quoteId;
            }
            quoteRecord.Email = leadList[i].Email;
            quoteRecord.Phone = leadList[i].Phone;
            quoteRecord.LP_NumberOfEmployees__c = leadList[i].NumberOfEmployees;
            quoteRecord.LP_PercentageOfPaymentAssumedByCompany__c = leadList[i].LP_PercentageOfPaymentAssumedByCompany__c;
            quoteRecord.LP_Range0to40__c = leadList[i].LP_Range0to40__c;
            quoteRecord.LP_Range41to50__c = leadList[i].LP_Range41to50__c;
            quoteRecord.LP_Range51to65__c = leadList[i].LP_Range51to65__c;
            quoteRecord.LP_Range66__c = leadList[i].LP_Range66__c;
            quoteRecord.LP_CurrentInsurance__c = leadList[i].LP_CurrentInsurance__c;
            quoteRecord.LP_OncologyCases__c = leadList[i].LP_OncologyCases__c;
            quoteRecord.LP_MaternityCases__c = leadList[i].LP_MaternityCases__c;
            quoteRecord.Name = prodRecord.vlocity_ins__Type__c + ' - ' + leadList[i].Company;
            quoteRecord.ExpirationDate = System.today()+15;
            quoteRecord.Pricebook2Id = standardPricebookId;
            quoteRecord.Status = 'Solicitada';
            quoteRecord.vlocity_ins__EffectiveDate__c = System.today();
            quoteRecord.vlocity_ins__SourceSystem__c = 'Salesforce';
            quoteRecord.vlocity_ins__Type__c = 'New Business';
            quoteRecord.ContactId = ccList[i].Id;
            if (quoteId == null || quoteId == '') {
                quoteRecord.OpportunityId = oppList[i].Id;
            }
            quoteRecord.RecordTypeId = recordTypeId;
            quoteRecord.vlocity_ins__AgencyBrokerageId__c = leadList[i].LP_Broker__c;
            quoteList.add(quoteRecord);
        }
        upsert quoteList;

        for (Integer i = 0; i < quoteList.size(); i++) {
            QuoteLineItem qLineItem = new QuoteLineItem();
            qLineItem.Product2Id = prodRecord.Id;
            qLineItem.QuoteId = quoteList[i].Id;
            qLineItem.Quantity = 1;
            qLineItem.vlocity_ins__AttributeSelectedValues__c = prodRecord.vlocity_ins__AttributeDefaultValues__c; 
            qLineItem.vlocity_ins__ItemName__c = prodRecord.Name;
            qLineItem.vlocity_ins__RelationshipType__c = 'Child';
            qLineItem.UnitPrice = 0;
            qLineItem.PricebookEntryId = pricebookEntryId;
            quoteLineItemList.add(qLineItem);
        }
        insert quoteLineItemList;

        outMap.put('quoteId', quoteList[0].Id);
        
    }
}