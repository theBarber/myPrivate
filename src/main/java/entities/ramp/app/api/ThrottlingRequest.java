package entities.ramp.app.api;
public class ThrottlingRequest {

    private Integer publisherId;
    private Integer placementGroupId;
    private String status;
    private Integer factor;

    public ThrottlingRequest(Integer publisherId, Integer placementGroupId, String status, Integer factor){
        if(status.equals("inactive")){
            this.factor = 0;
        }else{
            this.factor = factor;
        }
        this.status=status;
        this.publisherId=publisherId;
        this.placementGroupId=placementGroupId;
    }

    public String getStatus() {
        return status;
    }

    public Integer getFactor() {
        return factor;
    }

    public Integer getPublisherId() {
        return publisherId;
    }

    public Integer getPlacementGroupId() {
        return placementGroupId;
    }
}
