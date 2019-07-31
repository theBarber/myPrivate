package steps;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.apache.commons.codec.binary.Hex;
import org.junit.runner.RunWith;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


@RunWith(Cucumber.class)
    @CucumberOptions(features = "classpath:Wurfl.feature", plugin = {"pretty",})
//            "infra.RotatingJSONFormatter:target/cucumber/Wurfl_$TIMESTAMP$.json"})
    public class WurflTest extends BaseTest {
        public WurflTest(){
            super();
        }

    }




