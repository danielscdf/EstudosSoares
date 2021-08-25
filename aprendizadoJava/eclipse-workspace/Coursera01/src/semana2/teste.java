package semana2;

import java.util.HashMap;
import java.util.Map;

public class teste {

	public static void main(String[] args) {
		Map<String, Integer> words = new HashMap<>();
		words.put("hello", 3);
		words.put("world", 4);
		words.computeIfPresent("worlds", (k, v) -> v + 1);
		System.out.println("hello: "+words.get("hello"));
		System.out.println("world: "+words.get("world"));
		System.out.println("worlds: "+words.get("worlds"));
	}

}
