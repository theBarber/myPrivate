package infra.utils.AthenaClient;

import com.amazonaws.services.athena.AmazonAthena;
import com.amazonaws.services.athena.model.*;

import java.util.List;

public class AthenaUtils {

    /**
     * Submits a sample query to Athena and returns the execution ID of the query.
     */
    public static String submitAthenaQuery(AmazonAthena athenaClient, String query)
    {
        // The QueryExecutionContext allows us to set the Database.
        QueryExecutionContext queryExecutionContext = new QueryExecutionContext().withDatabase(ExampleConstants.ATHENA_DEFAULT_DATABASE);

        // The result configuration specifies where the results of the query should go in S3 and encryption options
        ResultConfiguration resultConfiguration = new ResultConfiguration()
                // You can provide encryption options for the output that is written.
                // .withEncryptionConfiguration(encryptionConfiguration)
                .withOutputLocation(ExampleConstants.ATHENA_OUTPUT_BUCKET);

        // Create the StartQueryExecutionRequest to send to Athena which will start the query.
        StartQueryExecutionRequest startQueryExecutionRequest = new StartQueryExecutionRequest()
                .withQueryString(query)
                .withQueryExecutionContext(queryExecutionContext)
                .withResultConfiguration(resultConfiguration);

        StartQueryExecutionResult startQueryExecutionResult = athenaClient.startQueryExecution(startQueryExecutionRequest);
        return startQueryExecutionResult.getQueryExecutionId();
    }

    /**
     * Wait for an Athena query to complete, fail or to be cancelled. This is done by polling Athena over an
     * interval of time. If a query fails or is cancelled, then it will throw an exception.
     */

    public static void waitForQueryToComplete(AmazonAthena athenaClient, String queryExecutionId) throws InterruptedException
    {
        GetQueryExecutionRequest getQueryExecutionRequest = new GetQueryExecutionRequest()
                .withQueryExecutionId(queryExecutionId);

        GetQueryExecutionResult getQueryExecutionResult = null;
        boolean isQueryStillRunning = true;
        while (isQueryStillRunning) {
            getQueryExecutionResult = athenaClient.getQueryExecution(getQueryExecutionRequest);
            String queryState = getQueryExecutionResult.getQueryExecution().getStatus().getState();
            if (queryState.equals(QueryExecutionState.FAILED.toString())) {
                throw new RuntimeException("Query Failed to run with Error Message: " + getQueryExecutionResult.getQueryExecution().getStatus().getStateChangeReason());
            }
            else if (queryState.equals(QueryExecutionState.CANCELLED.toString())) {
                throw new RuntimeException("Query was cancelled.");
            }
            else if (queryState.equals(QueryExecutionState.SUCCEEDED.toString())) {
                isQueryStillRunning = false;
            }
            System.out.println("Current Status is: " + queryState);
        }
    }

    /**
     * This code calls Athena and retrieves the results of a query.
     * The query must be in a completed state before the results can be retrieved and
     * paginated. The first row of results are the column headers.
     */
    public static void processResultRows(AmazonAthena athenaClient, String queryExecutionId)
    {
        GetQueryResultsRequest getQueryResultsRequest = new GetQueryResultsRequest()
                // Max Results can be set but if its not set,
                // it will choose the maximum page size
                // As of the writing of this code, the maximum value is 1000
                .withMaxResults(1000)
                .withQueryExecutionId(queryExecutionId);

        GetQueryResultsResult getQueryResultsResult = athenaClient.getQueryResults(getQueryResultsRequest);
        List<ColumnInfo> columnInfoList = getQueryResultsResult.getResultSet().getResultSetMetadata().getColumnInfo();

        while (true) {
            List<Row> results = getQueryResultsResult.getResultSet().getRows();
            for (Row row : results) {
                // Process the row. The first row of the first page holds the column names.
                processRow(row, columnInfoList);
            }
            // If nextToken is null, there are no more pages to read. Break out of the loop.
            if (getQueryResultsResult.getNextToken() == null) {
                break;
            }
            getQueryResultsResult = athenaClient.getQueryResults(
                    getQueryResultsRequest.withNextToken(getQueryResultsResult.getNextToken()));
        }
    }


    public static boolean processResultRowsContains(AmazonAthena athenaClient, String queryExecutionId, String value)
    {
        GetQueryResultsRequest getQueryResultsRequest = new GetQueryResultsRequest()
                // Max Results can be set but if its not set,
                // it will choose the maximum page size
                // As of the writing of this code, the maximum value is 1000
                //.withMaxResults(1000)
                .withQueryExecutionId(queryExecutionId);

        GetQueryResultsResult getQueryResultsResult = athenaClient.getQueryResults(getQueryResultsRequest);
        List<ColumnInfo> columnInfoList = getQueryResultsResult.getResultSet().getResultSetMetadata().getColumnInfo();

        while (true) {
            List<Row> results = getQueryResultsResult.getResultSet().getRows();
            for (Row row : results) {
                // Process the row. The first row of the first page holds the column names.
                if(row.toString().contains(value))
                    return true;
                processRow(row, columnInfoList);
            }
            // If nextToken is null, there are no more pages to read. Break out of the loop.
            if (getQueryResultsResult.getNextToken() == null) {
                break;
            }
            getQueryResultsResult = athenaClient.getQueryResults(
                    getQueryResultsRequest.withNextToken(getQueryResultsResult.getNextToken()));
        }
        return false;
    }

    private static void processRow(Row row, List<ColumnInfo> columnInfoList)
    {   System.out.println(row);
        for (int i = 0; i < columnInfoList.size(); ++i) {
            switch (columnInfoList.get(i).getType()) {
                case "varchar":
                    // Convert and Process as String
                    break;
                case "tinyint":
                    // Convert and Process as tinyint
                    break;
                case "smallint":
                    // Convert and Process as smallint
                    break;
                case "integer":
                    // Convert and Process as integer
                    break;
                case "bigint":
                    // Convert and Process as bigint
                    break;
                case "double":
                    // Convert and Process as double
                    break;
                case "boolean":
                    // Convert and Process as boolean
                    break;
                case "date":
                    // Convert and Process as date
                    break;
                case "timestamp":
                    // Convert and Process as timestamp
                    break;
                default:
                    throw new RuntimeException("Unexpected Type is not expected" + columnInfoList.get(i).getType());
            }
        }
    }

    public static boolean testAthena(String query, String valueToBeRetrieved){

        // Build an AmazonAthena client
        AthenaClientFactory factory = new AthenaClientFactory();
        AmazonAthena athenaClient = factory.createClient();

        String queryExecutionId = submitAthenaQuery(athenaClient, query);

        try {
            waitForQueryToComplete(athenaClient, queryExecutionId);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

//        processResultRows(athenaClient, queryExecutionId);
        return processResultRowsContains(athenaClient, queryExecutionId, valueToBeRetrieved);

    }



}
