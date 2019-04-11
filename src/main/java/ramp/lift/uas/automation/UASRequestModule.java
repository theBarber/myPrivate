package ramp.lift.uas.automation;

import com.fasterxml.jackson.databind.JsonNode;
import com.google.common.util.concurrent.ThreadFactoryBuilder;

import java.beans.IntrospectionException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.message.BasicHeader;
import infra.module.AbstractModuleImpl;
import org.apache.http.message.BasicNameValuePair;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;
public class UASRequestModule extends AbstractModuleImpl<List<CompletableFuture<HttpResponse>>> {

    public enum requestTypesEnum {
        ZONE, DYNAMIC_TAG, HEADER_BIDDING, WEL, PRF, EVE
    }

    private ExecutorService requestSubmitter;
    private static final String lettersDigitsAndHyphen = "[0-9a-zA-Z-+_,%/=()]";
    protected static final Pattern impressionURLPattern = Pattern
            .compile("(https?:\\/\\/([^:/?#]*(?::[0-9]+)?)\\/l[^?#]*\\?"
                    + lettersDigitsAndHyphen
                    + "*=" + lettersDigitsAndHyphen
                    + "*(&" + lettersDigitsAndHyphen
                    + "*=" + lettersDigitsAndHyphen + "*)*)");

    protected static final Pattern eventCompleteURLPattern = Pattern
            .compile(".*?complete.*?(complete)");

    protected static final Pattern eventMuteURLPattern = Pattern
            .compile(".*?mute.*?(mute)");

    protected static final Pattern clickURLPattern = Pattern
            .compile("(https?:\\/\\/[^:/?#]*(?::[0-9]+)?\\/c\\?[^\'\\\"]*)[\'\\\"]");

    protected static final Pattern dspURLPattern = Pattern
            .compile("(https?:\\/\\/[^:/?#]*(?::[0-9]+)?\\/ttj\\?[^\'\\\"]*)[\'\\\"]");

    private List<HttpResponse> synchronizedResponses;

    protected static final String getGroup1(Matcher from) {
        return from.group(1);
    }

    protected static final String getGroup2(Matcher from) {
        return from.group(2);
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String host) {
        this.domain = host;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    private String domain;
    private String port;
    private long withSleepInMillis = 10;
    protected CloseableHttpClient httpclient;

    public HttpClientContext getContext() {
        return context;
    }

    HttpClientContext context;
    List<Header> httpHeaders = new ArrayList<Header>();
    List<NameValuePair> queryParams = new ArrayList<>();

    public UASRequestModule() {
        setActual(new ArrayList<>());
        httpclient = HttpClients.custom()
                .setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(10000).build())
                .build();
        requestSubmitter = Executors.newFixedThreadPool(5, new ThreadFactoryBuilder()
                .setNameFormat("Ad request submitter").build());
        context = HttpClientContext.create();
        CookieStore cookieStore = new BasicCookieStore();
        context.setCookieStore(cookieStore);
        synchronizedResponses = new ArrayList<>();
    }

    public void zoneRequest(Integer forZone) {
        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/af?zoneid=" + forZone + "&ct=1&stid=999";
        request(url, true);
    }

    public void zoneRequests(Integer forZone, int times, boolean toReset) {
        if (toReset) {
            reset();
        }
        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/af?zoneid=" + forZone + "&ct=1&stid=999";
        System.out.println(url);
        for (; times > 0; times--) {
            try {
                TimeUnit.SECONDS.sleep(3);
            } catch (InterruptedException e) {
                fail(e.getMessage());
            }
            request(url, false);
        }
    }

    public void zoneRequestsWithParams(Integer forZone, int times, boolean toReset) {
        if (toReset) {
            reset();
        }

        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/af?zoneid=" + forZone + "&ct=1&stid=999";

        for (NameValuePair nvp : queryParams) {
            url = url + "&" + nvp.toString();
        }
        System.out.println(url);
        for (; times > 0; times--) {
            try {
                TimeUnit.SECONDS.sleep(3);
            } catch (InterruptedException e) {
                fail(e.getMessage());
            }
            request(url, false);
        }
    }

