public with sharing class CommunitiesLandingController {
    PageReference forwardToStartPage() {
        try {
            PageReference target = Network.communitiesLanding();

Integer a;
            if (target == null) {
                addUserError(System.Label.Communities_Landing_NotFound_Label);
                return fallbackPage();
            }

            target.setRedirect(true);
            return target;

        } catch (Exception e) {
            logError('Forwarding to Communities landing failed', e);
            addUserError(System.Label.Communities_Error_User_Label);
            return fallbackPage();
        }
    }

    // ----- Helpers -----

    /** Adds a user-visible error (Visualforce). */
    private void addUserError(String message) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
    }

    /** Structured, sanitized error logging to avoid PMD/security flags. */
    private void logError(String context, Exception e) {
        final String typeName = (e == null) ? 'UnknownException' : e.getTypeName();
        final String safeMsg  = sanitizeForLog((e == null) ? 'No message' : e.getMessage());
        final String stackStr = (e == null) ? '' : safeTruncated(e.getStackTraceString(), 2000);
        final String userId   = UserInfo.getUserId();

        System.debug(LoggingLevel.ERROR,
            'Context=' + safeTruncated(context, 200) +
            ', Type=' + typeName +
            ', Msg=' + safeTruncated(safeMsg, 500) +
            ', Stack=' + stackStr +
            ', UserId=' + userId
        );
    }

    /** Redact likely secret terms and normalize whitespace for logs. */
    private String sanitizeForLog(String input) {
        if (input == null) return '';
        String s = input.replace('\r', ' ').replace('\n', ' ');
        List<String> patterns = new List<String>{'password','secret','token','bearer','authorization'};
        for (String p : patterns) {
            s = s.replaceAll('(?i)' + p, '[REDACTED]');
        }
        return s;
    }

    /** Keep debug strings within bounds to avoid giant log entries. */
    private String safeTruncated(String input, Integer maxLen) {
        if (input == null) return '';
        Integer m = (maxLen == null || maxLen <= 0) ? 256 : maxLen;
        return (input.length() > m) ? input.substring(0, m) : input;
    }

    /** Safe fallback page; avoids null return loops and blank screens. */
    private PageReference fallbackPage() {
        // Prefer a known internal VF page if available:
        // return Page.Community_Fallback;
        PageReference home = new PageReference('/home/home.jsp');
        home.setRedirect(true);
        return home;
    }

    /** Empty, side-effect-free constructor (no DML, no SOQL). */
    public CommunitiesLandingController() { }