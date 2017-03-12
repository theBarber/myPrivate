package entities;

import infra.module.WithId;

public class IO implements WithId<Integer>{
    public int ioId;

    @Override
    public Integer getId() {
	return ioId;
    }
}
