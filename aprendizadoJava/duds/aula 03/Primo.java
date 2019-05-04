public class Primo {
	public static void main(String[] args){
		if (args.length == 1) {
			int numero = Integer.parseInt(args[0]);
			//int resultado;
			String resposta = "O numero "+numero+" eh primo";
				for (int i=2; i<numero/2;i++)
					{
						if (numero % i == 0){
						resposta = "O numero "+numero+" nao eh primo";
						}
					}
					System.out.println(resposta);
			} else {
			System.out.println("Favor digitar o numero primo");
			}	 
	}
}