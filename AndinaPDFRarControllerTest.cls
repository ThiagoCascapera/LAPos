@IsTest
public class AndinaPDFRarControllerTest {
    
    static Formulario__c Formulario;
    static Establecimiento__c Establecimiento;
    static Account Cuenta; 
    static vlocity_ins__GroupCensus__c Census;
    
    static String IdFormulario(){
        Id rtId = [SELECT Id FROM RecordType WHERE IsPersonType = FALSE AND SObjectType='Account' LIMIT 1].Id;
        Account Cuenta = new Account(RecordTypeId=rtId);
        Cuenta.Name = 'Test';
        insert Cuenta;
        
        Establecimiento = new Establecimiento__c(CUIT__c='30678138300', Account__c=Cuenta.Id,TipoEstablecimiento__c='ADMINISTRATIVO', CodigoMotivoBaja__c='2', Altura__c=1212, Calle__c='Por Aca'); 
        insert Establecimiento;
        
        Census = new vlocity_ins__GroupCensus__c(Name='RAR Census 2022-05-06 00:00:00',vlocity_ins__GroupId__c=Cuenta.Id, vlocity_ins__CensusType__c='RAR');
        insert Census;
        
        Formulario = new Formulario__c(Name='RASDIC',establecimientoCod__c=Establecimiento.Id,CensusId__c=Census.Id,EstablecimientoId__c=Establecimiento.Id ,Status__c='Presentado',TipeForm__c='RAR');
        insert Formulario;
        
        return Formulario.Id;
    }
    
    @IsTest
    static  void ConstructorTest(){
     
        Test.startTest();
        
        Formulario__c query =[SELECT Id FROM Formulario__c WHERE Id=:IdFormulario()];
        Apexpages.StandardController Form = new Apexpages.StandardController(query);

        ApexPages.currentPage().getParameters().put('Id', Form.getId());           
        AndinaPDFRarController AndinaPDFtest = new AndinaPDFRarController(Form);
        
        Test.stopTest();
    }
}