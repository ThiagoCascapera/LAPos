@isTest
public class EstablecimientoControllerTest {
	 @isTest
	 static void establecimientoTest(){
       
		ID idEstablecimiento = 'a8B1F0000008ePeUAI';
     
		Test.startTest();
        EstablecimientoController.getEstablecimiento(idEstablecimiento);
        Test.stopTest();
        
     
    }
}