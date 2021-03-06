package entities;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import infra.module.Named;
import infra.module.WithId;

import java.util.List;
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Deal  implements WithId<Integer>, Named {
    private Integer dealId;
    private String dealName;
    private Integer dspID;
    private Integer floorPrice;
    private Integer dealType;
    private List<Integer> adUnitId;
    private String thirdPartyDealID;

    public Deal(){}

   public Deal(Integer id, String dealName, Integer dspID, Integer floorPrice, Integer dealType, List<Integer> adUnitId) {
        this.dealId = id;
        this.dealName = dealName;
        this.dspID = dspID;
        this.floorPrice = floorPrice;
        this.dealType = dealType;
        this.adUnitId = adUnitId;
    }

    public String getThirdPartyDealID() {
        return thirdPartyDealID;
    }

    public void setThirdPartyDealID(String thirdPartyDealID) {
        this.thirdPartyDealID = thirdPartyDealID;
    }

    @JsonProperty("dealId")
    public Integer getDealId() {
        return dealId;
    }
    @JsonProperty("dealId")
    public void setDealId(Integer dealId) {
        this.dealId = dealId;
    }

    @JsonProperty("dealName")
    public String getDealName() {
        return dealName;
    }
    @JsonProperty("dealName")
    public void setDealName(String dealName) {
        this.dealName = dealName;
    }

    @JsonProperty("dspId")
    public Integer getDspID() {
        return dspID;
    }

    @JsonProperty("dspId")
    public void setDspID(Integer dspID) {
        this.dspID = dspID;
    }

    @JsonProperty("floorPrice")
    public Integer getFloorPrice() {
        return floorPrice;
    }

    @JsonProperty("floorPrice")
    public void setFloorPrice(Integer floorPrice) {
        this.floorPrice = floorPrice;
    }

    @JsonProperty("dealType")
    public Integer getDealType() {
        return dealType;
    }

    @JsonProperty("dealType")
    public void setDealType(Integer dealType) {
        this.dealType = dealType;
    }

    @JsonProperty("adUnitId")
    public List<Integer> getAdUnitId() {
        return adUnitId;
    }

    @JsonProperty("adUnitId")
    public void setAdUnitId(List<Integer> adUnitId) {
        this.adUnitId = adUnitId;
    }

    @Override
    public String getName() {
        return this.dealName;
    }

    @Override
    public Integer getId() {
        return this.dealId;
    }
}
