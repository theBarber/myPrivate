package model;

import com.google.common.collect.ImmutableMap;

import java.util.Map;

public enum ResponseType {
    IMPRESSIONS("impressions"),
    CLICKS("clicks"),
    DELIVERY("delivery"),
    PASSBACK("passback"),
    CONSENT_PASSBACK("consent passback");

    final String text;

    static final Map<String, ResponseType> TEXT_TO_RESPONSE_TYPE_MAP = ImmutableMap.of(
            IMPRESSIONS.getText(), IMPRESSIONS,
            CLICKS.getText(), CLICKS,
            DELIVERY.getText(), DELIVERY,
            PASSBACK.getText(), PASSBACK,
            CONSENT_PASSBACK.getText(), CONSENT_PASSBACK
    );

    ResponseType(String text) {
        this.text = text;
    }

    public static ResponseType textToResponseType(String text) {
        return TEXT_TO_RESPONSE_TYPE_MAP.get(text);
    }

    public String getText() {
        return text;
    }

    public String toString() {
        return "ResponseType{" +
                "text='" + text + '\'' +
                '}';
    }
}
