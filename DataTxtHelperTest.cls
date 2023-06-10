/*---------------------------------------------------------------------------------------------------------------
--- Company: LabsXD 
--- Author: Carlos Del Toro
--- Update for: 
--- Description: Test Class for object DataTXT__c
--- CreateDate: 19/05/2022 - JIRA CA-1068
--- UpdateDate:  - JIRA
--- Version: 1.0
---------------------------------------------------------------------------------------------------------------*/

@isTest
public class DataTxtHelperTest {
    
    @isTest
    public static void insertTest(){
        DataTXT__c dtxt = new DataTXT__c();
        dtxt.Name = 'RC';
        dtxt.CurrencyIsoCode = 'ARS';
        dtxt.Value__c = 'Registro';
        dtxt.Status__c = 'Nuevo';
        dtxt.Area__c = 'Prevención'; 
        dtxt.Modulo__c = 'Formulario RGRL'; 
        dtxt.Tipo_de_envio__c = 'RC';
        dtxt.Block__c = 1;

        System.debug('DATATXT test-->'+ dtxt);
        insert dtxt;
        
        String dataTxtId = dtxt.Id;
        DataTxtHelper.sendDataTxtToAzure(dataTxtId);
    }
}