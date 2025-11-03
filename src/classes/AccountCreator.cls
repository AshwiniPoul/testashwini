public class AccountCreator {

    public static Account createAccount(String accountName) {
        Account newAccount = new Account();
        newAccount.Name = accountName;
        //newAccount.Phone = phone;
        //newAccount.Industry = industry;

        try {
            insert newAccount;
            return newAccount;
        } catch (DmlException e) {
            // Handle the exception (e.g., log the error, return null, etc.)
            System.debug('Error creating account: ' + e.getMessage());
            return null;
        }
    }
}