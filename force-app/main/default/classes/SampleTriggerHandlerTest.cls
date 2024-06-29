/**
 * @description Test class for SampleTriggerHandler and SampleService
 * @author Vitor Fontenelle
 */

@IsTest
private class SampleTriggerHandlerTest 
{
    /**
     * @description Test method to verify the insert and update behavior of the SampleTriggerHandler
     */
    @IsTest
    static void insertUpdateAccount() 
    {
        // Creating a new Contact record for iteraction
        Contact newContact = new Contact
        (
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            Phone = '1234567890',
            Title = 'Sample Contact'
        );

        insert newContact;
        
        // Create a new Sample__c record linked to the Contact
        Sample__c sample = new Sample__c
        (
            Name = 'TestAcct', 
            SampleOwner__c = newContact.Id
        );

        Test.startTest();
        
        insert sample;

        sample = [SELECT Id, Name FROM Sample__c WHERE Id = :sample.Id LIMIT 1];

        // Update the Sample__c record to trigger Update logic
        sample.Name = 'Approved';
        update sample;
        
        Test.stopTest();
        
        // Query the inserted Sample__c record to verify if logic was correctly executed
        Sample__c insertedSample = [SELECT Id, Name, SampleOwner__c, OwnerId FROM Sample__c WHERE Id = :sample.Id LIMIT 1];
        System.assertEquals(UserInfo.getUserId(), insertedSample.OwnerId, 'OwnerId should be set to the current user.');
        System.assertEquals('Processed', insertedSample.Name, 'Sample Name should be updated to "Processed" when it is set to "Approved".');
        
        // Query the inserted Contact record to verify if logic was correctly executed
        Contact updatedContact = [SELECT Id, Description FROM Contact WHERE Id = :newContact.Id LIMIT 1];
        System.assertEquals('Sample owner', updatedContact.Description, 'Contact Description should be updated to "Sample owner".');
    }
}