package semana5.signosMetodoAcessoData;

import java.time.LocalDate;
import java.util.concurrent.TimeUnit;

public class Principal {
	public static void main(String[] args) {
		Pessoa pessoa1 = new Pessoa(LocalDate.of(1981, 7, 18));
		//System.out.println(LocalDate.ofEpochDay(TimeUnit.MILLISECONDS.toDays(System.currentTimeMillis())));
		//System.out.println(LocalDate.ofEpochDay(TimeUnit.MILLISECONDS.toDays(System.currentTimeMillis())).toEpochDay());
		//System.out.println(TimeUnit.MILLISECONDS.toDays(System.currentTimeMillis()));
		System.out.println(TimeUnit.DAYS.toMillis(LocalDate.of(2021, 7, 17).toEpochDay()));
		System.out.println(TimeUnit.DAYS.toMillis(LocalDate.now().toEpochDay()));
		System.out.println(System.currentTimeMillis());
		
		System.out.println("Idade: " + pessoa1.getIdade());
		System.out.println(pessoa1.getSigno());
		//System.out.println(System.currentTimeMillis()/1000/60/60);
		//System.out.println(TimeUnit.MILLISECONDS.toDays(System.currentTimeMillis()));
	}

}
