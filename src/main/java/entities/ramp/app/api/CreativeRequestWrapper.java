package entities.ramp.app.api;


import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.poi.ss.usermodel.CreationHelper;

public class CreativeRequestWrapper {

    CreativeRequest creativeRequest;

    public CreativeRequestWrapper(){}

    public CreativeRequestWrapper(@JsonProperty("creative") CreativeRequest creativeRequest) {
        this.creativeRequest = creativeRequest;
    }

    @JsonProperty("creative")
    public CreativeRequest getCreativeRequest() {
        return creativeRequest;
    }

    @JsonProperty("creative")
    public void setCreativeRequest(CreativeRequest creativeRequest) {
        this.creativeRequest = creativeRequest;
    }
}
