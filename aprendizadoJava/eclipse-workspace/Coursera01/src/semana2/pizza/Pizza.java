package semana2.pizza;

import java.util.ArrayList;
import java.util.HashMap;

public class Pizza {
	public static HashMap<String, Integer> ingredientes = new HashMap<String, Integer>();
	public ArrayList<String> ingredientesPizza = new ArrayList<String>();
	
	public void adicionaIngrediente(String ingrediente){
		contabilizaIngrediente(ingrediente);
		ingredientesPizza.add(ingrediente);
	}
	public double getPreco(){
		if( ingredientesPizza.size() <= 2) {
			return 15;
		}else if(ingredientesPizza.size() <=5) {
			return 20;
		}else {
			return 23;
		}
	}
	static void contabilizaIngrediente(String ingrediente) {
		if(ingredientes.get(ingrediente)==null) {
			ingredientes.put(ingrediente, 1);
		}else {
			ingredientes.computeIfPresent(ingrediente, (k, v) -> v + 1);
		}
	}
	public static void zeraIngrediente() {
		ingredientes.clear();
	}
}
