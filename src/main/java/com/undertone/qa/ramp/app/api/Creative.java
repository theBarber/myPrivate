package com.undertone.qa.ramp.app.api;

import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class Creative implements WithId<Integer>, Named {

    final private Integer creativeId;
    final private String creativeName;
    final private Integer adUnitId;

    public Creative(@JsonProperty("creativeId") Integer creativeId,
	    @JsonProperty("creativeName") String creativeName, @JsonProperty("adUnitId") Integer adUnitId) {
	this.creativeId = Objects.requireNonNull(creativeId);
	this.creativeName = Objects.requireNonNull(creativeName);
	this.adUnitId = adUnitId;
    }

    @Override
    public String getName() {
	return this.creativeName;
    }

    @Override
    public Integer getId() {
	return this.creativeId;
    }

    public Integer getAdUnitId() {
	return adUnitId;
    }
}
