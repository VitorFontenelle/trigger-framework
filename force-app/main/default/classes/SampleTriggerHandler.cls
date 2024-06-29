/**
 * @description Handler class for Sample__c triggers. This class extends the TriggerHandler base class
 *              to manage trigger operations (insert, update, delete, etc.) for Sample__c records.
 * @class       SampleTriggerHandler
 * @extends     TriggerHandler
 * @see         SampleService
 * @note        This class operates without sharing, meaning it runs in system context and ignores user permissions.
 *              It sets a maximum loop count to avoid infinite trigger recursion.
 * @author      Vitor Fontenelle
 */
public without sharing class SampleTriggerHandler extends TriggerHandler 
{
    // Variables to hold new and old records and their maps
	private List<Sample__c> newRecords;
	private List<Sample__c> oldRecords;
	private Map<Id, Sample__c> newRecordsMap;
	private Map<Id, Sample__c> oldRecordsMap;

    /**
     * @description Constructor that initializes the records and maps based on the current trigger context.
     */
	public SampleTriggerHandler() {
        // Initialize new and old records from the trigger context
		this.newRecords = (List<Sample__c>) Trigger.new;
		this.oldRecords = (List<Sample__c>) Trigger.old;
		this.newRecordsMap = (Map<Id, Sample__c>) Trigger.newMap;
		this.oldRecordsMap = (Map<Id, Sample__c>) Trigger.oldMap;
        
        // Set the maximum loop count to avoid infinite trigger recursion
        this.setMaxLoopCount(10);
	}

    /**
     * @description Method that runs before inserting new Sample__c records.
     *              Delegates the logic to SampleService.beforeInsertSampleMethod.
     */
	public override void beforeInsert() 
    {
		SampleService.beforeInsertSampleMethod(newRecords);
	}

    /**
     * @description Method that runs before updating existing Sample__c records.
     *              Delegates the logic to SampleService.beforeUpdateSampleMethod.
     */
	public override void beforeUpdate() 
    {
		SampleService.beforeUpdateSampleMethod(newRecords, oldRecordsMap);
	}

    /**
     * @description Method that runs before deleting existing Sample__c records.
     *              Currently, no specific logic is implemented.
     */
	public override void beforeDelete() {}

    /**
     * @description Method that runs after inserting new Sample__c records.
     *              Delegates the logic to SampleService.afterInsertSampleMethod.
     */
	public override void afterInsert() 
    {
		SampleService.afterInsertSampleMethod(newRecords);
	}

    /**
     * @description Method that runs after updating existing Sample__c records.
     *              Delegates the logic to SampleService.afterUpdateSampleMethod.
     */
	public override void afterUpdate()
    {
        SampleService.afterUpdateSampleMethod(newRecords, oldRecordsMap);
    }

    /**
     * @description Method that runs after deleting existing Sample__c records.
     *              Currently, no specific logic is implemented.
     */
	public override void afterDelete() {}
}