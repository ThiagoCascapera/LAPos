@isTest

private with sharing class BulkBatcheableLoadTest {
    //public BulkBatcheableLoadTest() {

    //}
    //@testSetup
     //static void setup() {

        
        //ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion 
          //                                      WHERE ContentDocumentId = '0691F000001bnN1QAI' ];
        //System.debug('content version: '+ contentVersionObj);
                                                        
        
   // }

   @isTest 
     static  void test() {   
              String strOriginal=
    'archivo.txt\n'+         
    'HFTRANSF-DGIA027      20220130011002                                                                                                                                                                                                                     0\n'+
    'A027014000000000015974C2022-03-232022-03-1130505370429220100007056281582920070665183007000000000000C000000000                                                                                                                                            0\n'+
    'A027COM000000000071292D2022-03-232005-10-0330505370429220200000000000000000000000000984COM000000000C000000000                                                                                                                                            0\n'+
    'A027GTO000000000095453D2022-03-232005-10-0330505370429220400000000000000000000000000GTOGTO000000000C000000000                                                                                                                                            0\n'+              
    'A027312000000000015974D2022-03-232022-03-1130505370429220100007056281582920070665183007000000000000C000000000                                                                                                                                            0\n'+
    'TFTRANSF-DGIA027      20220323015031000000007000000000000010C00000000000000000000000000000C                                                                                                                                                              0\n';


                  
           Blob  b = Blob.valueOf(strOriginal);
          //Blob  b2 = Blob.valueOf(strOriginal2);
            System.debug('Blob b: [' + b.toString() + ']');

        Test.startTest(); 
         
       
        BulkBatcheableLoad bbl = new BulkBatcheableLoad(b);   
         // BulkBatcheableLoad bbl2 = new BulkBatcheableLoad(b2);  
        
       Database.executeBatch(bbl);
         //Database.executeBatch(bbl2);

        Test.stopTest();

        // after the testing stops, assert records were updated properly
        //System.assertEquals(1, [select count() from Transferencia_Pagos__c where TargetOrganism__c='z027' ] );
    }   
}