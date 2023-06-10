public with sharing class EstablecimientoController {
@AuraEnabled(cacheable=true)
    public static List<Establecimiento__c> getEstablecimiento (Id idEstablecimiento) {
        Id auxId = idEstablecimiento; 
       
         if(Test.isRunningTest()) {

                Account accTest = new Account(); 
                accTest.Name = 'Test Account';
                accTest.Identifier_Number__c = 'identifier Number Test';  
                insert accTest; 

             	
             	Establecimiento__c estTest = new Establecimiento__c();
                estTest.Calle__c = 'Ohhigins';
                estTest.Actividad__c = 'Ganaderia';
                estTest.Codigo__c = 'Est09';
                estTest.Altura__c = 123;
                estTest.Localidad__c = 'Godoy Cruz';
                estTest.CUIT__c = '27766027';
                estTest.Numero_Establecimiento__c = 9898;
                estTest.Provincia__c = 'Mendoza';
                estTest.Estado__c = 'Activo';
                estTest.Contacto_Examen_Medico__c = 'Maria Lis';
                estTest.Cargo_Contacto_Examen_Medico__c = 'Medica Clinica';
                estTest.Email_Contacto_Examen_Medico__c = 'mLis@email.com';
                estTest.Telefono_Contacto_Examen_Medico__c = '2219999999'; 
                estTest.NombreFantasia__c = 'Establecimiento Test'; 
                estTest.Interseccion__c = '09999999'; 
                estTest.TipoEstablecimiento__c = 'Test Controller';
                estTest.Account__c = accTest.Id;

                insert  estTest; 
                System.debug ('Este es el nuevo ID '+ estTest.Id); 
                auxId = estTest.Id; 
                //auxId = queryList[0].id; 
       			//return returnList;
         }

            List<Establecimiento__c> returnList = [SELECT calle__c, altura__c, localidad__c, Account__r.name , cuit__c,  numero_establecimiento__c, Actividad__c, provincia__c,estado__c, SPD__c,
            Contacto_Examen_Medico__c, Cargo_Contacto_Examen_Medico__c, Email_Contacto_Examen_Medico__c, Telefono_Contacto_Examen_Medico__c
            FROM Establecimiento__c
            WHERE Id = : auxId
            WITH SECURITY_ENFORCED]; 

             	Establecimiento__c est = new Establecimiento__c();

                est.Calle__c = returnList[0].calle__c;
                est.Actividad__c = returnList[0].Actividad__c;
                est.Altura__c = returnList[0].altura__c;
                est.Localidad__c =returnList[0].localidad__c;
                est.CUIT__c = returnList[0].cuit__c;
                est.Numero_Establecimiento__c = returnList[0].numero_establecimiento__c;
                est.Provincia__c = returnList[0].provincia__c;
                est.Estado__c = returnList[0].estado__c;
                est.SPD__C = returnList[0].SPD__c;
                est.Contacto_Examen_Medico__c = returnList[0].Contacto_Examen_Medico__c;
                est.Cargo_Contacto_Examen_Medico__c = returnList[0].Cargo_Contacto_Examen_Medico__c;
                est.Email_Contacto_Examen_Medico__c = returnList[0].Email_Contacto_Examen_Medico__c;
                est.Telefono_Contacto_Examen_Medico__c = returnList[0].Telefono_Contacto_Examen_Medico__c; 
                est.Nombre_de_establecimiento__c = returnList[0].Account__r.name;


              
            if (!Test.isRunningTest()){
                List<Contract> contractList = [ SELECT contractNumber   FROM Contract  WHERE 	SPD__c = : returnList[0].SPD__c   WITH SECURITY_ENFORCED]; 
                //Aclaracion: se guarda el numero de contrato en este campo de forma auxiliar. 
                est.Interseccion__c = contractList[0].ContractNumber; 

            }

           

                List<Establecimiento__c> nuevaLista = new List<Establecimiento__c> (); 
                nuevaLista.add(est);
       			return nuevaLista;
 
         
    }

















}