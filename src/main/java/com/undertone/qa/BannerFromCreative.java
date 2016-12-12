package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName("Banner")
public class BannerFromCreative extends Banner {

    private final Integer creativeId;

    public BannerFromCreative(@JsonProperty("creativeName") String name, @JsonProperty("bannerId") Integer id,
	    @JsonProperty("creativeId") Integer creativeId) {
	super(name, id);
	this.creativeId = requireNonNull(creativeId);
    }

    public Integer getCreativeId() {
	return creativeId;
    }
}
