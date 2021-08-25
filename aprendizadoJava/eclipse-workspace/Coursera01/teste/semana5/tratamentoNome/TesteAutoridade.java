package semana5.tratamentoNome;

import static org.junit.Assert.*;

import org.junit.Test;

public class TesteAutoridade {

	@Test
	public void testInformal() {
		Autoridade pessoa = new Autoridade(" Joaquim "," Silva ", new Informal());
		System.out.println(pessoa.getTratamento());
		assertEquals(pessoa.getTratamento(), "Joaquim");
	}

	@Test
	public void testRespeitoso() {
		Autoridade pessoa = new Autoridade(" Joaquim "," Silva ", new Respeitoso(true));
		System.out.println(pessoa.getTratamento());
		assertEquals(pessoa.getTratamento(), "Sr.Silva");
	}

	@Test
	public void testComTitulo() {
		Autoridade pessoa = new Autoridade(" Joaquim "," Silva ", new ComTitulo("Excelentíssimo"));
		System.out.println(pessoa.getTratamento());
		assertEquals(pessoa.getTratamento(), "Excelentíssimo Joaquim Silva");
	}

}
