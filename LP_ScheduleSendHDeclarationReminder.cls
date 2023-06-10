
public class LP_ScheduleSendHDeclarationReminder implements Schedulable {

    public LP_ScheduleSendHDeclarationReminder() {}

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new LP_SendHealthDeclarationReminder(), 40);
    }
    
}