global class BatchJobTest05 extends batchjobsch.BatchJobBase implements Database.Batchable<sObject> {
    
    public BatchJobTest05() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT  Id 
                                         FROM    Account
                                         WHERE   Type= 'BJS Test'
                                         AND     LastModifiedDate = TODAY]);
    }
     
     
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        for (Account account :scope) {
            account.Type = 'Customer - Direct';
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        super.finishBatch(BC);
    }

}