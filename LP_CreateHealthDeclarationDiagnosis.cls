global without sharing class LP_CreateHealthDeclarationDiagnosis implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'saveDiagnosis') {             
            saveDiagnosis(inputMap, outMap, options);                
        }
        return true;        
    }

    public static void saveDiagnosis(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        try {
            String blockName = String.valueOf(inputMap.get('BlockName'));
            Map<String, Object> ipInput = new Map<String, Object> ();

            switch on blockName {
                when 'Onc' {
                    List<Object> blockList = (List<Object>) inputMap.get('Block');
                    List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                    for (Object element : blockList) {
                        Map<String,Object> mapElement = (Map<String,Object>) element;
                        mapList.add(mapElement);
                    }
                    Integer listSize = mapList.size()-1;
                    ipInput.put('dxEnfOncologicas', String.valueOf(mapList[listSize].get('OncDiagnosis')));
                    ipInput.put('diagnostcoEspecifico', String.valueOf(mapList[listSize].get('OncSpecificDiag')));
                    ipInput.put('aniosDelDiagnostico', String.valueOf(mapList[listSize].get('OncYearsDiagnosed')));
                    ipInput.put('RecordTypeName', String.valueOf(inputMap.get('OncRecordTypeName')));
                    ipInput.put('genero', String.valueOf(inputMap.get('genero')));
                    ipInput.put('declaracionJuradaID', String.valueOf(inputMap.get('declaracionJuradaID')));
                    ipInput.put('diagnosticoOncologicoEspecifico', String.valueOf(mapList[listSize].get('OncSpecificDiag')));
                    ipInput.put('tipo', String.valueOf(inputMap.get('tipoEnfermedad')));
                    invokeIPCreateDeclarationDX(ipInput, outMap);
                }
                when 'Surgery' {
                    List<Object> blockList = (List<Object>) inputMap.get('Block');
                    List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                    for (Object element : blockList) {
                        Map<String,Object> mapElement = (Map<String,Object>) element;
                        mapList.add(mapElement);
                    }
                    Integer listSize = mapList.size()-1;
                    ipInput.put('dxProcedimientoQuirurgico', String.valueOf(mapList[listSize].get('SurgeryDiag')));
                    ipInput.put('aniosDelDiagnostico', String.valueOf(mapList[listSize].get('SurgeryYearsDiagnosed')));
                    ipInput.put('diagnostcoEspecifico', String.valueOf(mapList[listSize].get('SpecificSurgeryDiag')));
                    ipInput.put('diagProcedimientoQuirurgicos', String.valueOf(mapList[listSize].get('SpecificSurgeryDiag')));
                    ipInput.put('RecordTypeName', String.valueOf(mapList[listSize].get('SurgeryRecordTypeName')));
                    ipInput.put('declaracionJuradaID', String.valueOf(inputMap.get('declaracionJuradaID')));
                    ipInput.put('tipo', String.valueOf(inputMap.get('tipoEnfermedad')));
                    invokeIPCreateDeclarationDX(ipInput, outMap);
                }
                when 'Chronic' {
                    List<Object> blockList = (List<Object>) inputMap.get('Block');
                    List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                    for (Object element : blockList) {
                        Map<String,Object> mapElement = (Map<String,Object>) element;
                        mapList.add(mapElement);
                    }
                    Integer listSize = mapList.size()-1;
                    ipInput.put('aparatoOSistema', String.valueOf(mapList[listSize].get('ChronicSystem')));
                    ipInput.put('dxEnfCronicas', String.valueOf(mapList[listSize].get('ChronicDiag')));
                    ipInput.put('diagnosticoEnfCronicas', String.valueOf(mapList[listSize].get('ChronicSpecifDiag')));
                    ipInput.put('aniosDelDiagnostico', String.valueOf(mapList[listSize].get('ChronicYearsDiagnosed')));
                    ipInput.put('diagnostcoEspecifico', String.valueOf(mapList[listSize].get('ChronicSpecifDiag')));
                    ipInput.put('RecordTypeName', String.valueOf(mapList[listSize].get('CronicRecordType')));
                    ipInput.put('declaracionJuradaID', String.valueOf(inputMap.get('declaracionJuradaID')));
                    ipInput.put('tipo', String.valueOf(inputMap.get('tipoEnfermedad')));
                    invokeIPCreateDeclarationDX(ipInput, outMap);
                }
                when 'Accident' {
                    List<Object> blockList = (List<Object>) inputMap.get('Block');
                    List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                    for (Object element : blockList) {
                        Map<String,Object> mapElement = (Map<String,Object>) element;
                        mapList.add(mapElement);
                    }
                    Integer listSize = mapList.size()-1;
                    ipInput.put('diagnostcoEspecifico', String.valueOf(mapList[listSize].get('AccidentSpecificDiag')));
                    ipInput.put('causaAccidente', String.valueOf(mapList[listSize].get('AccidentCause')));
                    ipInput.put('zonaAnatomica', String.valueOf(mapList[listSize].get('AccidentAnatomicZone')));
                    ipInput.put('dxAccidente', String.valueOf(mapList[listSize].get('AccidentDiag')));
                    ipInput.put('diagnosticoAccidente', String.valueOf(mapList[listSize].get('AccidentSpecificDiag')));
                    ipInput.put('AccidentSpecificDiag', String.valueOf(mapList[listSize].get('AccidentAnatomicZone')));
                    ipInput.put('RecordTypeName', String.valueOf(mapList[listSize].get('AccidentRecordType')));
                    ipInput.put('declaracionJuradaID', String.valueOf(inputMap.get('declaracionJuradaID')));
                    ipInput.put('tipo', String.valueOf(inputMap.get('tipoEnfermedad')));
                    invokeIPCreateDeclarationDX(ipInput, outMap);
                }
                when 'Obesity' {
                    ipInput.put('dxEnfCronicas', String.valueOf(inputMap.get('dxEnfCronicas')));
                    ipInput.put('diagnosticoEnfCronicas', String.valueOf(inputMap.get('diagnosticoEnfCronicas')));
                    ipInput.put('diagnostcoEspecifico', String.valueOf(inputMap.get('diagnostcoEspecifico')));
                    ipInput.put('aparatoOSistema', String.valueOf(inputMap.get('aparatoOSistema')));
                    ipInput.put('RecordTypeName', String.valueOf(inputMap.get('RecordTypeName')));
                    ipInput.put('declaracionJuradaID', String.valueOf(inputMap.get('declaracionJuradaID')));
                    invokeIPCreateDeclarationDX(ipInput, outMap);
                }
                when else {

                }
            }
        } catch (Exception e) {
            System.debug('Error: '+e.getStackTraceString() + ' ' + e.getLineNumber());
        }
    }

    public static void invokeIPCreateDeclarationDX(Map<String, Object> ipInput, Map<String, Object> outMap){
        /* Initialize variables */
        String procedureName = 'wrapper_invokeVip';
        Map<String, Object> ipOutput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        /* Populating input map for an Integration Procedure. 
        Follow whatever structure your VIP expects */
        ipInput.put('vipName', 'LP_CreateDeclarationDX');
        /* Call the IP via runIntegrationService,
        and save the output to ipOutput */
        ipOutput = (Map<String, Object>) vlocity_ins.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
        outMap.put('result', ipOutput);
    }

}