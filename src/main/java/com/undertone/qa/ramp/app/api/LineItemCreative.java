package com.undertone.qa.ramp.app.api;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class LineItemCreative {

    @JsonProperty("creatives")
    public List<Creative> creatives;
}
