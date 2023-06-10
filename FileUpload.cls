public Without sharing class FileUpload { 
   
    @AuraEnabled
    (cacheable=true)


    public static void loadData( String data) {

                 
        Id batchJobId;        
            
            //ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion 
           //                                     WHERE ContentDocumentId =:contentDocumentId ];
            Blob archivo = Blob.valueOf(data);            
            batchJobId= Database.executeBatch(new BulkBatcheableLoad(archivo),13);  
                       

    }


}