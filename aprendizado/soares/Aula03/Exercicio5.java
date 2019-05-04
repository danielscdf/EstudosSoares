public class Exercicio5 {
	public static void main (String[] args) {
	int sum = 0;
		if(args.length == 1){
			int numero = new Integer(args[0]);
			for (int i = 1 ; i<numero; i++){
        			if(numero % i == 0){
					sum = sum+i;            				
        			}
			}
			if (sum==numero){
				System.out.println("O número "+args[0]+" é perfeito!");
			}else{
				System.out.println("O número "+args[0]+" não é perfeito!");
			}
				
		}else{
			System.out.println("Informe apenas um número inteiro e positivo, para funcionamento desse sistema.");
			return;
		}
	}
}