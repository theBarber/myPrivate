package com.undertone.qa.ramp.models;
;

/**
 * Created by AssafM on 11/01/2017.
 */
public class ExperimentGroup {
    String name;
    Integer active;
    String startDate;
    String endDate;
    String adUnits;
    String zoneTypes;
    Integer lbTraffic;

    Integer id;
    String createdAt;
    String updatedAt;


    public ExperimentGroup(String name, Integer active, String startDate, String endDate, String adUnits, String zoneTypes, Integer lbTraffic){
	this.name = name;
	this.active = active;
	this.startDate = startDate;
	this.endDate = endDate;
	this.adUnits = adUnits;
	this.zoneTypes = zoneTypes;
	this.lbTraffic = lbTraffic;
    }

    public String getName(){
	return name;
    }

    public Integer getActive(){
	return active;
    }

    public String getStartDate(){return startDate;}

    public String getEndDate() {return endDate;}

    public String getAdUnits(){
	return adUnits;
    }

    public String getZoneTypes(){
	return zoneTypes;
    }

    public Integer getLbTraffic(){
	return lbTraffic;
    }

    public void setId(Integer id) {this.id = id;}

    public void setCreatedAt(String createdAt) { this.createdAt = createdAt;}

    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt;}

    @Override
    public String toString(){
	return (id) + ","
		+ "'" + name + "'" + ","
		+ "'" + endDate + "'" + ","
		+ active + ","
		+ "'" + startDate + "'" + ","
		+ "'" + adUnits + "'" + ","
		+ "'" + zoneTypes + "'" + ","
		+ "'" + createdAt + "'" + ","
		+ "'" + updatedAt + "'" + ","
		+ lbTraffic + ","
		+ null;
    }

}
