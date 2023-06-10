@IsTest
public with sharing class FromJsonAndinaTest {
     
     @IsTest
     static void A(){
        
        cls_AndinaDataJson[] cabecera; 
        cls_AndinaDataJson[] cumplimentos; 
        cls_AndinaDataJson[] responsable;
        cls_AndinaDataJson[] susTancia;
        cls_AndinaDataJson[] Gremio;  
        cls_AndinaDataJson[] contratista;
         
        Test.startTest();
        FromJsonAndina B = new FromJsonAndina();
         B.cabecera = cabecera;
         B.cumplimentos = cumplimentos; 
         B.responsable = responsable;
         B.susTancia = susTancia;
         B.Gremio = Gremio;  
         B.Contratista = Contratista;
        Test.stopTest();

     }
     

    
}