package br.jus.tse.educacional.exercicio01;

import java.lang.reflect.Method;
import java.util.ArrayList;

public class Refactor {
	public void descobrirClassesObjetos(Object o){
		Class c = o.getClass();
		Class[] n;
		Method[] m;
		n = c.getClasses();
		m = c.getMethods();
		System.out.println(c.getName());
		//n = c.getDeclaredClasses();
		for (int i = 0; i < c.getDeclaredClasses().length ; i++) {
			System.out.println(n[i].getName());
		}
		for (int i = 0; i < c.getMethods().length ; i++) {
			System.out.println(m[i].getName());
		}
	}
}
