package com.undertone.qa.ramp.models;

/**
 * Created by AssafM on 11/01/2017.
 */
public class Experiment {
    String name;
    Integer active;
    Integer allocation;
    Integer isControl;
    Integer isDefault;

    Integer id;
    Integer experimentGroupId;
    String createdAt;
    String updatedAt;

    public Experiment(String name, Integer active, Integer allocation, Integer isControl, Integer isDefault){
	this.name = name;
	this.active = active;
	this.allocation = allocation;
	this.isControl = isControl;
	this.isDefault = isDefault;
    }

    public String getName(){
	return name;
    }

    public Integer getActive(){
	return active;
    }

    public Integer getAllocation(){return allocation;}

    public Integer getIsControl(){
	return isControl;
    }

    public Integer getIsDefault(){
	return isDefault;
    }

    public void setId(Integer id) {this.id = id;}

    public void setExperimentGroupId(Integer experimentGroupId) {this.experimentGroupId = experimentGroupId;}

    public void setCreatedAt(String createdAt) {this.createdAt = createdAt;}

    public void setUpdatedAt(String updatedAt) {this.updatedAt = updatedAt;}

    @Override
    public String toString(){
	return (id) + ","
			+ "'" + name + "'" + ","
			+ allocation + ","
			+ isControl + ","
			+ active + ","
			+ isDefault + ","
			+ experimentGroupId + ","
			+ "'" + createdAt + "'" + ","
			+ "'" + updatedAt + "'";
    }

}
