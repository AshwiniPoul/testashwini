@isTest
public class opportunitytest {
   


    // create test data

    @testSetup public static void createOpportunityData() {

        // create standard price book

        Pricebook2 stdPricebook = new Pricebook2(

            Name = 'Standard Price Book', 

            IsActive = true

        );

        insert stdPricebook;

        // create custom price book

        Pricebook2 customPricebook = new Pricebook2(

            Name = 'Custom Price Book', 

            IsActive = true

        );

        insert customPricebook;

        // create product with standard price book and custom price book entries

        Product2 product = new Product2(

            Name = 'Test Product',

            ProductCode = 'TEST001',

            IsActive = true

        );

        insert product;

        // add standard price book entry for the product

        PricebookEntry stdPricebookEntry = new PricebookEntry(

            Pricebook2Id = stdPricebook.Id,

            Product2Id = product.Id,

            UnitPrice = 100.0,

            IsActive = true

        );

        insert stdPricebookEntry;

        // add custom price book entry for the product

        PricebookEntry customPricebookEntry = new PricebookEntry(

            Pricebook2Id = customPricebook.Id,

            Product2Id = product.Id,

            UnitPrice = 150.0,

            IsActive = true

        );

        insert customPricebookEntry;

        // create account with Client_Type__c field

        Account account = new Account(

            Name = 'Test Account'

            //Client_Type__c = 'Associate'

        );

        insert account;

        // create opportunity related to the account

        Opportunity opportunity = new Opportunity(

            Name = 'Test Opportunity',

            StageName = 'Prospecting',

            CloseDate = Date.today(),

            AccountId = account.Id

        );

        insert opportunity;

        // create opportunity product related to the opportunity and the product

        OpportunityLineItem opportunityProduct = new OpportunityLineItem(

            OpportunityId = opportunity.Id,

            PricebookEntryId = customPricebookEntry.Id,

            Quantity = 10,

            UnitPrice = customPricebookEntry.UnitPrice

        );

        insert opportunityProduct;

    }



}