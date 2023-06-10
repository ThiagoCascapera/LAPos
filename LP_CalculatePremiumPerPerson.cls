global without sharing class LP_CalculatePremiumPerPerson implements vlocity_ins.VlocityOpenInterface {
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if (methodName == 'calculatePremium') {             
            calculatePremium(inputMap, outMap, options);                
        }
        return true;        
    }

    public static void calculatePremium(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options){
        List<Object> membersListObj = (List<Object>) inputMap.get('Members');
        String planBolsa = String.valueOf(inputMap.get('PlanBolsa'));
        String planBolsaComp1 = String.valueOf(inputMap.get('PlanBolsaComp1'));
        String planBolsaComp2 = String.valueOf(inputMap.get('PlanBolsaComp2'));
        List<Map<String,Object>> memberList = new List<Map<String,Object>>();
        for (Object element : membersListObj) {
            Map<String,Object> mapElement = (Map<String,Object>) element;
            memberList.add(mapElement);
        }
        Integer countBolsa = 0;
        Integer countBolsaComp1 = 0;
        Integer countBolsaComp2 = 0;
        Decimal subtotalBolsa = 0.0;
        Decimal subtotalBolsaComp1 = 0.0;
        Decimal subtotalBolsaComp2 = 0.0;
        Decimal total = 0.0;
        for (Map<String,Object> element : memberList) {
            String plan = String.valueOf(element.get('Plan'));
            if (plan == 'Plan Bolsa Básico') {
                countBolsa++;
                subtotalBolsa += Double.valueOf(element.get('PremiumPerPerson'));
            } else if (plan == 'Plan Bolsa Básico + Complementario 1') {
                countBolsaComp1++;
                subtotalBolsaComp1 += Double.valueOf(element.get('PremiumPerPerson'));
            } else {
                countBolsaComp2++;
                subtotalBolsaComp2 += Double.valueOf(element.get('PremiumPerPerson'));
            }
        }
        total = subtotalBolsa + subtotalBolsaComp1 + subtotalBolsaComp2;
        Decimal totalFormat = total.setScale(2);
        String totalFinalFormat = total.format();
        outMap.put('countBolsa', countBolsa);
        outMap.put('countBolsaComp1', countBolsaComp1);
        outMap.put('countBolsaComp2', countBolsaComp2);
        outMap.put('premiumPerPersonBolsa', String.valueOf(Decimal.valueOf(planBolsa).setScale(2)));
        outMap.put('premiumPerPersonBolsaComp1', String.valueOf(Decimal.valueOf(planBolsaComp1).setScale(2)));
        outMap.put('premiumPerPersonBolsaComp2', String.valueOf(Decimal.valueOf(planBolsaComp2).setScale(2)));
        outMap.put('subtotalBolsa', String.valueOf(subtotalBolsa.setScale(2)));
        outMap.put('subtotalBolsaComp1', String.valueOf(subtotalBolsaComp1.setScale(2)));
        outMap.put('subtotalBolsaComp2', String.valueOf(subtotalBolsaComp2.setScale(2)));
        outMap.put('total', String.valueOf(totalFinalFormat));
    }
}