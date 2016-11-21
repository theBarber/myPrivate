package com.undertone.qa;

import com.undertone.automation.module.WithId;

public class IO implements WithId<Integer>{
    public int ioId;

    @Override
    public Integer getId() {
	return ioId;
    }
}
