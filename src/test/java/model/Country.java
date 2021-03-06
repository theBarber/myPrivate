package model;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Mainly used in consent\eu\country-based tests.
 */
public enum Country {
    UK("193.117.138.126"),
    CA("174.66.137.222"),
    IL("217.65.47.30"),
    NY("78.31.205.183");

    private final Set<String> ips;

    Country(String... ips) {
        this.ips = new HashSet<>(Arrays.asList(ips));
    }

    public Set<String> getIps() {
        return ips;
    }
}
