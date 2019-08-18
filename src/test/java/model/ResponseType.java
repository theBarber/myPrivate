package model;

import com.google.common.collect.ImmutableMap;

import java.util.HashMap;
import java.util.Map;

public enum ResponseType {
    IMPRESSIONS("impressions"),
    CLICKS("clicks"),
    DELIVERY("delivery"),
    PASSBACK("passback"),
    GDPR_PASSBACK("gdpr passback");

    final String text;

    static final Map<String, ResponseType> TEXT_TO_RESPONSE_TYPE_MAP = ImmutableMap.of(
            IMPRESSIONS.getText(), IMPRESSIONS,
            CLICKS.getText(), CLICKS,
            DELIVERY.getText(), DELIVERY,
            PASSBACK.getText(), PASSBACK,
            GDPR_PASSBACK.getText(), GDPR_PASSBACK
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
