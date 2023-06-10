global without sharing class LP_InvokeBatchInsurancePolicies implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'invokeBatchMethod') {             
            invokeBatchMethod(inputMap, outMap, options);                
        }
        return true;        
    }

    global static void invokeBatchMethod(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options) {
        String quoteId = String.valueOf(inputMap.get('quoteId'));
        List<Object> productConfigurationDetail = (List<Object>) inputMap.get('productConfigurationDetail');
        List<Map<String,Object>> mapList = new List<Map<String,Object>>();
        if (productConfigurationDetail != null) {
            for (Object element : productConfigurationDetail) {
                Map<String,Object> mapElement = (Map<String,Object>) element;
                mapList.add(mapElement);
            }
        }
        Database.executeBatch(new LP_CreateInsurancePoliciesBatch(quoteId, mapList), 50); 
    }

}