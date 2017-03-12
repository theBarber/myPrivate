package infra.support;

public class FormatterImpl<T> implements Formatter<T> {

    @Override
    public String toString(T t) {
	return String.valueOf(t);
    }

}
