package entities;

import static java.util.Objects.requireNonNull;

import infra.module.WithId;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

public class IO implements WithId<Integer>{
    public int ioId;

    @JsonProperty("LI")
    private Set<LineItem> lineItems = new TreeSet<>();
    
    public IO(@JsonProperty("ioId") int id) {
      this.ioId = requireNonNull(id);
  }
    
    @Override
    public Integer getId() {
	return ioId;
    }
    
    public Stream<LineItem> lineItems() {
      return this.lineItems.stream();
  }

}
