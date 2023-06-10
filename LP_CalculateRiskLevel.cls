global without sharing class LP_CalculateRiskLevel implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'calculateRiskLevel') {             
            calculateRiskLevel(inputMap, outMap, options);                
        }
        return true;        
    }

    global static void calculateRiskLevel(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        Integer maxRiskLevelOncBlock = 0;
        Integer maxRiskLevelSurgeryBlock = 0;
        Integer maxRiskLevelChronicBlock = 0;
        Integer maxRiskLevelAccidentBlock = 0;
        String formulaIMC = String.valueOf(inputMap.get('formulaIMC'));

        List<Object> oncList = (List<Object>) inputMap.get('OncBlock');
        if (oncList != null) {
            if (oncList.size() > 0 && oncList[0] != null) {
                List<Object> blockList = (List<Object>) inputMap.get('OncBlock');
                List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                for (Object element : blockList) {
                    Map<String,Object> mapElement = (Map<String,Object>) element;
                    mapList.add(mapElement);
                }
                maxRiskLevelOncBlock = calculateRiskLevel(mapList);
            }
        }
        outMap.put('maxRiskLevelOncBlock', maxRiskLevelOncBlock);

        List<Object> surgeryList = (List<Object>) inputMap.get('SurgeryBlock');
        if (surgeryList != null) {
            if (surgeryList.size() > 0 && surgeryList[0] != null) {
                List<Object> blockList = (List<Object>) inputMap.get('SurgeryBlock');
                List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                for (Object element : blockList) {
                    Map<String,Object> mapElement = (Map<String,Object>) element;
                    mapList.add(mapElement);
                }
                maxRiskLevelSurgeryBlock = calculateRiskLevel(mapList);
            }
        }
        outMap.put('maxRiskLevelSurgeryBlock', maxRiskLevelSurgeryBlock);

        List<Object> chronicList = (List<Object>) inputMap.get('ChronicBlock');
        if (chronicList != null) {
            if (chronicList.size() > 0 && chronicList[0] != null) {
                List<Object> blockList = (List<Object>) inputMap.get('ChronicBlock');
                List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                for (Object element : blockList) {
                    Map<String,Object> mapElement = (Map<String,Object>) element;
                    mapList.add(mapElement);
                }
                maxRiskLevelChronicBlock = calculateRiskLevel(mapList);
            }
        }
        outMap.put('maxRiskLevelChronicBlock', maxRiskLevelChronicBlock);

        List<Object> accidentList = (List<Object>) inputMap.get('AccidentBlock');
        if (accidentList != null) {
            if (accidentList.size() > 0 && accidentList[0] != null) {
                List<Object> blockList = (List<Object>) inputMap.get('AccidentBlock');
                List<Map<String,Object>> mapList = new List<Map<String,Object>>();
                for (Object element : blockList) {
                    Map<String,Object> mapElement = (Map<String,Object>) element;
                    mapList.add(mapElement);
                }
                maxRiskLevelAccidentBlock = calculateRiskLevel(mapList);
            }
        }
        outMap.put('maxRiskLevelAccidentBlock', maxRiskLevelAccidentBlock);

        Integer[] listOfRiskLevels = new List<Integer> {maxRiskLevelOncBlock, maxRiskLevelSurgeryBlock, maxRiskLevelChronicBlock, maxRiskLevelAccidentBlock};
        listOfRiskLevels.sort();
        Integer maxRiskLevelValue = listOfRiskLevels[3];
        if (maxRiskLevelValue == 0 && formulaIMC == '(OBESIDAD)') {
            maxRiskLevelValue = 1;
        }
        String maxRiskLevelValueString = 'R' + String.valueOf(maxRiskLevelValue);
        outMap.put('maxRiskLevelValue', maxRiskLevelValueString);
    }

    public static Integer calculateRiskLevel(List<Map<String,Object>> mapBlock) {
        Integer maxRiskLevel = 0;
        if (mapBlock != null) {
            if (mapBlock.size() > 0) {
                for (Map<String,Object> iterableVar : mapBlock) {
                    Map<String,Object> ipResponse = (Map<String,Object>) iterableVar.get('IPResponse');
                    Map<String,Object> ipResponseResult = (Map<String,Object>) ipResponse.get('result');
                    if (ipResponseResult.get('riskLevel') != null) {
                        Integer objRiskLevel = Integer.valueOf(String.valueOf(ipResponseResult.get('riskLevel')).removeStart('R'));
                        if (objRiskLevel > maxRiskLevel) {
                            maxRiskLevel = objRiskLevel;
                        }
                    }
                }
            } else if (mapBlock.size() == 1) {
                if (mapBlock[0].get('riskLevel') != null) {
                    maxRiskLevel = Integer.valueOf(String.valueOf(mapBlock[0].get('riskLevel')).removeStart('R'));
                }
            }
        }
        return maxRiskLevel;
    }

}