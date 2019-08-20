package model;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Mainly used in gdpr\eu\country-based tests.
 */
public enum Country {
    UK("193.117.138.126");

    private final Set<String> ips;

    Country(String... ips) {
        this.ips = new HashSet<>(Arrays.asList(ips));
    }

    public Set<String> getIps() {
        return ips;
    }
}
