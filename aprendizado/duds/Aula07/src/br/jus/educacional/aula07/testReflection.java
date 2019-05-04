package br.jus.educacional.aula07;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class testReflection {
    public static void main(String[] args) {
        try {
            C c = new C();
            Class klass = c.getClass();
            Field[] fields = getAllFields(klass);
            for (Field field : fields) {
                System.out.println(field.getName());
            }
        } catch (Throwable a_th) {
            a_th.printStackTrace();
        }
    }

    public static Field[] getAllFields(Class klass) {
        List<Field> fields = new ArrayList<Field>();
        fields.addAll(Arrays.asList(klass.getDeclaredFields()));
        if (klass.getSuperclass() != null) {
            fields.addAll(Arrays.asList(getAllFields(klass.getSuperclass())));
        }
        return fields.toArray(new Field[] {});
    }
}

class A {
    public String    nameA    = "";
}

class B extends A {
    public String    nameB    = "";
    public String    nameB1    = "";
    public String    nameB2    = "";
}

class C extends B {
    public String    nameC    = "";
}