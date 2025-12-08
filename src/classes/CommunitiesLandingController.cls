public with sharing class CommunitiesLandingController {
    // Page load entrypoint: safely forward to the Communities landing page
    public PageReference forwardToStartPage() {
        // If your org uses a logging utility, replace System.debug with Logger.error(...)
        // Optional: Savepoint if you plan DB work later in this method
        // Savepoint sp = Database.setSavepoint();

        try {
            // Primary intent: resolve the Communities landing page
            PageReference target = Network.communitiesLanding();
            
            if (target == null) {
                // Defensive: handle unexpected nulls gracefully
                addUserError('We could not find the Communities landing page right now. Please try again later.');
                return fallbackPage();
            }

            // Good practice: explicit redirect to avoid stale view state issues
            target.setRedirect(true);
            return target;

        } catch (Exception e) {
            // Roll back only if you used a Savepoint and did DML
            // Database.rollback(sp);

            // Developer-grade diagnostics
            logError('Error forwarding to Communities landing', e);

            // User-friendly message (no internals exposed)
            addUserError('Something went wrong while opening Communities. Please retry, or contact support.');

            // Fail closed to a safe fallback
            return fallbackPage();
        } finally {
            // Cleanup if needed: release resources, clear state, etc.
        }
    }

    // ----- Helpers -----

    // Centralized user messaging for Visualforce contexts
    private void addUserError(String message) {
        // For Visualforce pages
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
        // For Lightning, consider returning an error attribute or using a toast in the client controller
    }

    // Minimal, structured error logging (replace with your org's Logger if available)
    private void logError(String context, Exception e) {
        // Include correlation data (e.g., User Id, Network Id) as needed
        String diagnostic = String.format(
            '{0}. ExceptionType={1}, Message={2}, StackTrace={3}, UserId={4}',
            new List<String>{
                context,
                e.getTypeName(),
                e.getMessage(),
                e.getStackTraceString(),
                UserInfo.getUserId()
            }
        );
        System.debug(LoggingLevel.ERROR, diagnostic);

        // Recommended: send to a custom Logger, Platform Event, or Error__c SObject
        // Logger.error(context, e);  // if you have a logging framework
    }

    // Safe fallback page (use a known Visualforce page or a neutral home)
    private PageReference fallbackPage() {
        // Replace with an internal safe landing page:
        // return Page.Community_Fallback;  // if you have a VF page
        // As a generic safe default, null means stay on current page showing the error
        return null;
    }

    public CommunitiesLandingController() {}