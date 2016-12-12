package com.undertone.qa.ramp.app.api;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonProperty;

import com.undertone.qa.Banner;
import com.undertone.qa.BannerFromCreative;

public class Banners {

    private final List<Banner> banners;

    public Banners(@JsonProperty("banners") List<BannerFromCreative> banners) {
	this.banners = new ArrayList<>(banners);
    }

    public Stream<Banner> stream() {
	return this.banners.stream();

    }
}
