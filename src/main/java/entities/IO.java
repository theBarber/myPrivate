package entities;

import static java.util.Objects.requireNonNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import entities.ramp.app.api.Creative;
import infra.module.WithId;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class IO implements WithId<Integer>{
    public int ioId;
    @JsonProperty("creatives")
    public List<Creative> creatives = new ArrayList<>();
    @JsonProperty("deals")
    public List<Deal> deals = new ArrayList<>();
    @JsonProperty("LI")
    private List<LineItem> lineItems = new ArrayList<>();
    
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


    public void addLineItem(LineItem li) {
        lineItems.add(li);
    }
}
