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

    String append_entities = "";
    List<IO> io;
    List<ZoneSet> zonesets;
    private ObjectMapper m = new ObjectMapper();
    final private String INIT_LINEITEM_FILE = "/input_files/lineItem.json";
    final private String INIT_ZONESET_FILE = "/input_files/zoneSet.json";
    final private String CREATED_LINEITEM_FILE = "/input_files/createdlineItem.json";
    final private String CREATED_ZONESET_FILE = "/input_files/createdzoneSet.json";
    private String envname = "";


    public CampaignManager(String env, String append_entities) {
        if (envname.isEmpty()) {
            envname = env;
        }
        if (this.append_entities.isEmpty()) {
            this.append_entities = append_entities;
        }
        m.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        initHardCodedEntities();
    }

    private void initHardCodedEntities() {
        if (this.append_entities.equals("true")) {
            initLineItemFromS3();
            initZoneSetsFromS3();
        } else {
            initLineItem();
            initZoneSets();
        }
    }

    private void initLineItemFromS3() {
        try {
            this.io = Arrays.asList(m.readValue(S3Client.getInstance(Regions.US_WEST_2).readFile("ramp-delievery-qa/qa/ramp-lift-automation/" + envname + "/createdlineItem.json"), IO[].class));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private void initZoneSetsFromS3() {
        try {
            this.zonesets = new ArrayList<>(Arrays.asList(m.readValue(S3Client.getInstance(Regions.US_WEST_2).readFile("ramp-delievery-qa/qa/ramp-lift-automation/" + envname + "/createdzoneSet.json"), ZoneSet[].class)));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private void initLineItem() {
        try {
            this.io = Arrays.asList(m.readValue(this.getClass().getResourceAsStream(INIT_LINEITEM_FILE), IO[].class));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();

        }
    }

    private void initZoneSets() {
        try {
            this.zonesets = new ArrayList<>(Arrays.asList(m.readValue(this.getClass().getResourceAsStream(INIT_ZONESET_FILE), ZoneSet[].class)));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }


    public Optional<LineItem> getLineItem(Integer LineItemID) {
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

    public List<ZoneSet> getZonesets() {
        return zonesets;
    }

    public Optional<ZoneSet> getZoneset(Integer byId) {
        return zonesets.stream().filter(WithId.idIs(byId)).findFirst();
    }

    public Optional<ZoneSet> getZoneset(String byName) {
        return zonesets.stream().filter(Named.nameIs(byName)).findFirst();
    }

    public Optional<IO> getIO(Integer byId) {
        return io.stream().filter(WithId.idIs(byId)).findFirst();
    }


    public void insertCampaignToIOMapOld(Campaign campaign, Integer lineItemID, Integer io_id) {
        Optional<IO> io_O;
        Optional<LineItem> li_O;

        if (getCampaign(campaign.getName()).isPresent())
            throw new AssertionError("campaign is already exist!");
        else if ((li_O = getLineItem(lineItemID)).isPresent())
            li_O.get().addCampaign(campaign);
        else {
            LineItem li = new LineItem(lineItemID);
            li.addCampaign(campaign);
            if ((io_O = getIO(io_id)).isPresent())
                io_O.get().addLineItem(li);
            else {
                IO io = new IO(io_id);
                io.addLineItem(li);
                this.io = new ArrayList<>(this.io);
                this.io.add(io);
            }
        }
    }

    public void insertCampaignToIOMap(Campaign campaign, Integer lineItemID, Integer io_id) {
        IO io;
        LineItem li;

        //figure if io exists
        if (getIO(io_id).isPresent())
            io = getIO(io_id).get();
        else {
            io = new IO(io_id);
        }

        //figure if li exists
        if (getLineItem(lineItemID).isPresent())
            li = getLineItem(lineItemID).get();
        else
            //if not - create
            li = new LineItem(lineItemID);

        //figure if campaign exists, delete it and add new one
        if (getCampaign(campaign.getName()).isPresent())
            removeCampaignFromIOMap(campaign, li);

        li.addCampaign(campaign);
        io.addLineItem(li);

        this.io = new ArrayList<>(this.io);
        this.io.add(io);
    }


    private void removeCampaignFromIOMap(Campaign campaign, LineItem li) {
        System.out.println("Campaign already exists. Deleting...");
        li.removeCampaign(campaign);
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
            //****** change data for zoneset too *******
            case "zoneset":
                return this::getZoneset;
            //*********************************
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

    public void writeZoneSets(String env) {
        try {
            m.writeValue(new File(this.getClass().getResource(CREATED_ZONESET_FILE).toURI()), this.zonesets);
            ClassLoader loader = CampaignManager.class.getClassLoader();
            String basePath = loader.getResource(".").getPath();
            if (FileSystems.getDefault().getClass().getSimpleName().equals("WindowsFileSystem")) {
                basePath = basePath.substring(1);
            }
            S3Client.getInstance(Regions.US_WEST_2).putObject("ramp-delievery-qa", basePath + CREATED_ZONESET_FILE, "qa/ramp-lift-automation/" + env + "/tamar/createdzoneSet.json");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public void writeLineItem(String env) {
        try {
            m.writeValue(new File(this.getClass().getResource(CREATED_LINEITEM_FILE).toURI()), this.io);
            ClassLoader loader = CampaignManager.class.getClassLoader();
            String basePath = loader.getResource(".").getPath();
            if (FileSystems.getDefault().getClass().getSimpleName().equals("WindowsFileSystem")) {
                basePath = basePath.substring(1);
            }
            S3Client.getInstance(Regions.US_WEST_2).putObject("ramp-delievery-qa", basePath + CREATED_LINEITEM_FILE, "qa/ramp-lift-automation/" + env + "/tamar/createdlineItem.json");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

}