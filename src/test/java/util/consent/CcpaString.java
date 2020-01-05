package util.consent;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CcpaString {

    private Character version;

    private CcpaCharacter explicitNotice;
    private CcpaCharacter optOut;
    private CcpaCharacter lspact;

    public String getUsPrivacyString() {
        return String.valueOf(version)
                .concat(String.valueOf(explicitNotice.getchr()))
                .concat(String.valueOf(optOut.getchr()))
                .concat(String.valueOf(lspact.getchr()));
    }
}
