package semana2.escola;

public class Principal {

	public static void main(String[] args) {
		Aluno guerra = new Aluno();
		guerra.bim1 = 70;
		guerra.bim2 = 60;
		guerra.bim3 = 80;
		guerra.bim4 = 30;
		
		System.out.println(guerra.mediaAluno());
		System.out.println(guerra.passouDeAno());
	}

}