    public void zoneRequestsWithParameter(Integer forZone, String parameter, int times, boolean toReset) {
        if (toReset) {
            reset();
        }

        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/af?zoneid=" + forZone + "&ct=1&stid=999" + "&" + parameter;
        System.out.println(url);
        for (; times > 0; times--) {
            try {
                TimeUnit.SECONDS.sleep(3);
            } catch (InterruptedException e) {
                fail(e.getMessage());
            }
            request(url, false);


        }
    }

    public void zoneRequestsWithGeo(Integer forZone, int times, String params) {
        reset();
        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/af?zoneid=" + forZone + "&ct=1&stid=999" + "&sim_geo=1&" + params;

        for (; times > 0; times--) {
            request(url, false);
        }
    }

    public UASRequestModule thatSleeps(long millis) {
        this.withSleepInMillis = millis;
        return this;
    }

    public void healthCheckRequest() {

        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/health?stid=999";
        request(url, true);
    }

    public void healthCheckRequestSkip(String servicenameToSkip) {
        int skipFlag = 0xF;
        switch (servicenameToSkip) {
            case "RabbitMQ":
                skipFlag = 0b1110;
                break;
            case "Couchbase":
                skipFlag = 0b1101;
                break;
            case "Redis":
                skipFlag = 0b1011;
                break;
            case "Workflow":
                skipFlag = 0b0111;
                break;
        }
        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/health?stid=999&skip=" + skipFlag;
        request(url, true);
    }

    public void zoneCacheRequest(String action) {
        String url = "http://" + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + "/zonecache?action=" + action;
        request(url, true);
    }

    private void request(String url, boolean toReset) {
        if (toReset) {
            reset();
        }

        actual().add(CompletableFuture.supplyAsync(() -> {
            try {
                HttpGet get = new HttpGet(url);
                get.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
//        System.out.println("sending get request to UAS with url: "+url);
                HttpResponse response = httpclient.execute(get, context);
                response.setEntity(new BufferedHttpEntity(response.getEntity()));
                try {
                    if (withSleepInMillis > 0) {
                        Thread.sleep(withSleepInMillis);
                    }
                } catch (InterruptedException e) {
                    withSleepInMillis = 0;
                }
                return response;


            } catch (IOException e) {
                throw new UncheckedIOException("failed to send request (" + url + ") ", e);
            }
        }, requestSubmitter));
    }

    public Stream<CompletableFuture<HttpResponse>> responses() {
        return actual().stream();
    }

    public List<CompletableFuture<HttpResponse>> responsesAsList() {
        return actual();
    }

    public List<HttpResponse> getSynchronizedResponses() {
        return synchronizedResponses;
    }

    @Override
    public void init() throws Exception {
        super.init();
        reset();
    }

    public final void reset() {
        if (synchronizedResponses != null)
            synchronizedResponses.clear();
        this.actual().stream()
                .filter(((Predicate<Future<HttpResponse>>) Future::isDone).negate())
                .forEach(f -> f.cancel(true));

        this.actual().clear();
    }

    public void addHttpHeader(String name, String value) {
        httpHeaders.removeIf(header -> header.getName().equals(name));
        httpHeaders.add(new BasicHeader(name, value));
    }


    public List<Header> getHttpHeaders()
    {
        return httpHeaders;
    }

    public void emptyHttpHeaders() {
        httpHeaders.clear();
    }

