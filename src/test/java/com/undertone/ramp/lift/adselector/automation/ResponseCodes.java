package com.undertone.ramp.lift.adselector.automation;

import com.undertone.ramp.lift.uas.automation.UASRequestModule;
import cucumber.api.java8.En;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.hamcrest.Matchers;
import org.junit.Assert;

import java.util.concurrent.CompletableFuture;
import java.util.function.BiConsumer;

/**
 * Created by assafm on 31/10/2016.
 */
public interface ResponseCodes {

    default public void ThenResposeCodeIs(){
        if (this instanceof En){
            ((En)this).Then("^The response code is (\\d+)$", this::allResponsesHaveCode);
        }
    }
    default public void allResponsesHaveCode(Integer expectedResponseCode) {
        getUas().responses().map(f -> f.thenApply(HttpResponse::getStatusLine).thenApply(StatusLine::getStatusCode)
                .whenComplete(assertThatResponseCodeIs(expectedResponseCode))).forEach(CompletableFuture::join);
    }


    default public BiConsumer<Integer, Throwable> assertThatResponseCodeIs(int expected) {
        return (statuscode, failure) -> {
            if (failure != null) {
                com.undertone.automation.assertion.Assert.fail("unable to get response", failure);
                return;
            }
            Assert.assertThat(statuscode, Matchers.is(expected));
        };
    }
    default public UASRequestModule getUas(){
    if (this instanceof BaseTest) {
        return ((BaseTest)this).uas.get();
    } else {
        throw new ClassCastException();
    }
}

}
