@isTest
    public class AccountCreationTest {
        @testSetup
        static void setup() {
            // Create a test account
            Account testAccount = new Account(Name = 'Test Account');
            insert testAccount;
        }
    
        @isTest
        static void testAccountCreation() {
            // Retrieve the test account created in setup
            Account acc = [SELECT Name FROM Account WHERE Name = 'Test Account'];
            System.assertEquals('Test Account', acc.Name);
        }
    }