    public static Optional<String> getImpressionUrlFrom(HttpResponse response) {
        return Optional.of(impressionURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
                .map(UASRequestModule::getGroup1);
    }

    public Optional<String> getImpressionUrl(String url) {
        return Optional.of(impressionURLPattern.matcher(url))
                .filter(Matcher::find)
                .map(UASRequestModule::getGroup1);
    }

    public static Optional<String> getClickUrlFrom(HttpResponse response) {
        return Optional.of(clickURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
                .map(UASRequestModule::getGroup1);
    }

    public static Optional<String> getCompleteUrlFrom(HttpResponse response) {
        return Optional.of(eventCompleteURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
                .map(UASRequestModule::getGroup1);
    }

    public static Optional<String> getMuteUrlFrom(HttpResponse response) {
        return Optional.of(eventMuteURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
                .map(UASRequestModule::getGroup1);
    }

    public static Optional<String> getdspUrlFrom(HttpResponse response) {
        return Optional.of(dspURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
                .map(UASRequestModule::getGroup1);
    }

    private static String getContentOf(CompletableFuture<HttpResponse> future) {
        return future.thenApply(UASRequestModule::getContentOf).join();
    }

    public static String getContentOf(HttpResponse response) {
        HttpEntity entity = response.getEntity();
        Header contentType = entity.getContentType();
        String contentCharsetName = Arrays.stream(contentType.getElements())
                .filter(he -> he.getName().equals("charset")).findFirst().map(HeaderElement::getValue)
                .filter(Charset::isSupported).orElse(Charset.defaultCharset().name());
        try (BufferedReader content = new BufferedReader(
                new InputStreamReader(entity.getContent(), contentCharsetName))) {
            return content.lines().collect(Collectors.joining(System.lineSeparator()));
        } catch (UnsupportedEncodingException e) {
            throw new UncheckedIOException(contentCharsetName + " charset not supported", e); // should'nt
        } catch (IOException cause) {
            throw new UncheckedIOException(cause);
        }
    }

    public void addQueryParam(String name, String value) {
        queryParams.removeIf(param -> param.getName().equals(name));
        queryParams.add(new BasicNameValuePair(name, value));
    }

    public void emptyQueryParams() {
        queryParams.clear();
    }

    public void addCookie(String key, String value) {
        BasicClientCookie cookie = new BasicClientCookie(key, value);
        cookie.setDomain(domain);
        cookie.setPath("/");
        context.getCookieStore().addCookie(cookie);
    }

    public void setGenericCookie() {
        clearCookies();
        BasicCookieStore cookie = new BasicCookieStore();
        context.setCookieStore(cookie);
    }

    public void clearCookies() {
        context.getCookieStore().clear();
    }

    private void sendMultipleGetRequestsToUAS(Integer times, String url, boolean isAsync) {
        System.out.println(url);
        if (isAsync)
            sendGetRequestsAsync(times, url,true);
        else
            sendGetRequestsSync(times, url);
    }

    private void sendMultiplePostRequestsToUAS(Integer times, String url, String body, boolean isAsync) {
        System.out.println(url);
        if (isAsync)
            sendPostRequestsAsync(times, url, body);
        else
            sendPostRequestSync(times, url, body);
    }

    public void sendMultipleTypeGetRequestWithParameter(String requestTypes, Integer times, String parameters, boolean isAsync, boolean isSecure) {
        String url = getURL(requestTypes, parameters, isSecure);
        sendMultipleGetRequestsToUAS(times, url, isAsync);
    }

    public void sendMultipleTypePostRequestWithParameter(String requestTypes,String body, Integer times, String parameters, boolean isAsync, boolean isSecure) {
        String url = getURL(requestTypes, parameters, false);
        sendMultiplePostRequestsToUAS(times, url, body, isAsync);
    }

    public void sendMultipleDynamicTagGetRequests(Integer times, String tagID, String publisherId, String domainParam, String extraParams, boolean isAsync, boolean isSecure) {
        String params = "pid=" + publisherId +  Optional.ofNullable(domainParam).map(s -> "&domain=" + s).orElse("")+ Optional.ofNullable(tagID).filter(s -> !s.isEmpty()).map(s -> "&tagid=" + s).orElse("") + Optional.ofNullable(extraParams).orElse("");
        String url = getURL("dynamicTag", params, isSecure);
        sendMultipleGetRequestsToUAS(times, url, isAsync);
    }

    public void sendMultipleHeaderBiddingPostRequests(Integer times, String body, Integer publisherID, String domainParam, String extraParams, boolean isAsync, boolean isSecure) {
        String params = "pid=" + publisherID + Optional.ofNullable(domainParam).map(s -> "&domain=" + s).orElse("") + Optional.ofNullable(extraParams).orElse("");
        String url = getURL("headerBidding", params, isSecure);
        sendMultiplePostRequestsToUAS(times, url, body, isAsync);
    }

    private String getURL(String RequestType, String params, boolean isSecure) {
        String request_type_in_string_format = null;
        String http = isSecure ? "https://" : "http://";
        switch (RequestType) {
            case "zone":
                request_type_in_string_format = "/af";
                break;
            case "dynamicTag":
                request_type_in_string_format = "/dj";
                break;
            case "headerBidding":
                request_type_in_string_format = "/hb";
                break;
            case "wel":
                request_type_in_string_format = "/t";
                break;
            case "prfLog":
                request_type_in_string_format = "/f";
                break;
            case "eve":
                request_type_in_string_format = "/e";
                break;
            case "profile":
                request_type_in_string_format = "/p";
                break;
        }
        assertNotNull("request type "+RequestType+" wasn't found",request_type_in_string_format);
        return http + domain + Optional.ofNullable(port).filter(s -> !s.isEmpty()).map(s -> ":" + s).orElse("") + request_type_in_string_format + Optional.ofNullable(params).filter(s -> !s.isEmpty()).map(s -> "?" + s).orElse("");
    }

    private void sendPostRequestsAsync(Integer times, String url, String body) {
        reset();
        for (; times > 0; times--) {
            actual().add(CompletableFuture.supplyAsync(() -> {
                return postRequest(url, body);
            }, requestSubmitter));
        }
    }



    public void sendGetRequestsAsync(Integer times, String url, Boolean toReset) {
        //System.out.println(url);
        if(toReset)
            reset();
        for (; times > 0; times--) {
            actual().add(CompletableFuture.supplyAsync(() -> {
                return getRequest(url);
            }, requestSubmitter));
        }
    }

    private void sendPostRequestSync(Integer times, String url, String body) {
        reset();
        for (; times > 0; times--) {
            synchronizedResponses.add(postRequest(url, body));
            try {
                TimeUnit.SECONDS.sleep(5);
            } catch (InterruptedException e) {
                fail(e.getMessage());
            }
        }
    }

    private void sendGetRequestsSync(Integer times, String url) {
        reset();
        for (; times > 0; times--) {

            synchronizedResponses.add(getRequest(url));
            try {
                TimeUnit.SECONDS.sleep(5);
            } catch (InterruptedException e) {
                fail(e.getMessage());
            }
        }
    }

    public HttpResponse getRequest(String url) {
        try {
            HttpGet get = new HttpGet(url);
            get.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
            HttpResponse response = httpclient.execute(get, context);
            response.setEntity(new BufferedHttpEntity(response.getEntity()));
            try {
                if (withSleepInMillis > 0) {
                    Thread.sleep(withSleepInMillis);
                }
            } catch (InterruptedException e) {
                withSleepInMillis = 0;
            }
            return response;
        } catch (IOException e) {
            throw new UncheckedIOException("failed to send request (" + url + ") ", e);
        }
    }

    private HttpResponse postRequest(String url, String body) {
        try {
            HttpPost post = new HttpPost(url);
            post.setHeaders(httpHeaders.toArray(new Header[httpHeaders.size()]));
            post.setEntity(new StringEntity(body));
            HttpResponse response = httpclient.execute(post, context);
            if (response.getEntity() != null) {
                response.setEntity(new BufferedHttpEntity(response.getEntity()));
            } else {
                response.setEntity(new StringEntity(""));
            }
            try {
                if (withSleepInMillis > 0) {
                    Thread.sleep(withSleepInMillis);
                }
            } catch (InterruptedException e) {
                withSleepInMillis = 0;
            }
            return response;
        } catch (IOException e) {
            throw new UncheckedIOException("failed to send request (" + url + ") ", e);
        }
    }
}