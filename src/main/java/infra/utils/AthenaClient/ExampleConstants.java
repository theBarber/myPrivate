package infra.utils.AthenaClient;

public class ExampleConstants {

    public static final int CLIENT_EXECUTION_TIMEOUT = 100000;
    public static final String ATHENA_OUTPUT_BUCKET = "s3://undertone-staging-data";
    // This is querying a table created by the getting started tutorial in Athena
    public static final String ATHENA_SAMPLE_QUERY = "select * from dl_raw_data_stg.fact_uas_requests limit 10;";
    public static final long SLEEP_AMOUNT_IN_MS = 1000;
    public static final String ATHENA_DEFAULT_DATABASE = "default";

}