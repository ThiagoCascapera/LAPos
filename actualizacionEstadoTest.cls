@IsTest
public class actualizacionEstadoTest {

    Static Estado_Cuenta__c ec;
    
    @IsTest
    static void caseTest1(){

        ec = new  Estado_Cuenta__c (debe__c = 0, haber__c = 0, saldo__c=0) ;
        INSERT ec;
        
        
        Test.startTest();
        
        Estado_Cuenta__c testEC = [SELECT id, debe__c, haber__c, saldo__c from Estado_Cuenta__c where id =:ec.Id ];
        ec.Debe__c=100;
        UPDATE ec;
            
        Test.stopTest();
        
        Estado_Cuenta__c resultadoEC = [SELECT id, debe__c, haber__c, saldo__c from Estado_Cuenta__c where id =:ec.Id ];
        
        System.assertEquals(100, resultadoEC.Saldo__c);
    }
    
    
     @IsTest
    static void caseTest2(){

        ec = new  Estado_Cuenta__c (debe__c = 0, haber__c = 0, saldo__c=0) ;
        INSERT ec;
        
        
        Test.startTest();
        
        Estado_Cuenta__c testEC = [SELECT id, debe__c, haber__c, saldo__c from Estado_Cuenta__c where id =:ec.Id ];
        ec.Haber__c=100;
        UPDATE ec;
            
        Test.stopTest();
        
        Estado_Cuenta__c resultadoEC = [SELECT id, debe__c, haber__c, saldo__c from Estado_Cuenta__c where id =:ec.Id ];
        
        System.assertEquals(-100, resultadoEC.Saldo__c);
    }
}