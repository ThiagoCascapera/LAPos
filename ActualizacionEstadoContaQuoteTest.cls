@isTest
public class ActualizacionEstadoContaQuoteTest {

    @TestSetup
    public static void makeData() {
        Account acc = new Account(Name = 'Siuu', Cuit__c = '12344333412');
        insert acc;

        InsurancePolicy iPolicy = new InsurancePolicy();
        iPolicy.NameInsuredId = acc.Id;
        iPolicy.Altura__c = '12';
        iPolicy.Status = 'Aceptada';
        iPolicy.Name = 'Critiano Ronaldo';
        insert iPolicy;
        System.debug('aquiii test -> ' + iPolicy.Id);
        
        Estado_Cuenta__c estadoCuenta = new Estado_Cuenta__c();
        estadoCuenta.Periodo__c = 2207;
        estadoCuenta.Saldo__c = 12;
        estadoCuenta.CuentaId__c = acc.Id;
        estadoCuenta.PolizaId__c = iPolicy.Id;
        estadoCuenta.contador__c=1;
        insert estadoCuenta;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest = new vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c();
        cuotaTest.vlocity_ins_fsc__ScheduleDate__c = Date.today();
        cuotaTest.Importe_FFEP__c = 40;
        cuotaTest.vlocity_ins_fsc__InsurancePolicyId__c = iPolicy.Id;
        cuotaTest.Capitas__c = 10;
        cuotaTest.Pagos_por_Creditos__c = 100;
        cuotaTest.Debitos_Cuota__c = 50;

        insert cuotaTest;
    }


    @isTest
    static void testInsertEstadoConta1() {

        Test.startTest();

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest1 = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, vlocity_ins_fsc__InsurancePolicyId__c,
                                                                              vlocity_ins_fsc__InsurancePolicyId__r.Status
                                                                             FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c LIMIT 1];

