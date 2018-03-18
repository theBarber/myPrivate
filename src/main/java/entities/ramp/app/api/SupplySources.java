package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class SupplySources {

    List<String> include, exclude;

    public SupplySources(){}

    public SupplySources(List<String>include,List<String>exclude )
    {
        this.include = include;
        this.exclude = exclude;
    }

    @JsonProperty("include")
    public List<String> getInclude() {
        return include;
    }

    @JsonProperty("include")
    public void setInclude(List<String> include) {
        this.include = include;
    }

    @JsonProperty("exclude")
    public List<String> getExclude() {
        return exclude;
    }

    @JsonProperty("exclude")
    public void setExclude(List<String> exclude) {
        this.exclude = exclude;
    }

}
