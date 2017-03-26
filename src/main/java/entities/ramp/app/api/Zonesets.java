package entities.ramp.app.api;

import java.util.List;

import entities.ZoneSet;
/***
 * This is the model of RampApp ZoneSets
 * Sorry for the duplication with {@link ZoneSet}
 * @author aharon
 *
 */
public class Zonesets {
    List<Integer> include, exclude;

    private List<Integer> getInclude() {
        return include;
    }

    private void setInclude(List<Integer> include) {
        this.include = include;
    }

    private List<Integer> getExclude() {
        return exclude;
    }

    private void setExclude(List<Integer> exclude) {
        this.exclude = exclude;
    }
    
}
