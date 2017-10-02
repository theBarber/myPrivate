package entities.ramp.app.api;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import entities.ZoneSet;
/***
 * This is the model of RampApp ZoneSets
 * Sorry for the duplication with {@link ZoneSet}
 * @author aharon
 *
 */
public class Zonesets {
    List<Integer> include, exclude;

    @JsonProperty("include")
    public List<Integer> getInclude() {
        return include;
    }

    @JsonProperty("include")
    public void setInclude(List<Integer> include) {
        this.include = include;
    }

    @JsonProperty("exclude")
    public List<Integer> getExclude() {
        return exclude;
    }

    @JsonProperty("exclude")
    public void setExclude(List<Integer> exclude) {
        this.exclude = exclude;
    }
    
}
