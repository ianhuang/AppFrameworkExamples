/*----------------------------------------------------------------------------------------------
   Description:     Trigger Data Manager example
   History:         11-August-2020     Ian Huang     Created
----------------------------------------------------------------------------------------------*/

public class AccountTriggerDataManager extends TriggerDataManagerBase {
    
	//public static final Id ACCOUNT_RECORDTYPEID          = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Account').getRecordTypeId();
	public static final Id BUSINESS_ACCOUNT_RECORDTYPEID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Business_Account').getRecordTypeId();

    public List<Contact> childContacts { get; private set; }
    
    public AccountTriggerDataManager() {
        childContacts = new List<Contact>(); 
    }
    
    protected override void loadBeforeEventsData() {
    }

    protected override void loadAfterEventsData() {
		loadChildContacts();
    }
    
    public override void commitChanges() {
        update this.childContacts;
    }
    
    private void loadChildContacts() {
        this.childContacts = [SELECT Id, FirstName, LastName, AccountId,
                                     MailingStreet, MailingCity, MailingState,
                                     MailingPostalCode, MailingCountry 
                              FROM   Contact
                              WHERE  AccountId IN :this.triggerData.newIdSet];
    }

}