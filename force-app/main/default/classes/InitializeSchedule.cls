global class InitializeSchedule implements  InstallHandler {
    global void onInstall(InstallContext context){
       
        String scheduleContext = '0 59 23 * * ? *';
        String jobId = system.schedule('Reset Tasks', scheduleContext, new ResetDailyHabitTasks());
    }
}