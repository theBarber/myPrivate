package ramp.lift.uas.automation;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.SocketConfig;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;

import infra.module.AbstractModuleImpl;

public class UASRequestModule extends AbstractModuleImpl<List<CompletableFuture<HttpResponse>>> {

	private ExecutorService requestSubmitter;
	protected static final Pattern impressionURLPattern = Pattern
			.compile("(https?:\\/\\/[^:/?#]*(?::[0-9]+)?\\/l[^?#]*\\?\\w*=\\w*(&\\w*=\\w*)*)");

	protected static final Pattern clickURLPattern = Pattern
			.compile("(https?:\\/\\/[^:/?#]*(?::[0-9]+)?\\/c\\?[^\'\\\"]*)[\'\\\"]");

	protected static final String getGroup1(Matcher from) {
		return from.group(1);
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	private String host;
	private String port;
	protected CloseableHttpClient httpclient;
	List<Header> httpHeaders = new ArrayList<Header>();

	public UASRequestModule() {
		setActual(new ArrayList<>());
		httpclient = HttpClients.custom().setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build())
				.build();
		requestSubmitter = Executors.newFixedThreadPool(5);
	}

	public void zoneRequest(Integer forZone) {
		String url = "http://" + host + ":" + port + "/af?zoneid=" + forZone + "&ct=1";
		request(url, true);
	}

	public void zoneRequests(Integer forZone, int times, boolean toReset) {
		if (toReset) {
			reset();
		}

		String url = "http://" + host + ":" + port + "/af?zoneid=" + forZone + "&ct=1";

		for (; times > 0; times--) {
			request(url, false);
		}
	}

	public void zoneRequestsWithGeo(Integer forZone, int times, String params) {
		reset();
		String url = "http://" + host + ":" + port + "/af?zoneid=" + forZone + "&ct=1" + "&sim_geo=1&" + params;

		for (; times > 0; times--) {
			request(url, false);
		}
	}

	public void healthCheckRequest() {

		String url = "http://" + host + ":" + port + "/health";
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
		String url = "http://" + host + ":" + port + "/health?skip=" + skipFlag;
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
				HttpResponse response = httpclient.execute(get);
				response.setEntity(new BufferedHttpEntity(response.getEntity()));
				return response;

			} catch (IOException e) {
				throw new UncheckedIOException("failed to send request (" + url + ") ", e);
			}
		}, requestSubmitter));
	}

	public Stream<CompletableFuture<HttpResponse>> responses() {
		return actual().stream();
	}

	@Override
	public void init() throws Exception {
		super.init();
		reset();
	}

	protected final void reset() {
		this.actual().stream().parallel().filter(((Predicate<Future<HttpResponse>>) Future::isDone).negate())
				.forEach(f -> f.cancel(true));

		this.actual().clear();
	}

	public void addHttpHeader(String name, String value) {
		httpHeaders.removeIf(header -> header.getName().equals(name));
		httpHeaders.add(new BasicHeader(name, value));
	}

	public void emptyHttpHeaders() {
		httpHeaders.clear();
	}

	public static Optional<String> getImpressionUrlFrom(HttpResponse response) {
		return Optional.of(impressionURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
				.map(UASRequestModule::getGroup1);
	}

	public static Optional<String> getClickUrlFrom(HttpResponse response) {
		return Optional.of(clickURLPattern.matcher(getContentOf(response))).filter(Matcher::find)
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
}