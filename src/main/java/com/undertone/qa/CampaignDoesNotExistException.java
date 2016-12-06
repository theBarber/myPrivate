package com.undertone.qa;

public class CampaignDoesNotExistException extends RuntimeException {

    /**
     * 
     */
    private static final long serialVersionUID = -7121369015069400149L;

    public CampaignDoesNotExistException() {
    }

    public CampaignDoesNotExistException(String message) {
	super(message);
    }

    public CampaignDoesNotExistException(Throwable cause) {
	super(cause);
    }

}
