package entities;

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
		this.li = initLineItem();
		this.zoneset = initZoneSet();
	}

	public LineItem initLineItem() {
		try {
			return m.readValue(ClassLoader.class.getResourceAsStream(LINEITEM_FILE), LineItem.class);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();

		}
		return li;
	}	
	
	public ZoneSet initZoneSet() {
		try {
			return m.readValue(ClassLoader.class.getResourceAsStream(ZONESET_FILE), ZoneSet.class);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return zoneset;
	}
}
