/*---------------------------------------------------------------------------------------------------------------
--- Company: LabsXD 
--- Author: Carlos Del Toro
--- Update for: 
--- Description: helper Class for object DataTxt trigger DataTxtTrigger
--- CreateDate: 19/05/2022 - JIRA CA-1068
--- UpdateDate:  - JIRA
--- Version: 1.0
---------------------------------------------------------------------------------------------------------------*/

global with sharing class DataTxtHelper{    
    
    global static void sendDataTxtToAzure(String dataTxtId){
        System.debug('----DataTxtHelper id'+ dataTxtId);
        String strId = Id.valueOf(dataTxtId);
        DataTxtInvokeIntegrationService.invokeIntegrationProcedureToAzure(strId);
      
    }
}