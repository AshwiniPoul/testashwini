@isTest
public class OpportunityValidationTriggerTest {
    @isTest static void testCloseDateValidation() {
        Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=System.today().addDays(-1), StageName='Prospecting', Amount=12000);
        insert opp;

        Test.startTest();
        try {
            opp.StageName = 'Qualification';
            update opp;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Opportunity cannot have a Close Date in the past.'));
        }
        Test.stopTest();
    }

    @isTest static void testStageTransitionLock() {
        Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=System.today().addDays(7), StageName='Prospecting', Amount=8000);
        insert opp;

        Test.startTest();
        try {
            opp.StageName = 'Closed Won';
            opp.Amount = 15000;
            update opp;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Opportunity cannot transition directly from Prospecting to Closed Won.'));
        }
        Test.stopTest();
    }

    @isTest static void testMinimumAmountForClosedWon() {
        Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=System.today(), StageName='Closed Won', Amount=5000);
        insert opp;

        Test.startTest();
        try {
            opp.Amount = 8000;
            update opp;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Opportunity in Closed Won stage must have an Amount greater than or equal to amount 10,000.'));
        }
        Test.stopTest();
    }
}