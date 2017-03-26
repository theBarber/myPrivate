package infra.module;

public class AbstractModuleImpl<T> extends AbstractModule implements Namefull {

    @Override
    public void init() throws Exception {
    }

    @Override
    public void close() throws Exception {
    }

    @Override
    public String getName() {
	return name;
    }

    @Override
    public void setName(String name) {
	this.name = name;
    }

    @SuppressWarnings("unchecked")
    public T actual() {
	return (T) super.getActual();
    }

    protected void actual(T is) {
	this.setActual(is);
    }
}
