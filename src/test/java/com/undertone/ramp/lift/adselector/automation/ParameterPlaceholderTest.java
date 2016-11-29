package com.undertone.ramp.lift.adselector.automation;

import static org.hamcrest.Matchers.is;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;

import org.junit.Before;
import org.junit.Test;

import com.undertone.automation.ParameterPlaceholderParser;
import com.undertone.automation.ParameterProvider;
import com.undertone.automation.assertion.Assert;
import com.undertone.automation.assertion.StringMatchesPattern;
import com.undertone.automation.module.WithId;
import com.undertone.automation.module.WithStringId;

public class ParameterPlaceholderTest {
    static class A implements ParameterProvider<WithId<?>> {
	Map<String, Optional<WithStringId>> mapa = new HashMap<>();
	Map<String, Optional<WithId<String>>> mapb = new HashMap<>();

	Map<String, Optional<WithId<Integer>>> mapi = new HashMap<>();

	@Override
	public Function<String, Optional<? extends WithId<?>>> getterFor(String entityType) {
	    switch (entityType.toLowerCase()) {
	    case "a":
		return s -> mapa.getOrDefault(s, Optional.empty());
	    case "b":
		return s -> mapb.getOrDefault(s, Optional.empty());
	    case "i":
		return s -> mapi.getOrDefault(s, Optional.empty());
	    default:
		return noSuchEntity -> Optional.empty();
	    }
	}

	@Override
	public String stringify(WithId<?> t) {
	    return String.valueOf(t.getId());
	}

	@Override
	public String className() {
	    return "ClassA";
	}
    }

    A a;
    ParameterPlaceholderParser<WithId<?>> parser;

    @Before
    public void setUpBefore() throws Exception {
	a = new A();
	a.mapa.put("c", Optional.of(Stringed.C));
	a.mapa.put("d", Optional.of(Stringed.D));

	a.mapb.put("Hello World", Optional.of(Stringed.E));
	a.mapb.put("Welcome", Optional.of(Stringed.F));
	a.mapb.put("Surprise", Optional.of(Stringed.EMPTYSTRING));

	a.mapb.put("1", Optional.of(Named.C));
	a.mapb.put("2", Optional.of(Named.D));

	a.mapi.put("C", Optional.of(Numbered.C));
	a.mapi.put("D", Optional.of(Numbered.D));

	parser = new ParameterPlaceholderParser<WithId<?>>(a);

    }

    enum Stringed implements WithStringId {
	C, D, E, F, EMPTYSTRING;
	public String getId() {
	    switch (this) {
	    case EMPTYSTRING:
		return "";
	    default:
		return this.name();
	    }
	};
    }

    enum Numbered implements WithId<Integer> {
	C, D, E, F, G, H, I, J, K;
	public Integer getId() {
	    return this.ordinal();
	};
    }

    enum Named implements WithId<String> {
	C, D, E, F, G, H, I, J, K;
	public String getId() {
	    return "Name: " + this.ordinal();
	};
    }

    @Test
    public void testStr() {

	String paramedString = "Testing Parameter ${ClassA.a(c)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter C"));
	paramedString = "Testing Parameter ${ClassA.a(d)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter D"));

	paramedString = "Testing Parameter ${ClassA.b(Hello World)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter E"));

	paramedString = "Testing Parameter ${ClassA.b(Surprise)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter "));

	paramedString = "Testing Parameter ^${ClassA.b(Surprise)}^";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter ^^"));
    }

    @Test(expected = IllegalArgumentException.class)
    public void testNeg1() {
	String paramedString = "Testing Parameter ${ClassA.b(welcome)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter F"));

    }

    @Test(expected = IllegalArgumentException.class)
    public void testNeg2() {
	String paramedString = "Testing Parameter ${ClassA.t(Welcome)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter F"));

    }

    @Test
    public void testInt() {
	String paramedString = "Testing Parameter ${ClassA.i(C)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter 0"));
	paramedString = "Testing Parameter ${ClassA.i(D)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter 1"));
    }

    @Test
    public void testIntActions() {
	String paramedString = "Testing Parameter ${int.sum(${ClassA.i(D)}:${ClassA.i(D)})}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter 2"));
    }

    @Test
    public void testTimestamp() {

	String paramedString = "Testing Parameter ${system.currenttimemillis}!";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString),
		new StringMatchesPattern("Testing Parameter \\d{13}!"));
    }

    @Test
    public void testTodayTimestamp() {
	String secondsSinceEpochOfToday = String.valueOf(Instant.now().truncatedTo(ChronoUnit.DAYS).getEpochSecond());
	long millisOfASingleDay = ChronoUnit.DAYS.getDuration().toMillis();//86400000

	String paramedString = "Testing Parameter ${long.divide(${long.truncate(${system.currenttimemillis}:"
		+ millisOfASingleDay + ")}:1000)} ";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString),
		is("Testing Parameter " + secondsSinceEpochOfToday + " "));
    }

    @Test
    public void testNamed() {
	String paramedString = "Testing Parameter ${ClassA.b(1)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter Name: 0"));
	paramedString = "Testing Parameter ${ClassA.b(2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter Name: 1"));
    }

    @Test
    public void testGuid() {
	String paramedString = "Testing Parameter ${guid}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString),
		new StringMatchesPattern("Testing Parameter \\w{8}-\\w{4}-\\w{4}-\\w{4}-\\w{12}"));
    }

    @Test
    public void testEmptyString1() {
	String paramedString = "Testing Parameter ${string.isempty(:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), new StringMatchesPattern("Testing Parameter 1"));
    }

    @Test
    public void testEmptyString2() {
	String paramedString = "Testing Parameter ${string.isempty(x:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), new StringMatchesPattern("Testing Parameter 2"));
    }

    @Test
    public void testEmptyStringCompose() {
	String paramedString = "Testing Parameter ${string.isempty(${ClassA.b(Surprise)}:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter 1"));
    }

    @Test
    public void testEqualsString1() {
	String paramedString = "Testing Parameter ${string.equals(a:a:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), new StringMatchesPattern("Testing Parameter 1"));
    }

    @Test
    public void testEqualsString2() {
	String paramedString = "Testing Parameter ${string.equals(a:b:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), new StringMatchesPattern("Testing Parameter 2"));
    }

    @Test
    public void testEqualsStringCompose() {
	String paramedString = "Testing Parameter ${string.equals(${ClassA.b(Hello World)}:E:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter 1"));
    }

    @Test
    public void testEqualsStringCompose2() {
	String paramedString = "Testing Parameter ${string.equals(${ClassA.b(Hello World)}:F:1:2)}";
	Assert.assertThat(parser.replacePlaceholderOf(paramedString), is("Testing Parameter 2"));
    }
}
