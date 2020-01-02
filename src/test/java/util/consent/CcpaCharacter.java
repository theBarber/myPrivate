package util.consent;

public enum CcpaCharacter {
    Y('Y'),
    N('N'),
    MINUS('-');

    final Character chr;

    CcpaCharacter(Character chr) {
        this.chr = chr;
    }

    public Character getchr() {
        return chr;
    }
}
