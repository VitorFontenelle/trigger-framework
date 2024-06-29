/**
 * @description Service class for handling business logic related to Sample__c records.
 * @author Vitor Fontenelle
 */
public class SampleService 
{   
    /**
     * @description Sample method to handle logic before inserting Sample__c records.
     * @author Vitor Fontenelle
     * @param newSampleList List of new Sample__c records being inserted.
     */
    public static void beforeInsertSampleMethod(List<Sample__c> newSampleList) 
    {
        for (Sample__c sample : newSampleList) 
        {
            if (sample.SampleOwner__c == null) 
            {
                sample.addError('Sample Owner cannot be empty');
            }
            
            sample.OwnerId = UserInfo.getUserId();
        }
    }

    /**
     * @description Sample method to handle logic after inserting Sample__c records.
     * @author Vitor Fontenelle
     * @param newSampleList List of new Sample__c records that were inserted.
     */
    public static void afterInsertSampleMethod(List<Sample__c> newSampleList) 
    {
        // Set to store unique SampleOwner__c IDs
        Set<Id> sampleOwnerSet = new Set<Id>();
        
        for (Sample__c sample : newSampleList) 
        {
            if(sample.SampleOwner__c != null) sampleOwnerSet.add(sample.SampleOwner__c);
        }
        
        List<Contact> ownerList = [SELECT Id, Description FROM Contact WHERE Id IN :sampleOwnerSet];
        
        for (Contact owner : ownerList) 
        {
            if(owner.Description == null) owner.Description = 'Sample owner';
        }
        
        update ownerList;
    }

    /**
     * @description Sample method to handle logic before updating Sample__c records.
     * @author Vitor Fontenelle
     * @param newSampleList List of Sample__c records being updated.
     * @param oldSampleMap Map of old Sample__c records keyed by their IDs.
     */
    public static void beforeUpdateSampleMethod(List<Sample__c> newSampleList, Map<Id, Sample__c> oldSampleMap) 
    {
        for (Sample__c sample : newSampleList) 
        {
            Sample__c oldRecord = oldSampleMap.get(sample.Id);
            
            if (sample.Name != oldRecord.Name && sample.Name == 'Approved') 
            {
                sample.Name = 'Processed';
            }
        }
    }

    /**
     * @description Sample method to handle logic after updating Sample__c records.
     * @author Vitor Fontenelle
     * @param newSampleList List of Sample__c records that were updated.
     * @param oldSampleMap Map of old Sample__c records keyed by their IDs.
     */
    public static void afterUpdateSampleMethod(List<Sample__c> newSampleList, Map<Id, Sample__c> oldSampleMap) 
    {
        for (Sample__c sample : newSampleList) 
        {
            Sample__c oldRecord = oldSampleMap.get(sample.Id);
            System.debug('Record updated - Old Name: ' + oldRecord.Name + ', New Name: ' + sample.Name);
        }
    }
}