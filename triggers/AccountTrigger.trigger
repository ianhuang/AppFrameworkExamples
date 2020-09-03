/*------------------------------------------------------------
Description:   Account Trigger
History:       Ian Huang   Created 
------------------------------------------------------------*/
trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete) {
    
    //skip trigger execution if bypass trigger setting is set to true 
    if(Triggers.isMuted()) { return; }
    
    new Triggers()
        //bind a data manager
        .bindDataManager(new AccountTriggerDataManager())                              
        //Ruby-????(JIRA Ref#) bind a handler to afterUpdate event, set trigger recusion to 10 
        .bind(Triggers.Evt.afterUpdate, new AccountUpdateChildContactAddressHandler().setMaximumExecutionCount(10))
        .execute();

}