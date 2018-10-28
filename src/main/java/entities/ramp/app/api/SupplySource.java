package entities.ramp.app.api;

import com.fasterxml.jackson.annotation.JsonProperty;

public class SupplySource {
    private String name;
    private Integer type;

    public SupplySource(String name,Integer type) {
        this.name = name;
        this.type = type;
    }
    @JsonProperty("address")
    public String getName() {
        return name;
    }
    @JsonProperty("address")
    public void setName(String name) {
        this.name = name;
    }
    @JsonProperty("type")
    public Integer getType() {
        return type;
    }
    @JsonProperty("type")
    public void setType(Integer type) {
        this.type = type;
    }
}
