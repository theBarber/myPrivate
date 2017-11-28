package steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.RampAppCreateEntitiesManager;
import entities.Zone;
import entities.ZoneSet;
import infra.utils.SqlWorkflowUtils;
import org.apache.commons.io.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.runner.RunWith;

import java.io.*;
import java.util.TreeSet;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import entities.RampAppCreateEntitiesManager;
import entities.Zone;
import entities.ZoneSet;
import entities.ramp.app.api.CampaignsRequest;
import entities.ramp.app.api.Zonesets;
import infra.utils.SqlWorkflowUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.junit.runner.RunWith;

import java.util.*;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:HeaderBidding.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/HeaderBidding_$TIMESTAMP$.json"})
public class HeaderBiddingTest extends BaseTest{
    private ObjectMapper mapper = new ObjectMapper();
    private entities.RampAppCreateEntitiesManager RampAppCreateEntitiesManager;
    private List<String> testScenarios;
    private static final String HBInputFilePath = "input_files/HBInput.xlsx";
    private String url = "";
    private String HBrequestBody = "";
    private String HBresponse= "";
    private String testType = "";
    public HeaderBiddingTest()
    {
        super();
        testScenarios = new ArrayList<String>();
        Before(HEADERBIDDING, (scenario) -> {
            RampAppCreateEntitiesManager = sut.getRampAppCreateEntitiesManager();
        });

        Given("i load scenario \\{([^}]+)\\} input data",this::readInputDataFromCSV);
        Then("i send (\\d+) times Header Bidding ad request to UAS for the scenario",this::sendHeaderBiddingRequestsToUAS);
    }

    private void sendHeaderBiddingRequestsToUAS(Integer times)
    {
       try {
           sut.getUASRquestModule().sendMultipleHeaderBiddingRequests(times,url,HBrequestBody,HBresponse,testType,true);
       } catch (IOException e) {
           e.printStackTrace();
       }
    }

    private void readInputDataFromCSV(String scenario)
    {
        try {
            ClassLoader loader = HeaderBiddingTest.class.getClassLoader();
            FileInputStream excelFile = new FileInputStream(new File(loader.getResource(".").getPath(),HBInputFilePath));
            Workbook workbook = new XSSFWorkbook(excelFile);
            DataFormatter formatter = new DataFormatter();
            Sheet datatypeSheet = workbook.getSheetAt(0);
            Iterator<Row> iterator = datatypeSheet.iterator();

            while (iterator.hasNext()) {
                Row currentRow = iterator.next();
                //getCellTypeEnum shown as deprecated for version 3.15
                //getCellTypeEnum ill be renamed to getCellType starting from version 4.0
                String src = formatter.formatCellValue(currentRow.getCell(0)).toString().trim();
                String dest = scenario.trim();
                if(src.contentEquals(dest)) {// we found the row for relevant scenario
                    testType = formatter.formatCellValue(currentRow.getCell(7));
                    if (testType.contentEquals("No")) {
                        url = "http://" + formatter.formatCellValue(currentRow.getCell(1)) + "/hb?pid=" + formatter.formatCellValue(currentRow.getCell(2)) + "&domain=" + formatter.formatCellValue(currentRow.getCell(3)) + "&optimize=" + formatter.formatCellValue(currentRow.getCell(6));
                        HBrequestBody = formatter.formatCellValue(currentRow.getCell(4));
                        HBresponse = formatter.formatCellValue(currentRow.getCell(5));
                        break;
                    }
                    else //component testing
                    {
                        url = "http://" + formatter.formatCellValue(currentRow.getCell(1));
                        HBrequestBody = formatter.formatCellValue(currentRow.getCell(4));
                        HBresponse = formatter.formatCellValue(currentRow.getCell(5));
                    }
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
