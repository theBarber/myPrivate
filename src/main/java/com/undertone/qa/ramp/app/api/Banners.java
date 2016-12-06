package com.undertone.qa.ramp.app.api;

import java.util.List;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonProperty;

import com.undertone.qa.Banner;

public class Banners {

    private List<Banner> banners;

    public Banners(@JsonProperty("banners") List<Banner> banners) {
	this.banners = banners;
    }

    public Stream<Banner> stream() {
	return this.banners.stream();

    }
}
