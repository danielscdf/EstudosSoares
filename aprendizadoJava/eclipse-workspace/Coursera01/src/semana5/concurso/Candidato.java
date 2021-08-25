package semana5.concurso;

public class Candidato implements Comparable<Candidato> {
	private int nota;
	private boolean deficiente;
	private int idade;
	public char[] teste;

	public char[] getTeste() {
		return teste;
	}

	public void setTeste(char[] teste) {
		this.teste = teste;
	}

	@Override
	public int compareTo(Candidato outro) {
		if(nota == outro.getNota()) {
			if(this.deficiente == outro.deficiente) {
				return getIdade() - outro.getIdade();
			}else {
				if(isDeficiente()) {
					return 1;
				}else {
					return -1;
				}
			}
		}else {
			return nota - outro.getNota();
		}
	}

	public int getNota() {
		return nota;
	}

	public boolean isDeficiente() {
		return deficiente;
	}

	public int getIdade() {
		return idade;
	}

	public Candidato(int nota, boolean deficiente, int idade) {
		super();
		this.nota = nota;
		this.deficiente = deficiente;
		this.idade = idade;
	}

	@Override
	public String toString() {
		return nota+";"+deficiente+";"+idade;
	}
	
	
}
