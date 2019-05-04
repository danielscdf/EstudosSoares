public class Triangular {
	public static void main(String[] args){
		if (args.length == 1) {
			int numero = Integer.parseInt(args[0]);
			String resposta = "O numero "+numero+" não é triangular";
				for (int i=1; i<numero/2;i++)
					{
					int resultado = i*(i+1)*(i+2);
						if (resultado == numero){
						resposta = "O numero "+numero+" é triangular";
						}
					}
					System.out.println(resposta);
			} else {
			System.out.println("Favor digitar o numero triangular");
			}	 
	}
}
