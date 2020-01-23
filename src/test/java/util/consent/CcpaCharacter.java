package util.consent;

public enum CcpaCharacter {
    Y('Y'),
    N('N'),
    NOT_APPLICABLE('-');

    final Character chr;

    CcpaCharacter(Character chr) {
        this.chr = chr;
    }

    public Character getchr() {
        return chr;
    }
}
