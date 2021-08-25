package semana5.testeSignosMetodoAcessoData;

import static org.junit.Assert.*;

import java.time.LocalDate;
import java.util.concurrent.TimeUnit;

import org.junit.BeforeClass;
import org.junit.Test;

import semana5.signosMetodoAcessoData.Pessoa;
import semana5.signosMetodoAcessoData.Relogio;

public class TestePessoa {

	@BeforeClass
	public static void setaAgora() {
		Relogio.agoraFixo = TimeUnit.DAYS.toMillis(LocalDate.of(2021, 7, 17).toEpochDay());
	}
	
	@Test
	public void testIdade() {
		Pessoa pessoa1 = new Pessoa(LocalDate.of(1981, 2, 15));
		Pessoa pessoa2 = new Pessoa(LocalDate.of(1984, 4, 11));
		Pessoa pessoa3 = new Pessoa(LocalDate.of(2010, 12, 26));
		assertEquals(pessoa1.getIdade(), 40);
		assertEquals(pessoa2.getIdade(), 37);
		assertEquals(pessoa3.getIdade(), 10);
	}

	@Test
	public void testSigno() {
		Pessoa pessoa1 = new Pessoa(LocalDate.of(1981, 2, 15));
		Pessoa pessoa2 = new Pessoa(LocalDate.of(1984, 4, 11));
		Pessoa pessoa3 = new Pessoa(LocalDate.of(2010, 12, 26));
		assertEquals(pessoa1.getSigno(), "Aquário");
		assertEquals(pessoa2.getSigno(), "Áries");
		assertEquals(pessoa3.getSigno(), "Capricórnio");
	}

}
