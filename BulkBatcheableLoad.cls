global with sharing class BulkBatcheableLoad implements Database.batchable<String>, Database.Stateful{
   
    
         
    global final Blob dataDocuments; 
  
      
    Integer regCredCont = 0;
    Integer regDebCont = 0;
    Integer cantTotalReg = 0;
    Decimal credito=0;
    Decimal debito=0;
    Decimal totProcesado=0;
    Decimal totArchivo=0;
    Integer numero=0;
    String archivoId ='';
    String importeTotal='';
    String ArchivoNombre='';  
    Integer contador=0;
    String ErrorInvalid;
    Decimal gto =0;
    Decimal com=0;
    Decimal impTotal=0;

   
    global List<String> errores = new List<String>();
    global List<String> error_list = new List<String>();
    global List<String> exception_List = new List<String>();
    String footer = ma_queryMovCobranza.getFooter().Footer__c;

    global BulkBatcheableLoad(Blob data){ 
       this.dataDocuments= data;     
        
    }
     
        
        //Data load.
        global Iterable<String> start(Database.BatchableContext bc) {                       
          
            String nameFile = EncodingUtil.base64Decode(EncodingUtil.base64Encode(this.dataDocuments)).toString();       
           
            return new TxtIterator(nameFile, '\n');
            
        }
       
        //processing lines of received texts.
        global void execute(Database.BatchableContext bc, List<String> records){
          
          
        List <Transferencia_Pagos__c> paymentTransfer  = new List <Transferencia_Pagos__c>(); 
        
       Integer largoRecords=records.size();
       String amount=''; 
       String obligationNumber='';
       String paymentSubSequence=''; 
       String paymentSequence='';        
  
            if(contador==0){
                //System.debug('records [0]: '+ records[0]);
                //System.debug('records [1]: '+ records[1]);           
            
              ArchivoNombre=records[0];              
              archivoId=records[1].substring(22,36);
              
             // System.debug('records eliminados 1 : '+records[0]);
              //System.debug('records eliminados 2 : '+records[1]);
              records.remove(0);
              records.remove(0);
                 
            }  
                contador ++;   

             

    //Separation of the different data types of each row by means of and substring
        for (String row: records) {
                  Transferencia_Pagos__c TP = new Transferencia_Pagos__c(); 
           
            
            if(row.substring(0,16)!=footer){                           
      
                try {                    
                    TP.TargetOrganism__c= row.subString(0,4);
                    TP.TransferConcept__c=  row.subString(4,7);
                    amount= row.subString(7,22);
                    Decimal montoDecimal = Decimal.valueOf(amount);
                    montoDecimal= montoDecimal/100;
                    TP.Amount__c= montoDecimal;
                    TP.DebitCreditIndicator__c=  row.subString(22,23);
                    TP.TransferDate__c= row.subString(23,33); //envio de dinero a andina
                    TP.CollectionDate__c= row.subString(33,43); //pago cliente
                    TP.TaxpayerCuit__c= row.subString(43,54);
                    TP.Period__c= row.subString(54,58);
                    obligationNumber=row.subString(58,70);
                    TP.ObligationNumber__c= integer.valueOf(obligationNumber);
                    TP.ObligationSequence__c= row.subString(70,73);
                    TP.WorkerCuil__c= row.subString(73,84);
                    TP.Bank__c= row.subString(84,87);
                    TP.BranchCode__c= row.subString(87,90);
                    paymentSubSequence=row.subString(90,92);
                    TP.PaymentSubSequence__c= integer.valueOf(paymentSubSequence);
                    TP.FutureUseOne__c =row.subString(92,94);
                    TP.Rart__c = row.subString(94,95);
                    if(row.subString(95,98) != '   '){
                        paymentSequence=row.subString(95,98);
                        TP.PaymentSequence__c=integer.valueOf(paymentSequence);
                    }
                
                    TP.FutureUseTwo__c=row.subString(98,249);  
                    
                        
                    paymentTransfer.add(TP);
                    Date fecha = System.today();
                    Integer dayNumber = fecha.day();
                    System.debug('DAY NUMBER: '+dayNumber);
                    String day = String.valueof(dayNumber);
                    if(day.length() == 1){
                        day = '0' + day;
                    }
                    String periodo=day+'/'+row.subString(56,58)+'/20'+row.subString(54,56); 
                    System.debug('PERIODO DE HOY: '+periodo);         
                    Date polPeriod= date.parse(periodo);          
                    String payerCuit=row.subString(43,54);           
                    String payDay=row.subString(41,43)+'/'+row.subString(38,40)+'/'+row.subString(33,37);  //33,37 año---38,40 mes-----41,43 dia
                    Date paymentDay= Date.parse(payDay);
                    String conceptoTransferencia=TP.TransferConcept__c;                   
                    String tipoOperac=TP.DebitCreditIndicator__c;
                    String fechaTransf=TP.TransferDate__c;
                    Decimal numObligacion=TP.ObligationNumber__c;
                    String numSecuencia=TP.ObligationSequence__c;
                    String banco =TP.Bank__c;
                    String sucursal=TP.BranchCode__c;
                    String subSecPago=String.valueOf(TP.PaymentSubSequence__c);
                    Decimal importe=TP.Amount__c;
                   // Decimal importeDebito=0;

                    //Verificación y conteo de tipos de registros.
                    if( TP.DebitCreditIndicator__c == 'C'){
                   		regCredCont ++;
                   		credito += TP.Amount__c;
                        //importeCredito=TP.Amount__c;
                        System.debug('credito acumulador: '+credito);
                   
                	}else if(TP.DebitCreditIndicator__c == 'D' && TP.TransferConcept__c!='COM' && TP.TransferConcept__c!='GTO'){
                        regDebCont ++;
                        debito +=  TP.Amount__c;
                      //  importeDebito=TP.Amount__c;
                        System.debug('debito acumulador: '+debito);
                	} else if(TP.DebitCreditIndicator__c == 'D' && TP.TransferConcept__c=='COM' ){
                    
                        com= TP.Amount__c;
                        regDebCont ++;
                	}else if(TP.DebitCreditIndicator__c == 'D' && TP.TransferConcept__c=='GTO' ){
                        gto= TP.Amount__c;
                        regDebCont ++;
                	}
                    
                //call the method that impact the payment on policy
                   MA_GenerateInsuranceTransaction.createTransaction(payerCuit,polPeriod,paymentDay,conceptoTransferencia, importe,tipoOperac,fechaTransf,numSecuencia,banco,sucursal,numObligacion,subSecPago);
                
                } catch (Exception e) {
                    //pasamos el error a castellano
                    errores.add( e.getMessage());
                    exception_List.add(row);
                }
            }else{
                importeTotal=row.substring(50,60); 
                impTotal=Decimal.valueOf(importeTotal);
                impTotal= impTotal/100;
            }
          } 
            //System.debug('paymentTrasfer: '+paymentTransfer);
        //insert the object
        Database.SaveResult[] srList = Database.insert(paymentTransfer, false);
     
        } 
       
        global void finish(Database.BatchableContext bc){  

            List <MovCobranzasErrores__c> listaErrores  = new List <MovCobranzasErrores__c>(); 
            //Numero total de registros.
        cantTotalReg = regCredCont + regDebCont;
        System.debug(' credito: '+credito+' debito: '+debito+' gto: '+gto+' com: '+com);
               
        totProcesado= credito-debito-gto-com;
        
        movCobranzas__c cobranzas = new movCobranzas__c();  
         cobranzas.fechaMov__c=Date.today().format();
         cobranzas.cantCred__c=regCredCont;
         cobranzas.cantDeb__c=regDebCont;
         cobranzas.impCred__c=credito;
         cobranzas.impDeb__c=debito;
         cobranzas.impTotalProcesado__c=totProcesado;
         cobranzas.cantTotal__c=cantTotalReg;       
         cobranzas.idArchivo__c=archivoId;
         cobranzas.nombreArchivo__c=ArchivoNombre;         
         cobranzas.impTotalArchivo__c=impTotal;
         cobranzas.debComisiones__c=com;
         cobranzas.debGastos__c=gto;
         System.debug('error: '+exception_List);
         if(exception_List.isEmpty()){
             cobranzas.datosSinCargar__c='Correcto';
 
         }else{
             cobranzas.datosSinCargar__c='Con errores';
 
         }        
 
         insert cobranzas; 
         system.debug('largo errores : '+errores.size());
          //pasar el error a español
         Integer contadorLista=exception_List.size(); 
         System.debug('Largo exception_List : '+contadorLista);
         for(String error: errores){
       
         Integer largoEr= error.length();                         
         ErrorInvalid= error.subString(0,15);
              
         if( ErrorInvalid=='Invalid integer'){
             
            error='Carácter inválido:'+ error.substring(16,largoEr);                   
            error_list.add(error);
         }else{              
             error_list.add(error);
         }
        }
        
        Integer i=0;
         for (String fila : exception_List) {           
            
            MovCobranzasErrores__c errorAfip = new MovCobranzasErrores__c();
            errorAfip.movErrores__c  =fila;
            errorAfip.idArchivoErrores__c=archivoId;   
            errorAfip.detalleError__c=error_list[i];
            
           i++;
           
            listaErrores.add(errorAfip);            
         }
         insert listaErrores; 
         
                      
            AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
                                TotalJobItems, CreatedBy.email
                                from AsyncApexJob where Id =:bc.getJobId()];
                               
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {a.CreatedBy.Email};
                mail.setToAddresses(toAddresses);
                mail.setSubject('Carga ' + a.Status+' '+ a.Id);
                if(a.NumberOfErrors>0){
                     mail.setHTMLBody('Querido Usuario,  <br/> <br/> La carga de datos ha terminado.'+
                ' Durante el proceso se encontraron ' + a.NumberOfErrors + ' errores. '+
                'El estado es: '+a.Status+ '. Total de lotes procesados: '+ a.TotalJobItems);
                }
                if(a.NumberOfErrors==0  && a.TotalJobItems>0 && exception_List.size()>0){ 
                    mail.setHTMLBody('Querido Usuario,  <br/> <br/> La carga de datos ha terminado.'+
                ' Durante el proceso se encontraron errores. '+
                'El estado es: '+a.Status+ '. Total de lotes procesados: '+ a.TotalJobItems+
                '<br/> Registros no insertados: '+exception_List + '<br/> Los errores son: '+errores);
                }else if(a.NumberOfErrors==0 && a.TotalJobItems>0 && exception_List.size()==0)                  
                
                { 
                    mail.setHTMLBody('Querido Usuario,  <br/> <br/> La carga de datos ha terminado.'+
                ' Durante el proceso no se encontraron errores. '+
                'El estado es: '+a.Status+ '. Total de lotes procesados: '+ a.TotalJobItems);
                }
                if(a.NumberOfErrors==0 && a.TotalJobItems==0){
                    mail.setHTMLBody('Querido Usuario,  <br/> <br/> La carga de datos ha terminado.'+
                ' Durante el proceso se encontraron errores, los datos ingresados no son válidos '+
                'El estado es: '+a.Status+ '. Total de lotes procesados: '+ a.TotalJobItems);
                }             
             
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }