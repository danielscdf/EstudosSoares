//public 
class MinhaClasse {
	public static void main(String[] args){
		//System.out.println("Hello World");
		if (args.length == 2) {
			String nome = args[0];
			String idade = args[1];
			System.out.println("olá, "+nome+" sua idade é: "+ idade);
		} else {
			System.out.println("informe nome e idade ao executar esse programa.");
			return;
		}
	}
}