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
            Y.getchr(), CcpaCharacter.Y,
            N.getchr(), CcpaCharacter.N,
            MINUS.getchr(), CcpaCharacter.MINUS
    );

    public static CcpaCharacter parse(Character chr) {
        return CHR_TO_CCPA_CHR_MAP.get(chr);
    }

    public Character getchr() {
        return chr;
    }
}
