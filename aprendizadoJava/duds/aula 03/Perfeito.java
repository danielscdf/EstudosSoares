public class Perfeito {
	public static void main(String[] args){
		if (args.length == 1) {
				int numero = Integer.parseInt(args[0]);
				int soma = 0;
				int i = 1;
				
				for (i = 1; i < numero; i++) {
					int a = numero % i;
					if (a == 0) {
					soma = soma + i;
					}
				}		 
				if (soma == numero){           
					System.out.println("Esse numero eh perfeito:"+numero);
				}  else       {
					System.out.println("Esse numero NAO eh perfeito:"+numero);
				}
		}
	}		
}