package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)

@CucumberOptions(features = "@target/rerun.txt", plugin = {"rerun:target/rerun.txt"})

public class FailedRunner {}