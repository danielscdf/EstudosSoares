public class Exercicio3 {
	public static void main (String[] args) {
		if(args.length == 1){
			int numero = new Integer(args[0]);
			for (int i = 1 ; i*(i+1)*(i+2)<=numero; i++){
        			if(i*(i+1)*(i+2)==numero)
        			{
            				System.out.println("O número "+args[0]+" é triangular!");
					return;
        			}
			}
			System.out.println("O número "+args[0]+" não é triangular!");
		}else{
			System.out.println("Informe 1 número, para funcionamento desse sistema.");
			return;
		}
	}
}