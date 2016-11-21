package com.undertone.qa;

import java.util.List;

public class Zonesets {
    List<Integer> include, exclude;

    private List<Integer> getInclude() {
        return include;
    }

    private void setInclude(List<Integer> include) {
        this.include = include;
    }

    private List<Integer> getExclude() {
        return exclude;
    }

    private void setExclude(List<Integer> exclude) {
        this.exclude = exclude;
    }
    
}
