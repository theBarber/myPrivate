package com.undertone.automation;

import java.util.Objects;
import java.util.Optional;
import java.util.function.Function;

import com.undertone.automation.module.Named;
// javadoc import
import com.undertone.automation.module.WithId;

@FunctionalInterface
public interface ParameterProvider<T> {
    /**
     * @param entityType
     *            the name of the entity that we are asking for
     * @return a function that returns an entity by it's name:
     * 
     *         <code>
     *   String nameOfTheEntity = ".....";// e.g: "Campaign#123" <br/> 
     *   String typeOfTheEntity = "*****";// e.g: "Campaign"<br/>
     *   {@link ParameterProvider} provider = ..... // e.g: sut.getCampaignManager()<br/>
     *   
     *   
     *   {@link Optional}<{@link WithId}<{@link Integer}>> entity = 
     *   provider.getterFor(typeOfTheEntity).apply(nameOfTheEntity)<br/>
     *   Integer = entity.{@link WithId#getId() getId()};
     *   </code>
     */
    public Function<String, Optional<? extends T>> getterFor(String entityType);

    /**
     * A way to transform the getter to its string representation
     * 
     * @param t
     *            a single object that a getter may return
     * @return
     */
    public default String stringify(T t) {
	return Objects.toString(t);
    }

    default String className() {
	return this.getClass().getSimpleName();
    }

}
