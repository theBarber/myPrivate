package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class SupplySources {

    List<SupplySource> include, exclude;

    public SupplySources(){}

    public SupplySources(List<SupplySource>include,List<SupplySource>exclude )
    {
        this.include = include;
        this.exclude = exclude;
    }

    @JsonProperty("include")
    public List<SupplySource> getInclude() {
        return include;
    }

    @JsonProperty("include")
    public void setInclude(List<SupplySource> include) {
        this.include = include;
    }

    @JsonProperty("exclude")
    public List<SupplySource> getExclude() {
        return exclude;
    }

    @JsonProperty("exclude")
    public void setExclude(List<SupplySource> exclude) {
        this.exclude = exclude;
    }

}
