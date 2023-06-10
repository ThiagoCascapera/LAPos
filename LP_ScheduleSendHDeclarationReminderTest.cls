@isTest
public with sharing class LP_ScheduleSendHDeclarationReminderTest {

    @isTest
    public static void executeTest (){
        Test.startTest();
        String jobId = System.schedule('Luck Test',  '0 59 * * * ?', new LP_ScheduleSendHDeclarationReminder());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered
         FROM CronTrigger 
         WHERE id = :jobId];
         System.assertEquals('0 59 * * * ?', ct.CronExpression);
         System.assertEquals(0, ct.TimesTriggered);
         Test.stopTest();
    }

}