        cuotaTest1.Importe_FFEP__c = 10;
        update cuotaTest1;
        System.debug('aquiii test status -> ' + cuotaTest1.vlocity_ins_fsc__InsurancePolicyId__r.Status);

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, vlocity_ins_fsc__InsurancePolicyId__c, Importe_FFEP_Total__c, Saldo__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =: cuotaTest1.Id LIMIT 1];

       // Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: cuotaTest.Id];
       //Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: newCuotaTest.vlocity_ins_fsc__InsurancePolicyId__c];

        //System.assertEquals(100, newCuotaTest.Importe_FFEP_Total__c);
        //System.assertEquals(-288.00, eCuenta.Saldo__c);
        Test.stopTest();
    }

    @isTest
    static void testInsertEstadoConta2() {

        Test.startTest();



        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest2 = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, vlocity_ins_fsc__InsurancePolicyId__c
                                                                             FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c LIMIT 1];

        cuotaTest2.Importe_FFEP__c = 100;
        update cuotaTest2;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =: cuotaTest2.Id LIMIT 1];
        //Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: cuotaTest.Id];
        //Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =:cuotaTest2.vlocity_ins_fsc__InsurancePolicyId__c];

        //System.assertEquals(1000, newCuotaTest.Importe_FFEP_Total__c);
        Test.stopTest();
    }

    @isTest
    static void testInsertEstadoConta3() {

        Test.startTest();



        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest3 = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, vlocity_ins_fsc__InsurancePolicyId__c 
                                                                             FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c LIMIT 1];


        update cuotaTest3;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Importe_Total_Cuota__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =: cuotaTest3.Id LIMIT 1];
        //System.assertEquals(400, newCuotaTest.Importe_FFEP_Total__c);
        //System.assertEquals(-400, newCuotaTest.Premio_Sin_FFEP__c);
        //System.assertEquals(0.00, newCuotaTest.Importe_Total_Cuota__c);

        Test.stopTest();
    }

    @isTest
    static void testInsertEstadoConta4() {

        Test.startTest();



        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest4 = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c 
                                                                             FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c  LIMIT 1];



        update cuotaTest4;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Importe_Total_Cuota__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id=: cuotaTest4.Id LIMIT 1];


        //System.assertEquals(-400, newCuotaTest.Premio_Sin_FFEP__c);
        //System.assertEquals(0.00, newCuotaTest.Importe_Total_Cuota__c);

        Test.stopTest();
    }

    @isTest
    static void testInsertEstadoConta5() {
        Account acc = new Account(Name = 'Siuu');
        insert acc;

        InsurancePolicy iPolicy = new InsurancePolicy();
        iPolicy.NameInsuredId = acc.Id;
        iPolicy.Status = 'Aceptada';
        iPolicy.Name = 'Critiano Ronaldo';
        insert iPolicy;
        System.debug('aquiii test -> ' + iPolicy.Id);
        
        Estado_Cuenta__c estadoCuenta = new Estado_Cuenta__c();
        estadoCuenta.Periodo__c = 2207;
        estadoCuenta.Saldo__c = 12;
        estadoCuenta.contador__c=1;
        estadoCuenta.CuentaId__c = acc.Id;
        estadoCuenta.PolizaId__c = iPolicy.Id;
        insert estadoCuenta;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest5 = new vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c();
        cuotaTest5.vlocity_ins_fsc__ScheduleDate__c = Date.today();
        cuotaTest5.Importe_FFEP__c = 300;
        cuotaTest5.vlocity_ins_fsc__InsurancePolicyId__c = iPolicy.Id;
        cuotaTest5.Capitas__c = 3;
        cuotaTest5.Pagos_por_Creditos__c = 100;
        cuotaTest5.Debitos_Cuota__c = 50;
        cuotaTest5.vlocity_ins_fsc__PremiumAmount__c = 0;

        insert cuotaTest5;

        Test.startTest();
        cuotaTest5.Importe_FFEP__c = 300;
        cuotaTest5.Capitas__c = 5;

        update cuotaTest5;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Importe_Total_Cuota__c, Saldo__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =: cuotaTest5.Id LIMIT 1];


        //System.assertEquals(-60000.00, newCuotaTest.Premio_Sin_FFEP__c);
        //System.assertEquals(0.00, newCuotaTest.Importe_Total_Cuota__c);
        //System.assertEquals(-50.00, newCuotaTest.Saldo__c);

        Test.stopTest();
    }

    @isTest
    static void testInsertEstadoConta6() {
        Account acc = new Account(Name = 'Siuu');
        insert acc;

        InsurancePolicy iPolicy = new InsurancePolicy();
        iPolicy.NameInsuredId = acc.Id;
        iPolicy.Status = 'Aceptada';
        iPolicy.Name = 'Critiano Ronaldo';
        insert iPolicy;
        System.debug('aquiii test -> ' + iPolicy.Id);
        
        Estado_Cuenta__c estadoCuenta = new Estado_Cuenta__c();
        estadoCuenta.Periodo__c = 2207;
        estadoCuenta.Saldo__c = 12;
        estadoCuenta.CuentaId__c = acc.Id;
        estadoCuenta.contador__c=1;
        estadoCuenta.PolizaId__c = iPolicy.Id;
        insert estadoCuenta;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest6 = new vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c();
        cuotaTest6.vlocity_ins_fsc__ScheduleDate__c = Date.today();
        cuotaTest6.Importe_FFEP__c = 300;
        cuotaTest6.vlocity_ins_fsc__InsurancePolicyId__c = iPolicy.Id;
        cuotaTest6.Capitas__c = 5;
        cuotaTest6.Pagos_por_Creditos__c = 100;
        cuotaTest6.Debitos_Cuota__c = 50;
        cuotaTest6.vlocity_ins_fsc__PremiumAmount__c = 0;

        insert cuotaTest6;

        Test.startTest();
		cuotaTest6.vlocity_ins_fsc__PremiumAmount__c = 40;
        update cuotaTest6;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Importe_Total_Cuota__c, Saldo__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =: cuotaTest6.Id LIMIT 1];


        //System.assertEquals(-1500.00, newCuotaTest.Premio_Sin_FFEP__c);
        //System.assertEquals(0.00, newCuotaTest.Importe_Total_Cuota__c);
        //System.assertEquals(-50.00, newCuotaTest.Saldo__c);
       // Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: cuotaTest.Id LIMIT 1];
       Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: cuotaTest6.vlocity_ins_fsc__InsurancePolicyId__c LIMIT 1];
       //System.debug('eCuenta.Saldo '+ eCuenta.Saldo__c); 
       //System.assertEquals(1112.00, eCuenta.Saldo__c);//357
        Test.stopTest();
    }


    @isTest
    static void testInsertEstadoConta7() {
        Account acc = new Account(Name = 'Siuu');
        insert acc;

        InsurancePolicy iPolicy = new InsurancePolicy();
        iPolicy.NameInsuredId = acc.Id;
        iPolicy.Status = 'Aceptada';
        iPolicy.Name = 'Critiano Ronaldo';
        insert iPolicy;
        System.debug('aquiii test -> ' + iPolicy.Id);
        
        Estado_Cuenta__c estadoCuenta = new Estado_Cuenta__c();
        estadoCuenta.Periodo__c = 2207;
        estadoCuenta.Saldo__c = 12;
        estadoCuenta.CuentaId__c = acc.Id;
        estadoCuenta.contador__c=1;
        estadoCuenta.PolizaId__c = iPolicy.Id;
        insert estadoCuenta;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest7 = new vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c();
        cuotaTest7.vlocity_ins_fsc__ScheduleDate__c = Date.today();
        cuotaTest7.Importe_FFEP__c = 5;
        cuotaTest7.vlocity_ins_fsc__InsurancePolicyId__c = iPolicy.Id;
        cuotaTest7.Capitas__c = 5;
        cuotaTest7.Pagos_por_Creditos__c = 100;
        cuotaTest7.Debitos_Cuota__c = 50;

        insert cuotaTest7;

        Test.startTest();
        update cuotaTest7;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Importe_Total_Cuota__c, Saldo__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =: cuotaTest7.Id LIMIT 1];


        //System.assertEquals(-25.00, newCuotaTest.Premio_Sin_FFEP__c);
        //System.assertEquals(0.00, newCuotaTest.Importe_Total_Cuota__c);
        //System.assertEquals(-50.00, newCuotaTest.Saldo__c);
        Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: cuotaTest7.vlocity_ins_fsc__InsurancePolicyId__c LIMIT 1];
        //System.debug('eCuenta.Saldo '+ eCuenta.Saldo__c); 
        //System.assertEquals(387.00, eCuenta.Saldo__c);//357
        Test.stopTest();
    }
    @isTest
    static void testInsertEstadoConta8() {

        Test.startTest();



        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest8 = [SELECT Id, Importe_FFEP__c, Capitas__c, Premio_Sin_FFEP__c, vlocity_ins_fsc__InsurancePolicyId__c
                                                                             FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c LIMIT 1];

        cuotaTest8.Importe_FFEP__c = 10;
        update cuotaTest8;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Saldo__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =:cuotaTest8.Id LIMIT 1];

        //Estado_Cuenta__c eCuenta = [SELECT Id, Saldo__c FROM Estado_Cuenta__c WHERE PolizaId__c =: cuotaTest8.vlocity_ins_fsc__InsurancePolicyId__c];

        //System.assertEquals(100, newCuotaTest.Importe_FFEP_Total__c);
        //System.debug('eCuenta.Saldo '+ eCuenta.Saldo__c); 
        //System.assertEquals(-288.00, eCuenta.Saldo__c);//55
        Test.stopTest();
    }
    @isTest
    static void testInsertEstadoConta9() {

        Test.startTest();

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c cuotaTest8 = [SELECT Id, Importe_FFEP__c, Capitas__c, Premio_Sin_FFEP__c, vlocity_ins_fsc__InsurancePolicyId__c
                                                                             FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c LIMIT 1];

        cuotaTest8.Importe_FFEP__c = 40;
        cuotaTest8.Capitas__c = 10;
        cuotaTest8.Name = 'dddd';
        update cuotaTest8;

        vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c newCuotaTest = [SELECT Id, Importe_FFEP__c, Premio_Sin_FFEP__c, Importe_FFEP_Total__c, Saldo__c 
                     FROM vlocity_ins_fsc__InsurancePolicyPaymentScheduleEntry__c where Id =:cuotaTest8.Id LIMIT 1];

        Test.stopTest();
    }
}