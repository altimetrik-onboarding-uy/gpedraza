public class SecurityHandler {
    public static boolean canUpdateContactFields(String[] contactUpdateFields){
        // Obtaining the field name/token map for the Contact object
      Map<String,Schema.SObjectField> m = Schema.SObjectType.Contact.fields.getMap();
      for (String fieldToCheck : contactUpdateFields) {
        // Check if the user has create access on the each field
        if (!m.get(fieldToCheck).getDescribe().isUpdateable()) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                                                    'Insufficient access')); 
          return false;
        }
      }
        return true;
    }
   
    public static boolean canAccesTask_MonitorFields(String[] tasktAccesFields){
        // Obtaining the field name/token map for the Contact object
      Map<String,Schema.SObjectField> m = Schema.SObjectType.Task_Monitor__c.fields.getMap();
      for (String fieldToCheck : tasktAccesFields) {
        // Check if the user has create access on the each field
        if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                                                    'Insufficient access')); 
          return false;
        }
      }
        return true;
    }
}