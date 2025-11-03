@isTest

public class ConOnNewAccTest {

    @isTest

    public static void testTrigger() {

        List<Account> accList = new List<Account>();

        Set<Id> accIds = new Set<Id>();

        for(integer i=0;i<10;i++) {

            accList.add(new Account(Name='TestAccount'+i));

        }

        insert accList;

        for(Account acc: accList) {

            accIds.add(acc.Id);

        }

        List<Contact> conList = new List<Contact>([Select Id, AccountId From Contact Where AccountId In :accIds]); 

        System.assertEquals(10, conList.size());

    }

}