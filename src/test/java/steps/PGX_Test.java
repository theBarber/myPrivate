package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import org.junit.Assert;
import org.junit.runner.RunWith;
import ramp.lift.uas.automation.UASRequestModule;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import static org.hamcrest.Matchers.isIn;
import static org.hamcrest.Matchers.not;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:PGXTest.feature", plugin = {"pretty",
        "infra.RotatingJSONFormatter:target/cucumber/PGX_$TIMESTAMP$.json"})
public class PGX_Test extends BaseTest{

    public PGX_Test()
    {
        super();
        Then("response value \\{([^}]+)\\} is one of (.*)$", this::responseContainsOneOf);
        Then("response value \\{([^}]+)\\} has the values of (.*)$", this::responseHasValuesOf);

    }

    public void responseContainsOneOf(String key,String value)
    {
        final String myKey = key + "=";
        List<String> valueAsStringArray = Arrays.asList(value.split(";"));

        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            String val = getKey(content,myKey);
            Assert.assertThat(val,isIn(valueAsStringArray));
        });
    }

    public void responseHasValuesOf(String key,String value)
    {
        final String myKey = key + "=";
        List<String> valueAsStringArray = Arrays.asList(value.split(","));
        sut.getUASRquestModule().responses().map(CompletableFuture::join).map(UASRequestModule::getContentOf).forEach(content -> {
            String val = getKey(content,myKey);
            valueAsStringArray.forEach(v->
                    Assert.assertThat(val,Matchers.containsString(v))
            );
        });
    }

    private String getKey(String content,String key) {
        Assert.assertThat("response not contains "+ key, Matchers.containsString(key));
        String str = content.substring(content.indexOf(key));
        return content.substring(content.indexOf(key)+key.length(),content.indexOf(key) + str.indexOf(';'));
    }

}
