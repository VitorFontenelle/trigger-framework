/**
 * @description Trigger for Sample__c that delegates processing to the SampleTriggerHandler.
 * @trigger     SampleTrigger
 */
trigger SampleTrigger on Sample__c (before insert, after insert, before update, after update, before delete, after delete) 
{
    // Instantiate the SampleTriggerHandler class and call its run method extended from TriggerHandler to handle the trigger events
	new SampleTriggerHandler().run();
}