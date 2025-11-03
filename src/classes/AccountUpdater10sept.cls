public class AccountUpdater10sept {
public static void updateAccountDescription(Id accountId, String newDescription) {
        // 1. Query the Account record
        Account acc = [SELECT Id, Description FROM Account WHERE Id = :accountId LIMIT 1];

        // 2. Update the Description field
        if (acc != null) {
            acc.Description = newDescription;

            // 3. Perform the DML update
            try {
                update acc;
                System.debug('Account Description updated successfully for Account ID: ' + accountId);
            } catch (Exception e) {
                System.debug('Error updating Account: ' + e.getMessage());
            }
        } else {
            System.debug('Account not found for ID: ' + accountId);
        }
    }
}