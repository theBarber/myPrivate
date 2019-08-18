package util.gdpr;

import com.google.common.annotations.VisibleForTesting;
import com.iab.gdpr.consent.VendorConsent;
import com.iab.gdpr.consent.VendorConsentEncoder;
import com.iab.gdpr.consent.implementation.v1.VendorConsentBuilder;
import ramp.lift.common.gdpr.IabConsent;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class ConsentStringBuilder {

    final Boolean isUtVendorIdIncluded;
    final Boolean isUtPurposeIdsIncluded;

    public ConsentStringBuilder(Boolean isUtVendorIdIncluded, Boolean isUtPurposeIdsIncluded) {
        this.isUtVendorIdIncluded = isUtVendorIdIncluded;
        this.isUtPurposeIdsIncluded = isUtPurposeIdsIncluded;
    }

    /**
     * Builds a base64 encoded string representation of IAB consent string.
     *
     * @return base64 encoded string.
     */
    public String build() {
        return VendorConsentEncoder.toBase64String(buildVendorConsent());
    }

    @VisibleForTesting
    Set<Integer> getAllowedPurposeIds() {
        final Set<Integer> allowedPurposes = new HashSet<>();
        if (isUtPurposeIdsIncluded) {
            allowedPurposes.addAll(IabConsent.getInstance().getUtAllowedPurposeIds());
        }
        return allowedPurposes;
    }

    @VisibleForTesting
    Set<Integer> getAllowedVendorIds() {
        final Set<Integer> allowedVendorIds = new HashSet<>();
        if (isUtVendorIdIncluded) {
            allowedVendorIds.add(IabConsent.getInstance().getUtVendorId());
        }
        return allowedVendorIds;
    }

    @VisibleForTesting
    VendorConsent buildVendorConsent() {
        final Instant now = LocalDateTime.now().withNano(0).toInstant(ZoneOffset.UTC);
        final Set<Integer> allowedPurposes = getAllowedPurposeIds();
        final int cmpId = 1;
        final int cmpVersion = 1;
        final int consentScreenID = 1;
        final String consentLanguage = "EN";
        final int vendorListVersion = 10;
        final int maxVendorId = 180;
        final int vendorEncodingType = 0; // Bit field
        final Set<Integer> allowedVendors = getAllowedVendorIds();

        final VendorConsent vendorConsent = new VendorConsentBuilder()
                .withConsentRecordCreatedOn(now)
                .withConsentRecordLastUpdatedOn(now)
                .withCmpID(cmpId)
                .withCmpVersion(cmpVersion)
                .withConsentScreenID(consentScreenID)
                .withConsentLanguage(consentLanguage)
                .withVendorListVersion(vendorListVersion)
                .withAllowedPurposeIds(allowedPurposes)
                .withMaxVendorId(maxVendorId)
                .withVendorEncodingType(vendorEncodingType)
                .withBitField(allowedVendors)
                .build();
        return vendorConsent;
    }
}
