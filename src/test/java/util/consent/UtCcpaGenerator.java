package util.consent;

public class UtCcpaGenerator {

    private static UtCcpaGenerator instance;

    private static final Character CCPA_VERSION = '1';
    private static final CcpaCharacter CCPA_DEFAULT_EXPLICIT_NOTICE = CcpaCharacter.Y;
    private static final CcpaCharacter CCPA_DEFAULT_LSPACT = CcpaCharacter.Y;

    private static final String CCPA_NOT_APPLICABLE_STR = "1---";

    private UtCcpaGenerator() {
    }

    public static UtCcpaGenerator getInstance() {
        if (instance == null) {
            instance = new UtCcpaGenerator();
        }
        return instance;
    }

    public synchronized String getUtDefaultUsPrivacyString(CcpaCharacter optOut) {
        final CcpaString ccpaStr = CcpaString.builder()
                .version(CCPA_VERSION)
                .explicitNotice(CCPA_DEFAULT_EXPLICIT_NOTICE)
                .optOut(optOut)
                .lspact(CCPA_DEFAULT_LSPACT)
                .build();

        return ccpaStr.getUsPrivacyString();
    }

    public String getNotApplicableUsPrivacyString() {
        return CCPA_NOT_APPLICABLE_STR;
    }
}
