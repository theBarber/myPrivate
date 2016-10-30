package com.undertone.automation.module;

public interface Module {

	public abstract Object getActual();

	public abstract void setActual(Object actual);

	public abstract void init() throws Exception;

	public abstract void close() throws Exception;

}