package semana5.signosMetodoAcessoData;

import java.time.LocalDate;
import java.util.concurrent.TimeUnit;

public class Pessoa {
	private LocalDate dataDeNascimento;

	public Pessoa(LocalDate dataDeNascimento) {
		super();
		this.dataDeNascimento = dataDeNascimento;
	}

	public LocalDate getDataDeNascimento() {
		return dataDeNascimento;
	}

	public void setDataDeNascimento(LocalDate dataDeNascimento) {
		this.dataDeNascimento = dataDeNascimento;
	}

	public int getIdade() {
		Relogio relogio = new Relogio();
		LocalDate dataAtual = LocalDate.ofEpochDay(TimeUnit.MILLISECONDS.toDays(relogio.agora()));
		//return (int) dataDeNascimento.until(dataAtual, ChronoUnit.YEARS);
		int subtraiSeAntesAniversario;
		if (dataDeNascimento.getMonthValue() > dataAtual.getMonthValue()) {
			subtraiSeAntesAniversario = -1;
		} else if (dataDeNascimento.getMonthValue() == dataAtual.getMonthValue()
				&& dataDeNascimento.getDayOfMonth() > dataAtual.getDayOfMonth()) {
			subtraiSeAntesAniversario = -1;
		} else {
			subtraiSeAntesAniversario = 0;
		}
		return dataAtual.getYear() - dataDeNascimento.getYear() + subtraiSeAntesAniversario;
	}
	
	public String getSigno() {
		int mes = dataDeNascimento.getMonthValue();
		int dia = dataDeNascimento.getDayOfMonth();
		
		switch(mes) {
		case 1:
			if(dia <= 20) {
				return "Capricórnio";
			}else {
				return "Aquário";
			}
		case 2:
			if(dia <= 19) {
				return "Aquário";
			}else {
				return "Peixes";
			}
		case 3:
			if(dia <= 20) {
				return "Peixes";
			}else {
				return "Áries";
			}
		case 4:
			if(dia <= 20) {
				return "Áries";
			}else {
				return "Touro";
			}
		case 5:
			if(dia <= 20) {
				return "Touro";
			}else {
				return "Gêmeos";
			}
		case 6:
			if(dia <= 20) {
				return "Gêmeos";
			}else {
				return "Câncer";
			}
		case 7:
			if(dia <= 21) {
				return "Câncer";
			}else {
				return "Leão";
			}
		case 8:
			if(dia <= 22) {
				return "Leão";
			}else {
				return "Virgem";
			}
		case 9:
			if(dia <= 22) {
				return "Virgem";
			}else {
				return "Libra";
			}
		case 10:
			if(dia <= 22) {
				return "Libra";
			}else {
				return "Escorpião";
			}
		case 11:
			if(dia <= 21) {
				return "Escorpião";
			}else {
				return "Sagitário";
			}
		case 12:
			if(dia <= 21) {
				return "Sagitário";
			}else {
				return "Capricórnio";
			}
		}
		return "";
	}
}
