// calculate the points amounts of the employees
// Trigger is launched before process builder
trigger AlterAmountEmployee on Task_Monitor__c ( after update) {
    new AlterAmountEmployeeHandler().run();
}