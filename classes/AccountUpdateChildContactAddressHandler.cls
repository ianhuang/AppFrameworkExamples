/*----------------------------------------------------------------------------------------------
   Description:     Trigger handler example - Propagate Account address updates to child contacts
                    Ruby-???? (JIRA Ref#) 
   History:         11-August-2020     Ian Huang     Created
----------------------------------------------------------------------------------------------*/

public Inherited Sharing class AccountUpdateChildContactAddressHandler extends TriggerHandlerBase {
    
    public override void handle() {
        try {
        	//retrieve account map by record types
        	List<Account> accounts = (List<Account>)getFilteredRecords();
        
            //retrieve child contact records 
            List<Contact> contacts = getChildContacts(accounts);
	        
			//coty account billing address to contact mailing address
			updateContactAddress(contacts);         
        } catch(Exception ex) {
            ApplicationLogHelper.logException('Trigger', 'AccountUpdateChildContactAddressHandler', 'handle', ex);
        }
    }
    
    //filters out the records you don't need with record type Id
    protected override List<sObject> getFilteredRecords() {
        List<Account> result = new List<Account>();
        for(Account account : (List<Account>)triggerData.newList) {
            if(account.RecordTypeId == AccountTriggerDataManager.BUSINESS_ACCOUNT_RECORDTYPEID) {
                result.add(account);
            }
        }
        return result;
    }
    
    private List<Contact> getChildContacts(List<Account> accounts) {
        List<Contact> result = new List<Contact>();
        Set<Id> accountIdSet = getReocrdIdSet(accounts);
        //use the childContacts collection from trigger data manager
        for(Contact contact : ((AccountTriggerDataManager)this.dataManager).childContacts) {
            //filters contacts with AccountId
            if(accountIdSet.contains(contact.AccountId)) {
                result.add(contact);
            }
        }
        return result;
    }
    
    private void updateContactAddress(List<Contact> contacts) {
        Account account;
        for(Contact contact : contacts) {
            if(this.triggerData.newMap.containsKey(contact.AccountId)) {
                //get related account from triggerData newMap 
                account = (Account)this.triggerData.newMap.get(contact.AccountId);
            	contact.MailingStreet     = account.BillingStreet;
                contact.MailingCity       = account.BillingCity;
                contact.MailingState      = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                contact.MailingCountry    = account.BillingCountry;
            }
        }
        update contacts;
    }

}