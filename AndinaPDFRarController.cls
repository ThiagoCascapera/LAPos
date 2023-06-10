public without sharing class AndinaPDFRarController {
    public List<Formulario__c> Dato {get;set;}
    public List<vlocity_ins__GroupCensusMember__c> Dato2 {get;set;}
    public List<Contract> Dato3 {get;set;}
    
    public AndinaPDFRarController(Apexpages.StandardController Controller) {
        
        Id formularioId = (Id)ApexPages.currentPage().getParameters().get('Id');
        
        List<Formulario__c> form = [SELECT CensusId__c, EstablecimientoId__r.SPD__c FROM Formulario__c WHERE Id=:formularioId];
        Id censusId = null;
        Id spdId = null;
        for(Formulario__c l : form){
            censusId = l.CensusId__c;
            spdId = l.EstablecimientoId__r.SPD__c;
        }
        
        GetData(formularioId, censusId, spdId);
        
    }
    
    private void GetData(Id forId, Id censusId, Id spdId){
         Dato=[SELECT EstablecimientoId__r.Calle__c,
              EstablecimientoId__r.CUIT__c,
              EstablecimientoId__r.Account__r.Name,
              EstablecimientoId__r.Email__c,Id,
              EstablecimientoId__r.NombreFantasia__c,
              EstablecimientoId__r.Numero_Establecimiento__c,
              EstablecimientoId__r.Altura__c,
              EstablecimientoId__r.Piso__c,
              EstablecimientoId__r.CPA__c,
              EstablecimientoId__r.Localidad__c,
              EstablecimientoId__r.Provincia__c,
              EstablecimientoId__r.Telefono__c,
              EstablecimientoId__r.Superficie_en_metros_cuadrados__c,
              EstablecimientoId__r.Cantidad_trabajadores__c,
              EstablecimientoId__r.Actividad__c,
              EstablecimientoId__r.CUIT_dueno_establecimiento__c,
              EstablecimientoId__r.Codigo_establecimiento__c,
              EstablecimientoId__r.CP__c,
              DatePresentation__c,
              EstablecimientoId__r.SPD__r.Name,
              EstablecimientoId__r.SPD__r.contractSPD__r.ContractNumber,
              EstablecimientoId__r.SPD__r.UniversalPolicyNumber,
              EstablecimientoId__r.Contacto_Examen_Medico__c,
              EstablecimientoId__r.Cargo_Contacto_Examen_Medico__c,
              EstablecimientoId__r.Email_Contacto_Examen_Medico__c,
              EstablecimientoId__r.Telefono_Contacto_Examen_Medico__c,
              LastModifiedBy.Name,
              LastModifiedBy.DNI__c,
              LastModifiedBy.Profile.Name,
              LastModifiedBy.Email,
              LastModifiedBy.Account.Phone,
              EstablecimientoId__r.Name
              FROM Formulario__c WHERE Id=:forId];
        
        Dato2=[SELECT CUIL__c, Name, Sector__c, PuestoTrabajo__c, FechaIngreso__c,
               FechaInicioExposicion__c,FechaFinExposicion__c, Riesgo__c
               FROM vlocity_ins__GroupCensusMember__c WHERE vlocity_ins__CensusId__c=:censusId
               ORDER BY Name ASC];
        
        Dato3=[SELECT ContractNumber FROM Contract WHERE SPD__c =:spdId ORDER BY CreatedDate DESC limit 1];
    }
    
}