package br.jus.tse.educacional.exercicio01;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Inherited
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)

public @interface ViciaDado {
	public int numeroViciado();
	public int vezesRepeticao();
}
