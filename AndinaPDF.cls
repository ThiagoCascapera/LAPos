public without sharing class AndinaPDF {
    public FromJsonAndina cabecera_json {get;set;}
    public FromJsonAndina  cumplimientos_json {get;set;}
    public FromJsonAndina Responsable_json {get;set;}
    public FromJsonAndina Sustancias_json {get;set;}
    public FromJsonAndina Gremios_json {get;set;}
    public FromJsonAndina Contratista_json{get;set;}
    public List<Formulario__c> resultado {get;set;}
    public List<Formulario__c> Dato {get;set;}
    public List<Contract> Dato2 {get;set;}
    public List<DateTime> dates {get;set;}
    public Boolean listSustancia {get;set;}
    public Boolean listGremio {get;set;}
    public List<Object> ResponsableForm {get;set;}
    public List<Object> Tel {get;set;}
    
    
    public List<cls_AndinaDataJson> dataGremios {get;set;}
    public List<cls_AndinaDataJson> dataContratistas {get;set;}
    public List<cls_AndinaDataJson> dataResponsables {get;set;}
    
    public AndinaPDF(Apexpages.StandardController Controller) {
        
       Id formularioId = (Id)ApexPages.currentPage().getParameters().get('Id');
        List<Formulario__c> listform = new List<Formulario__c>();
        if(Schema.sObjectType.Formulario__c.fields.EstablecimientoId__c.isAccessible()){
             listform = [SELECT EstablecimientoId__r.SPD__c FROM Formulario__c WHERE Id=:formularioId];
        }
       
        Id spdId = null;
        for(Formulario__c l : listform){
            spdId = l.EstablecimientoId__r.SPD__c; 
        }
        GetData(formularioId,spdId);
        
        Formulario__c resultado;
        if(Schema.sObjectType.Formulario__c.fields.RespuestaId__c.isAccessible()){
           resultado=[SELECT RespuestaId__r.Cumplimientos__c,
               RespuestaId__r.Responsables__c,RespuestaId__r.Sustancias__c, 
               RespuestaId__r.Gremio__c,
               RespuestaId__r.ContratistasCUIT__c FROM Formulario__c WHERE Id=:formularioId]; 
        }
       
        Map<String,Object> m = (Map<String, Object>) JSON.deserializeUntyped(resultado.RespuestaId__r.Cumplimientos__c);
        List<Object> s = (List<Object>)JSON.deserializeUntyped(resultado.RespuestaId__r.Sustancias__c);
        Map<String,Object> g = new Map<String,Object>();
        List<Object> objGremios = new List<Object>();
        List<Object> objContratistas = new List<Object>();
        List<Object> objResponsables = new List<Object>();

        if (resultado.RespuestaId__r.Gremio__c != null) {
           String firstCharacter = resultado.RespuestaId__r.Gremio__c.substring(0,1);
            
            if(firstCharacter == '{'){
                g = (Map<String,Object>)JSON.deserializeUntyped(resultado.RespuestaId__r.Gremio__c);
                objGremios.add(g);
            }else {
                 objGremios = (List<Object>) JSON.deserializeUntyped(resultado.RespuestaId__r.Gremio__c);
            }
        }else { 
            g = (Map<String,Object>)JSON.deserializeUntyped('{"NombreEntidad-Block":{"Id":"","EntityName":"","Legajo":"","Concatenado":"","ActividadGremio":"","EstadoGremio":"","Grado":"","Telefono":"","Province":"","NombreEntidad":""},"Telephone":[""],"Province":[""],"Degree":[""],"Estatus":[""],"Activities":[""],"Legajo":"","GetName":[""]}');
       		objGremios.add(g);
        }
        
        Map<String,Object> r = new Map<String,Object>();
         if (resultado.RespuestaId__r.Responsables__c != null) {
           String firstCharacter = resultado.RespuestaId__r.Responsables__c.substring(0,1);
            
            if(firstCharacter == '{'){
                r = (Map<String,Object>)JSON.deserializeUntyped(resultado.RespuestaId__r.Responsables__c);
                objResponsables.add(r);
            }else {
                 objResponsables = (List<Object>) JSON.deserializeUntyped(resultado.RespuestaId__r.Responsables__c);
            }
        }else {
            r = (Map<String,Object>)JSON.deserializeUntyped('{"Representacion":"","CuitNumber":"","LastName":"","NameResponsable":"","Cargo":"","validaMH":"","validaR":"","Entity":"","MatriculaNumber":"","TittleHabilitante":"","Type":"","View":""}');
       		objResponsables.add(r);
        }
        
        Map<String,Object> c = new Map<String,Object>();
        if (resultado.RespuestaId__r.ContratistasCUIT__c != null) {
            String firstCharacter = resultado.RespuestaId__r.ContratistasCUIT__c.substring(0,1);
            
            if(firstCharacter == '{'){
               c = (Map<String,Object>)JSON.deserializeUntyped(resultado.RespuestaId__r.ContratistasCUIT__c); 
               objContratistas.add(c);
            }else{
               objContratistas = (List<Object>) JSON.deserializeUntyped(resultado.RespuestaId__r.ContratistasCUIT__c); 
            }         
        }else { 
            c = (Map<String,Object>)JSON.deserializeUntyped('{"CUITcontratista":"","concatCuit":""}');
            objContratistas.add(c);
        }
        
        Tel = new List<Object>();
        String TelAlt = '00000-00000';
        TelAlt = TelAlt.replace('0', ' ');
        Tel.add(TelAlt);

        /* Cabecera*/
        Map<String,Object> A = (Map<String,Object>)m.get('cabecera');

        List<Map<String,Object>> Intento = new List<Map<String,Object>>();

        Intento.add(A);
        Map<String,Object> Intento2 = new Map<String,Object>();
        Intento2.put('cabecera', Intento);
        cabecera_json = (FromJsonAndina)System.JSON.deserialize(JSON.serialize(Intento2), FromJsonAndina.class);        
        
        /* Cumplimientos */
        
        List<Object> B = (List<Object>)m.get('cumplimentos');     
        Map<String,Object> D= new Map<String,Object>(); 
        D.put('cumplimentos', B);
        cumplimientos_json = (FromJsonAndina)System.JSON.deserialize(JSON.serialize(D), FromJsonAndina.class); 

        /**Responsables **/  
        
         List<cls_AndinaDataJson> myList = new List<cls_AndinaDataJson>();
		 for (Object obj2: objResponsables ){
             Map <String, Object> objMap2 = (Map<String, Object>)obj2;
               
             cls_AndinaDataJson cls2 = new cls_AndinaDataJson();
             cls2.View = String.valueOf(objMap2.get('View'));
             cls2.Cargo = String.valueOf(objMap2.get('Cargo'));   
             cls2.CuitNumber = String.valueOf(objMap2.get('CuitNumber'));   
             cls2.Representacion = String.valueOf(objMap2.get('Representacion'));   
             cls2.Type = String.valueOf(objMap2.get('Type'));   
             cls2.TittleHabilitante = String.valueOf(objMap2.get('TittleHabilitante')); 
             cls2.MatriculaNumber = String.valueOf(objMap2.get('MatriculaNumber'));
             cls2.Entity = String.valueOf(objMap2.get('Entity'));
             
             cls2.Cargo = String.valueOf(objMap2.get('Cargo'));
             cls2.NameResponsable = String.valueOf(objMap2.get('NameResponsable'));
             cls2.LastName = String.valueOf(objMap2.get('LastName'));
             myList.add(cls2);
		}
        dataResponsables = myList;

        /*Sustancias*/
        
        Map<String,Object> z = new Map<String,Object>();
        z.put('susTancia', s);
                     
        Sustancias_json = (FromJsonAndina) System.JSON.deserialize(JSON.serialize(z), FromJsonAndina.class);
        
        if(Sustancias_json!=null){
            listSustancia = true;
        }else{
        	listSustancia = false; 
        }
           
        /**GREMIOOO**/
        
         List<cls_AndinaDataJson> respuestaJson = new List<cls_AndinaDataJson>();
		 for (Object obj: objGremios ){
             Map <String, Object> objMap = (Map<String, Object>)obj;
             Map <String, Object> nombreentitadblock = (Map <String, Object>)objMap.get('NombreEntidad-Block');
               
             cls_AndinaDataJson cls = new cls_AndinaDataJson();
             cls.EntityName = String.valueOf(nombreentitadblock.get('EntityName'));
             cls.Legajo = String.valueOf(nombreentitadblock.get('Legajo'));                    
             respuestaJson.add(cls);
		}
        dataGremios = respuestaJson;
        

        /** CONTRATISTAS***/
        
         List<cls_AndinaDataJson> respuestaJson2 = new List<cls_AndinaDataJson>();
		 for (Object obj2: objContratistas ){
             Map <String, Object> objMap2 = (Map<String, Object>)obj2;
               
             cls_AndinaDataJson cls2 = new cls_AndinaDataJson();
             cls2.concatCuit = String.valueOf(objMap2.get('concatCuit'));                   
             respuestaJson2.add(cls2);
		}
        dataContratistas = respuestaJson2;        
    }

    private void GetData(Id forId, Id spdId){
        if(Schema.sObjectType.Formulario__c.fields.EstablecimientoId__c.isAccessible()){
             Dato=[SELECT EstablecimientoId__r.Calle__c,EstablecimientoId__r.CUIT__c, 
                EstablecimientoId__r.Email__c,Id,
                EstablecimientoId__r.NombreFantasia__c,
                EstablecimientoId__r.Numero_Establecimiento__c, EstablecimientoId__r.Altura__c,
                EstablecimientoId__r.Piso__c,EstablecimientoId__r.CPA__c,
                EstablecimientoId__r.Localidad__c,EstablecimientoId__r.Provincia__c,
                EstablecimientoId__r.Telefono__c,EstablecimientoId__r.Superficie_en_metros_cuadrados__c,
                EstablecimientoId__r.Cantidad_trabajadores__c,EstablecimientoId__r.Actividad__c,
                EstablecimientoId__r.CUIT_dueno_establecimiento__c,
                EstablecimientoId__r.Codigo_establecimiento__c,
                EstablecimientoId__r.CP__c,DatePresentation__c,
                EstablecimientoId__r.SPD__r.Name,
                EstablecimientoId__r.Account__r.Name,
                EstablecimientoId__r.SPD__r.contractSPD__r.ContractNumber,
                CreatedBy.Name,
                LastModifiedDate FROM Formulario__c WHERE Id=:forId];
        }
       
        
        DateTime dateModified = Dato[0].LastModifiedDate.addHours(-3);
        dates = new List <DateTime> ();
        dates.add(dateModified);
        
        if(Schema.sObjectType.Contract.fields.ContractNumber.isAccessible()){
            Dato2=[SELECT ContractNumber FROM Contract WHERE SPD__c =:spdId ORDER BY CreatedDate DESC limit 1];
        }
    } 
    
}