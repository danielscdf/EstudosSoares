public class MinhaClasse {
	public static void main (String[] args) {
		if(args.length == 2){
			String nome = args[0];
			String idade = args[1];
			System.out.println("Ol�, "+nome+" sua idade �: "+idade);
		}else{
			System.out.println("Informe nome e idade ao executar este programa.");
			return;
		}
	}
}