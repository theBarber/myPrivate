package entities;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public class HardCodedCampaignManager extends CampaignManager {

	private ObjectMapper m = new ObjectMapper();
	final private String LINEITEM_FILE = "/input_files/lineItem.json";
	final private String ZONESET_FILE = "/input_files/zoneSet.json";
	
	public HardCodedCampaignManager() {
		super();
		m.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		initHardCodedEntities();
	}

	public void initHardCodedEntities() {
		initLineItem();
		initZoneSets();
	}

	public void initLineItem() {
		try {
			this.io =  Arrays.asList(m.readValue(this.getClass().getResourceAsStream(LINEITEM_FILE), IO[].class));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();

		}
	}	
	
	public void initZoneSets() {
		try {
			this.zonesets =  new ArrayList<>(Arrays.asList(m.readValue(this.getClass().getResourceAsStream(ZONESET_FILE), ZoneSet[].class)));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
