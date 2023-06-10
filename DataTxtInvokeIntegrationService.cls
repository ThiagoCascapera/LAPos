public with sharing class DataTxtInvokeIntegrationService   {
    
    public static void invokeIntegrationProcedureToAzure(String idDataTxt) {
        if(System.isFuture() || System.isBatch()){
            regularSyncCall(idDataTxt);
        } else {
            if(Limits.getFutureCalls() < Limits.getLimitFutureCalls()){
                doFutureCall(idDataTxt);
            } else {
                // Do some explicit notification so that you know your @future call was denied
            }
        }
    }

    @future(callout=true)
    public static void  doFutureCall(String idDataTxt){
        regularSyncCall(idDataTxt);
    }

    public static void regularSyncCall(String idDataTxt){
        String methodName = 'MA_SendTxtToAzure';
        
        Map<String, Object> inputMap = new Map<String, Object> ();
        Map<String, Object> outMap = new Map<String, Object> ();
        Map<String, Object> options = new Map<String, Object> ();
 
        try {
            System.debug('----DataTxtInvoke callout TRUE----'+ idDataTxt);
            String jsonString = '{"DataTxtId":"' + idDataTxt+ '"}';
            inputMap = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
            
            //1 invoke integration procedure create case catit
            vlocity_ins.IntegrationProcedureService integProcServ = new vlocity_ins.IntegrationProcedureService();
            integProcServ.invokeMethod(methodName, inputMap, outMap, options);
            System.debug(LoggingLevel.DEBUG, methodName + ' Result - IPMA_SendTxtToAzure: ' + outMap);
            
            // inputMap.put('DataTxtId', idDataTxt);
            // outMap = (Map<String, Object>) vlocity_ins.IntegrationProcedureService.runIntegrationService(methodName, inputMap, options);
            // System.debug('outMap2---> ' + outMap);
   
        } catch(Exception e) {
            System.debug(LoggingLevel.Info, methodName + ' Msg: ' + e.getMessage());
            System.debug(LoggingLevel.Info, methodName + ' Cause: ' + e.getCause());
            System.debug(LoggingLevel.Info, methodName + ' Stack Trace: ' + e.getStackTraceString());
            
            outmap.put('message',e.getMessage());
            //return outMap;
        }
    }

}
