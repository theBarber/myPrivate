package steps;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import infra.utils.SqlWorkflowUtils;

import org.junit.runner.RunWith;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.concurrent.atomic.LongAdder;

import static org.junit.Assert.fail;

import entities.ramp.models.Experiment;
import entities.ramp.models.ExperimentGroup;
import ramp.lift.uas.automation.SystemUnderTest;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@RunWith(Cucumber.class)
public class NDQFiltering2Test extends BaseTest {
    public static  Integer testID = 53;



}
