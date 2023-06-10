public with sharing class CustomSearchController {
    
  @AuraEnabled(cacheable=true)  
  public static List<sobject> findRecords(String searchKey, String objectName) {
      List < sObject > returnList = new List < sObject > ();
      // string searchText = '\'' + String.escapeSingleQuotes(searchKey) + '%\'';  
      string sQuery = 'SELECT Id,Code__c,Maximo__c, Minimo__c,Riesgo__c, Description__c FROM ' +String.escapeSingleQuotes(objectName)+ ' WHERE Description__c Like \'%' + String.escapeSingleQuotes(searchKey) + '%\' LIMIT 6';  
      for (sObject obj: database.query(sQuery)) {
          returnList.add(obj);
      }
      return returnList;
  }  
}