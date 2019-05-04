public class Fatorial {

    
    public static int fatorial(int num) {
      
        if (num <= 1) {
				
            return 1;
			
        } else {
			
            return fatorial(num - 1) * num;
			
        }
    }

    public static void main(String[] args) {

		if (args.length == 1) {

		int numero = Integer.parseInt(args[0]);			
		
        System.out.println("O fatorial de " + numero + " é " + fatorial(numero) + ".");
		
		} else {
			
			System.out.println("Digite o numero que deseja saber o fatorial");
			
			return;
		}
    }
}