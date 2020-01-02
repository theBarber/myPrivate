package util.consent;

import com.google.common.collect.ImmutableMap;

import java.util.Map;

public enum CcpaCharacter {
    Y('Y'),
    N('N'),
    MINUS('-');

    final Character chr;

    CcpaCharacter(Character chr) {
        this.chr = chr;
    }

    static final Map<Character, CcpaCharacter> CHR_TO_CCPA_CHR_MAP = ImmutableMap.of(
            Y.getchr(), Y,
            N.getchr(), N,
            MINUS.getchr(), MINUS
    );

    public static CcpaCharacter chrToCcpaCharacter(Character chr) {
        return CHR_TO_CCPA_CHR_MAP.get(chr);
    }

    public Character getchr() {
        return chr;
    }
}
