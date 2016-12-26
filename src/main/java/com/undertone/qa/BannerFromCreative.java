package com.undertone.qa;

import static java.util.Objects.requireNonNull;

import java.util.Optional;
import java.util.function.Predicate;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.undertone.qa.ramp.app.api.Creative;

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

    public boolean isFromCreative(Creative c) {
	return this.isFromCreative(c.getId());
    }

    public boolean isFromCreative(Integer c) {
	return this.creativeId.equals(c);
    }
    
    public static Predicate<BannerFromCreative> fromCreative(Optional<Creative> c){
	return b->c.filter(b::isFromCreative).isPresent();
    }
}
