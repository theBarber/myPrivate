package infra.utils.AthenaClient;

public class ExampleConstants {

    public static final int CLIENT_EXECUTION_TIMEOUT = 100000;
    public static final String ATHENA_OUTPUT_BUCKET = "s3://aws-athena-query-results-895985361002-us-east-1";
    // This is querying a table created by the getting started tutorial in Athena
//    public static final String ATHENA_SAMPLE_QUERY = "select * from dl_raw_data.fact_dam_requests limit 10;";
    public static final String ATHENA_SAMPLE_QUERY = "select request_id, experiment_id, max(request_time_ms) " +
            "FROM dl_raw_data.fact_dam_requests where request_id='meow' and request_time_ms > date_parse('2019-09-11', '%Y-%m-%d') group by request_id limit 10;";
    public static final long SLEEP_AMOUNT_IN_MS = 1000;
    public static final String ATHENA_DEFAULT_DATABASE = "default";

}