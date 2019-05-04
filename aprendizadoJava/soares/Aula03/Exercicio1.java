public class Exercicio1 {
	public static void main (String[] args) {
		if(args.length == 1){
			int fatorial = new Integer(args[0]);
			int valor = 1;
			while (fatorial > 1){
				valor = valor *(fatorial);
				fatorial--;
			}
			System.out.println("O fatorial de "+args[0]+" é :"+valor);
		}else{
			System.out.println("Informe um número positivo, para funcionamento desse sistema.");
			return;
		}
	}
}