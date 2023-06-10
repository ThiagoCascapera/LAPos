@istest
public class ConversorDeMoneda_Test {
        
    @isTest static void testmetodo1(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_liquidado__c = 1540;
        insert prestEspecie;
    }
    @isTest static void testmetodo2(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_debitado__c = 100;
        insert prestEspecie;
    }
    @isTest static void testmetodo3(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_liquidado__c = 190.54;
        insert prestEspecie;
    }
    @isTest static void testmetodo4(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_liquidado__c = 19;
        insert prestEspecie;
    }
    @isTest static void testmetodo5(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_liquidado__c = 1932146435;
        insert prestEspecie;
    }
    @isTest static void testmetodo6(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_liquidado__c = 58.456;
        insert prestEspecie;
    }
    @isTest static void testmetodo7(){
        Prestaciones_en_especie__c prestEspecie = new Prestaciones_en_especie__c();
        prestEspecie.Monto_liquidado__c = 9999;
        insert prestEspecie;
    }
    @isTest static void testmetodo8(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_SRT_1__c = 1540;
        insert prestDineraria;
    }
    @isTest static void testmetodo9(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_SRT_1__c = 100;
        insert prestDineraria;
    }
    @isTest static void testmetodo10(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_SRT_1__c = 190.54;
        insert prestDineraria;
    }
    @isTest static void testmetodo11(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_SRT_1__c = 19;
        insert prestDineraria;
    }
    @isTest static void testmetodo12(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_SRT_1__c = 1932146435;
        insert prestDineraria;
    }
    @isTest static void testmetodo13(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_SRT_1__c = 58.456;
        insert prestDineraria;
    }
    @isTest static void testmetodo14(){
        Prestaciones_dinerarias__c prestDineraria = new Prestaciones_dinerarias__c();
        prestDineraria.Monto_liquidado__c = 9999;
        insert prestDineraria;
    }

}