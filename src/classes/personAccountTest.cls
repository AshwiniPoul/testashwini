@IsTest 

public class personAccountTest {

    @TestSetup

     static void makeData() {

     Id personAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

 

Account testAccount = new Account (Name='test');

 

insert testAccount;

//After that query  the account from database to be able to see the PersonContactId field value

     }

 

}