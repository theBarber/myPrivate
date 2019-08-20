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


public class CampaignManager implements ParameterProvider<WithId<Integer>> {

	String remote="";
	List<IO> io;
	List<ZoneSet> zonesets;
    private ObjectMapper m = new ObjectMapper();
    final private String INIT_LINEITEM_FILE = "/input_files/lineItem.json";
    final private String INIT_ZONESET_FILE = "/input_files/zoneSet.json";
    final private String CREATED_LINEITEM_FILE = "/input_files/createdlineItem.json";
    final private String CREATED_ZONESET_FILE = "/input_files/createdzoneSet.json";
    private String envname = "";



    public CampaignManager(String env) {
		if(envname.isEmpty()){
			envname=env;
		}
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
    	if(remote.equals("true")){
			initLineItemFromS3();
			initZoneSetsFromS3();
		}
        initLineItem();
        initZoneSets();
    }

	private void initLineItemFromS3() {
        try {
            this.io =  Arrays.asList(m.readValue(S3Client.getInstance(Regions.US_WEST_2).readFile("ramp-delievery-qa/qa/ramp-lift-automation/"+ envname + "/lineItem.json"), IO[].class));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();

        }

	}

	private void initZoneSetsFromS3() {
        try {
            this.zonesets =  new ArrayList<>(Arrays.asList(m.readValue(S3Client.getInstance(Regions.US_WEST_2).readFile("ramp-delievery-qa/qa/ramp-lift-automation/"+ envname + "/zonesets.json"), ZoneSet[].class)));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
	}

	private void initLineItem() {
        try {
            this.io =  Arrays.asList(m.readValue(this.getClass().getResourceAsStream(INIT_LINEITEM_FILE), IO[].class));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();

        }
    }

    private void initZoneSets() {
        try {
            this.zonesets =  new ArrayList<>(Arrays.asList(m.readValue(this.getClass().getResourceAsStream(INIT_ZONESET_FILE), ZoneSet[].class)));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }


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




	// this is not javadoc, comment out
	/*
	 * get a zone that may result with the given campaign
	 * 
	 * @param forCampaignId
	 *            the {@link Campaign#getId()}
	 * @param byName
	 *            the name of the zone
	 * @return
	 */
	// public Optional<Zone> getZone(Integer forCampaignId, String byName) {
	// return
	// campaigns.stream().filter(WithId.idIs(forCampaignId)).flatMap(Campaign::getZoneSetAssoc)
	// .flatMap(ZoneSet::zones).filter(Optional.ofNullable(byName).map(Named::nameIs).orElse(b
	// -> true))
	// .findFirst();
	// }
//
//	/**
//	 * Create a new {@link Campaign}
//	 * 
//	 * @param name
//	 *            the name
//	 * @param id
//	 *            the id
//	 * @return the newly created campaign
//	 */
//	protected Campaign createCampaign(String name, Integer id) {
//		return createCampaign(name, id, Function.identity());
//	}

//	/**
//	 * Create a new {@link Campaign}
//	 * 
//	 * @param name
//	 *            the name
//	 * @param id
//	 *            the id
//	 * @param campaignEnricher
//	 *            a function that converts a campaign to a better one
//	 * @return the newly created campaign
//	 */
//	protected <C extends Campaign> C createCampaign(String name, Integer id, Function<Campaign, C> campaignEnricher) {
//		campaigns.stream().filter(WithId.idIs(id)).findFirst().ifPresent(c -> {
//			throw new IllegalArgumentException(
//					"campaign " + c.toString() + " with id " + c.getId() + " already exists");
//		});
//		C res;
//		campaigns.add(requireNonNull(res = requireNonNull(campaignEnricher).apply(new Campaign(name, id))));
//		return res;
//	}
//
//	/**
//	 * create a banner and add it to the campaign
//	 * 
//	 * @param name
//	 *            the name of the banner
//	 * @param id
//	 *            the id of the banner
//	 * @param forCampaignId
//	 *            the campaign to create the banner for
//	 * @return The created (and enriched) banner
//	 */
//	protected Optional<Banner> createBanner(String name, Integer id, Integer forCampaignId) {
//		return createBanner(name, id, forCampaignId, identity());
//	}
//
//	/**
//	 * create a banner and add it to the campaign
//	 * 
//	 * @param name
//	 *            the name of the banner
//	 * @param id
//	 *            the id of the banner
//	 * @param forCampaignId
//	 *            the campaign to create the banner for
//	 * @param bannerEnricher
//	 *            a function that converts a banner to a better one
//	 * @param creativeId
//	 * @return The created (and enriched) banner
//	 */
//	protected <B extends Banner> Optional<B> createBanner(String name, Integer id, Integer forCampaignId,
//			Function<Banner, B> bannerEnricher) {
//		return campaigns.stream().filter(idIs(forCampaignId)).findFirst()
//				.map(c -> c.addBanner(bannerEnricher.apply(new Banner(name, id))));
//	}

	// protected Optional<ZoneSet> createZoneSet(String name, Integer id,
	// Integer forCampaignId) {
	// return campaigns.stream().filter(idIs(forCampaignId)).findFirst().map(c
	// -> c.addZoneSet(new ZoneSet(name, id)));
	// }

	// protected Optional<Zone> createZone(String name, Integer id, Integer
	// forZoneSetId) {
	// return createZone(name, id, forZoneSetId, identity());
	// }

	// protected <Z extends Zone> Optional<Z> createZone(String name, Integer
	// id, Integer forZoneSetId,
	// Function<Zone, Z> zoneEnricher) {
	// return
	// campaigns.stream().flatMap(Campaign::getZoneSetAssoc).filter(idIs(forZoneSetId)).findFirst()
	// .map(zs -> zs.addZone(requireNonNull(zoneEnricher).apply(new Zone(name,
	// id))));
	// }

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

	public void writeZoneSets(String env){
	    try{
	        m.writeValue(new File(this.getClass().getResource(CREATED_ZONESET_FILE).toURI()),zonesets);
            ClassLoader loader = CampaignManager.class.getClassLoader();
            String basePath = loader.getResource(".").getPath();
            if (FileSystems.getDefault().getClass().getSimpleName().equals("WindowsFileSystem")) {
                basePath = basePath.substring(1);
            }
            S3Client.getInstance(Regions.US_WEST_2).putObject("ramp-delievery-qa",basePath + CREATED_ZONESET_FILE,"qa/ramp-lift-automation/"+ env +"/createdzoneSet.json");
        }catch (Exception e){
	        System.out.println(e.getMessage());
	        e.printStackTrace();
        }
    }

    public void writeLineItem(String env){
        try{
            m.writeValue(new File(this.getClass().getResource(CREATED_LINEITEM_FILE).toURI()),io);
            ClassLoader loader = CampaignManager.class.getClassLoader();
            String basePath = loader.getResource(".").getPath();
            if (FileSystems.getDefault().getClass().getSimpleName().equals("WindowsFileSystem")) {
                basePath = basePath.substring(1);
            }
            S3Client.getInstance(Regions.US_WEST_2).putObject("ramp-delievery-qa",basePath + CREATED_LINEITEM_FILE,"qa/ramp-lift-automation/"+ env +"/createdlineItem.json");
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

}
