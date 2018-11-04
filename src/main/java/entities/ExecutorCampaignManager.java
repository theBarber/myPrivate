package entities;

import com.amazonaws.regions.Regions;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import entities.ramp.app.api.Creative;
import infra.ParameterProvider;
import infra.module.Named;
import infra.module.WithId;
import ramp.lift.common.S3Client;

import java.io.File;
import java.nio.file.FileSystems;
import java.util.*;
import java.util.function.Function;


public class ExecutorCampaignManager implements ParameterProvider<WithId<Integer>> {

	List<IO> io;
	List<ZoneSet> zonesets;
    private ObjectMapper m = new ObjectMapper();

    public ExecutorCampaignManager() {
		m.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		initHardCodedEntities();
	}



	/*public LineItem addNewLineItem(Integer io_id, Integer lineItemID)
	{
		if(io.stream().flatMap(x -> x.lineItems()).filter(WithId.idIs(lineItemID)).findFirst().isPresent())
			return null;
		else
			io.stream().filter(WithId.idIs(io_id)).findFirst().

	}*/

    private void initHardCodedEntities() {
        initLineItemFromS3();
        initZoneSetsFromS3();
    }

	private void initLineItemFromS3() {
        try {
            this.io =  Arrays.asList(m.readValue(S3Client.getInstance(Regions.US_WEST_2).readFile("ramp-delievery-qa/qa/ramp-lift-automation/createdlineItem.json"), IO[].class));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();

        }

	}

	private void initZoneSetsFromS3() {
        try {
            this.zonesets =  new ArrayList<>(Arrays.asList(m.readValue(S3Client.getInstance(Regions.US_WEST_2).readFile("ramp-delievery-qa/qa/ramp-lift-automation/createdzoneSet.json"), ZoneSet[].class)));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
	}
//
//	private void initLineItem() {
//        try {
//            this.io =  Arrays.asList(m.readValue(this.getClass().getResourceAsStream(INIT_LINEITEM_FILE), IO[].class));
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//            e.printStackTrace();
//
//        }
//    }
//
//    private void initZoneSets() {
//        try {
//            this.zonesets =  new ArrayList<>(Arrays.asList(m.readValue(this.getClass().getResourceAsStream(INIT_ZONESET_FILE), ZoneSet[].class)));
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//            e.printStackTrace();
//        }
//    }


    public Optional<LineItem> getLineItem(Integer LineItemID)
	{
		return io.stream().flatMap(x -> x.lineItems()).filter(WithId.idIs(LineItemID)).findFirst();
	}

	public Optional<Campaign> getCampaign(String byName) {

	  return io.stream().flatMap(x -> x.lineItems()).flatMap(li -> li.campaigns.stream().filter(Named.nameIs(byName))).findFirst();
	}

	public final Optional<Zone> getZone(String byName) {
		return zonesets.stream().flatMap(ZoneSet::zones).filter(Named.nameIs(byName)).findFirst();
	}

	public Optional<Banner> getBanner(String byName) {
		return io.stream().flatMap(x -> x.lineItems()).flatMap(li -> li.campaigns.stream().flatMap(Campaign::banners).filter(Named.nameIs(byName))).findFirst();
	}

	public List<ZoneSet> getZonesets()
	{
		return zonesets;
	}

	public Optional<ZoneSet> getZoneset(Integer byId) {
		return zonesets.stream().filter(WithId.idIs(byId)).findFirst();
	}

	public Optional<ZoneSet> getZoneset(String byName) {
		return zonesets.stream().filter(Named.nameIs(byName)).findFirst();
	}

	public Optional<IO> getIO(Integer byId)
	{
		return io.stream().filter(WithId.idIs(byId)).findFirst();
	}


	public void insertCampaignToIOMap(Campaign campaign, Integer lineItemID, Integer io_id) {
		Optional<IO> io_O;
    	Optional<LineItem> li_O;

    	if(getCampaign(campaign.getName()).isPresent())
    		throw new AssertionError("campaign is already exist!");
    	else if((li_O = getLineItem(lineItemID)).isPresent())
			li_O.get().addCampaign(campaign);
    	else
    	{
    		LineItem li = new LineItem(lineItemID);
    		li.addCampaign(campaign);
			if((io_O = getIO(io_id)).isPresent())
				io_O.get().addLineItem(li);
			else{
				IO io = new IO(io_id);
				io.addLineItem(li);
				this.io = new ArrayList<>(this.io);
				this.io.add(io);
			}
		}
	}


	@Override
	public Function<String, Optional<? extends WithId<Integer>>> getterFor(String entityType) {
		switch (entityType.toLowerCase()) {
		case "banner":
			return this::getBanner;
		case "campaign":
			return this::getCampaign;
		case "zone":
			return this::getZone;
		default:
			return noSuchEntity -> Optional.empty();
		}
	}

	@Override
	public String stringify(WithId<Integer> t) {
		return Objects.toString(t.getId());
	}

	@Override
	public String className() {
		return "workflow";
	}


    public Optional<Creative> getCreative(String byName) {
		return io.stream().flatMap(x -> x.creatives.stream()).filter(Named.nameIs(byName)).findFirst();
    }

	public Optional<Deal> getDeal(String byName) {
		return io.stream().flatMap(x -> x.deals.stream()).filter(Named.nameIs(byName)).findFirst();
	}

}