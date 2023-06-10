global with sharing class LP_SchemaObjectUtils implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'getLabelFromPicklistAccountDepartamentAPIName') {             
            getLabelFromPicklistAccountDepartamentAPIName(inputMap, outMap, options);                
        }
        if (methodName == 'getLabelFromPicklistAccountProvinceAPIName') {             
            getLabelFromPicklistAccountProvinceAPIName(inputMap, outMap, options);                
        }
        if (methodName == 'getCodeFromLabelDepartamentVlocity') {             
            getCodeFromLabelDepartamentVlocity(inputMap, outMap, options);                
        }
        if (methodName == 'getAllProvincesFromDepartment') {             
            getAllProvincesFromDepartment(inputMap, outMap, options);                
        }
        return true;        
    }

    global static void getLabelFromPicklistAccountDepartamentAPIName(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        String valueInput = String.valueOf(inputMap.get('valueInput'));
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Department__c.getDescribe().getPicklistValues();
        Map<String,String> apiToLabelMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            apiToLabelMap.put(sp.getValue(), sp.getLabel());
        }
        outMap.put('labelValue', apiToLabelMap.get(valueInput));
        System.debug('Label value of picklist>>'+ apiToLabelMap.get(valueInput));
    }

    global static void getLabelFromPicklistAccountProvinceAPIName(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        String valueInput = String.valueOf(inputMap.get('valueInput'));
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Province__c.getDescribe().getPicklistValues();
        Map<String,String> apiToLabelMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            apiToLabelMap.put(sp.getValue(), sp.getLabel());
        }
        outMap.put('labelValue', apiToLabelMap.get(valueInput));
        System.debug('Label value of picklist>>'+ apiToLabelMap.get(valueInput));
    }

    @AuraEnabled
    global static String getLabelFromPicklistAccountDepartamentAPINameLWC(String code){
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Department__c.getDescribe().getPicklistValues();
        Map<String,String> apiToLabelMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            apiToLabelMap.put(sp.getValue(), sp.getLabel());
        }
        return apiToLabelMap.get(code);
    }

    @AuraEnabled
    global static String getLabelFromPicklistAccountProvinceAPINameLWC(String code){
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Province__c.getDescribe().getPicklistValues();
        Map<String,String> apiToLabelMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            apiToLabelMap.put(sp.getValue(), sp.getLabel());
        }
        return apiToLabelMap.get(code);
    }

    @AuraEnabled
    public static String getCodeFromLabelDepartamentLWC(String label){
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Department__c.getDescribe().getPicklistValues();
        Map<String,String> departamentLabelToCodeMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            departamentLabelToCodeMap.put(sp.getLabel(), sp.getValue());
        }
        return departamentLabelToCodeMap.get(label);
    }

    @AuraEnabled
    public static String getCodeFromLabelProvinceLWC(String label){
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Province__c.getDescribe().getPicklistValues();
        Map<String,String> provinceLabelToCodeMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            provinceLabelToCodeMap.put(sp.getLabel(), sp.getValue());
        }
        return provinceLabelToCodeMap.get(label);
    }

    public static void getCodeFromLabelDepartamentVlocity(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        String valueInput = String.valueOf(inputMap.get('valueInput'));
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Department__c.getDescribe().getPicklistValues();
        Map<String,String> departamentLabelToCodeMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            departamentLabelToCodeMap.put(sp.getLabel(), sp.getValue());
        }
        outMap.put('codeValue', departamentLabelToCodeMap.get(valueInput));
    }

    global static void getAllProvincesFromDepartment(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        String valueInput = String.valueOf(inputMap.get('departmentCode'));
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Province__c.getDescribe().getPicklistValues();
        List<Map<String,Object>> provincesMapList = new List<Map<String,Object>>();
        for(Schema.PicklistEntry sp : values){
            String getLastTwoDigits = sp.getValue().substring(3);
            if (valueInput == getLastTwoDigits) {
                Map<String,Object> mapVar = new Map<String,Object>();
                mapVar.put('label', sp.getLabel());
                mapVar.put('value', sp.getValue());
                provincesMapList.add(mapVar);
            }
        }
        outMap.put('provincesList', provincesMapList);
    }

    public static String getCodeFromLabelDepartament(String labelName){
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Department__c.getDescribe().getPicklistValues();
        Map<String,String> departamentLabelToCodeMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            departamentLabelToCodeMap.put(sp.getLabel(), sp.getValue());
        }
        return departamentLabelToCodeMap.get(labelName);
    }

    public static String getCodeFromLabelProvince(String labelName){
        //To get picklist entries
        List<Schema.PicklistEntry> values = Account.LP_Province__c.getDescribe().getPicklistValues();
        Map<String,String> provinceLabelToCodeMap = new Map<String,String>();
        for(Schema.PicklistEntry sp : values){
            //Map to hold Picklist API as Key and Picklist Label as Value
            provinceLabelToCodeMap.put(sp.getLabel(), sp.getValue());
        }
        return provinceLabelToCodeMap.get(labelName);
    }
    
}