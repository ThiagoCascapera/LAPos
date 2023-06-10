public without sharing class GetSmvm {
	@AuraEnabled( cacheable=true )  
    public static List < Salario_minimo_vital_movil__mdt > fetchSmvmLabels() {
        if(Schema.sObjectType.Salario_minimo_vital_movil__mdt.fields.MasterLabel.isAccessible() &&
            Schema.sObjectType.Salario_minimo_vital_movil__mdt.fields.Salario_Minimo__c.isAccessible()){
            return [ SELECT Id, MasterLabel, Salario_Minimo__c FROM Salario_minimo_vital_movil__mdt ];
        }
        
        return null;
    }
}