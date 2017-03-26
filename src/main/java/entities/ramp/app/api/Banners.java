package entities.ramp.app.api;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonProperty;

import entities.Banner;

public class Banners {

    private final List<Banner> banners;

    public Banners(@JsonProperty("banners") List<Banner> banners) {
	this.banners = new ArrayList<>(banners);
    }

    public Stream<Banner> stream() {
	return this.banners.stream();

    }
}
