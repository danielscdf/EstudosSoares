public class Exercicio2 {
	public static void main (String[] args) {
		if(args.length > 0){
			for (int i = 0;i<args.length;i++){
				int quadrado = new Integer(args[i]);
				quadrado = quadrado * quadrado;
				System.out.println("O quadrado de "+args[i]+" é :"+quadrado);
			}
		}else{
			System.out.println("Informe ao menos 1 número, para funcionamento desse sistema.");
			return;
		}
	}
}