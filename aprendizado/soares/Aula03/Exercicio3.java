public class Exercicio3 {
	public static void main (String[] args) {
		if(args.length == 1){
			int numero = new Integer(args[0]);
			for (int i = 1 ; i*(i+1)*(i+2)<=numero; i++){
        			if(i*(i+1)*(i+2)==numero)
        			{
            				System.out.println("O n�mero "+args[0]+" � triangular!");
					return;
        			}
			}
			System.out.println("O n�mero "+args[0]+" n�o � triangular!");
		}else{
			System.out.println("Informe 1 n�mero, para funcionamento desse sistema.");
			return;
		}
	}
}