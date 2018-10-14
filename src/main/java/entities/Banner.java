package entities;

import static java.util.Objects.requireNonNull;

import java.util.Comparator;
import java.util.Optional;
import java.util.function.Predicate;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import entities.ramp.app.api.Creative;
import infra.module.Named;
import infra.module.WithId;
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Banner implements Named, WithId<Integer>, Comparable<Banner> {

	private String name;
	private Integer id;

	public Banner(){}
	public Banner(String name, Integer id) {
		this.name = requireNonNull(name);
		this.id = requireNonNull(id);
	}

	/**
	 * A {@link Banner} has a name.
	 * @return the name of this banner
	 */
	@Override
	@JsonProperty("bannerName")
	public String getName() {
		return name;
	}

	@Override
	@JsonProperty("bannerId")
	public Integer getId() {
		return id;
	}

	@Override
	public int compareTo(Banner that) {
		return Comparator.comparing(Banner::getId).compare(this, requireNonNull(that));
	}

	@Override
	public String toString() {
		return "Banner [name=" + getName() + "]";
	}
	@JsonProperty("bannerName")
	public void setName(String name)
	{
		this.name = name;
	}

	@JsonProperty("bannerId")
	public void setId(Integer id) {
		this.id = id;
	}
}
