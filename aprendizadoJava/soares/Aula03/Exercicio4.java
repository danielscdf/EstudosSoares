public class Exercicio4 {
	public static void main (String[] args) {
	int div = 0;
		if(args.length == 1){
			int numero = new Integer(args[0]);
			for (int i = 1 ; i<=numero; i++){
        			if(numero % i == 0){
					div++;            				
        			}
			}
			if (div==2){
				System.out.println("O número "+args[0]+" é primo!");
			}else{
				System.out.println("O número "+args[0]+" não é primo!");
			}
				
		}else{
			System.out.println("Informe apenas um número inteiro e positivo, para funcionamento desse sistema.");
			return;
		}
	}
}