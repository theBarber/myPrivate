package com.undertone.qa.ramp.app.api;

import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.undertone.automation.module.Named;
import com.undertone.automation.module.WithId;

public class CreativeResponse implements WithId<Integer>, Named {

    final private Integer creativeId;
    final private String creativeName;

    public CreativeResponse(@JsonProperty("creativeId")Integer creativeId, @JsonProperty("creativeName")String creativeName) {
	this.creativeId = Objects.requireNonNull(creativeId);
	this.creativeName = Objects.requireNonNull(creativeName);
    }

    @Override
    public String getName() {
	return this.creativeName;
    }

    @Override
    public Integer getId() {
	return this.creativeId;
    }
}
