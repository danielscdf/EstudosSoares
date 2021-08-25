package semana2.escola;

public class Aluno {
	int bim1;
	int bim2;
	int bim3;
	int bim4;
	
	public int mediaAluno() {
		int total = 0;
		total += this.bim1;
		total += this.bim2;
		total += this.bim3;
		total += this.bim4;
		return total/4;
	}

	public boolean passouDeAno() {
		if(mediaAluno()>=60) {
			return true;
		} else {
			return false;
		}
	}
	
	
}
