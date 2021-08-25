package semana1.testeCalculoIMC;

import static org.junit.Assert.*;

import org.junit.Test;

import semana1.CalculoIMC.Paciente;

public class testeCalculoIMC {
	//Mapeia 8 pacientes com IMC diferentes
    Paciente paciente1 = new Paciente(40, 1.60);  
    Paciente paciente2 = new Paciente(60, 1.90);
    Paciente paciente3 = new Paciente(53, 1.70);  
    Paciente paciente4 = new Paciente(80, 1.80);  
    Paciente paciente5 = new Paciente(85, 1.80);  
    Paciente paciente6 = new Paciente(110, 1.80);  
    Paciente paciente7 = new Paciente(110, 1.70);  
    Paciente paciente8 = new Paciente(110, 1.60);		
    
	@Test
	public void testeCalcularIMC() {
		assertEquals(15.62, paciente1.calcularIMC(), 0.01);
		assertEquals(16.62, paciente2.calcularIMC(), 0.01);
		assertEquals(18.33, paciente3.calcularIMC(), 0.01);
		assertEquals(24.69, paciente4.calcularIMC(), 0.01);
		assertEquals(26.23, paciente5.calcularIMC(), 0.01);
		assertEquals(33.95, paciente6.calcularIMC(), 0.01);
		assertEquals(38.06, paciente7.calcularIMC(), 0.01);
		assertEquals(42.96, paciente8.calcularIMC(), 0.01);
	}

	@Test
	public void testeDiagnostico() {
		assertEquals("Baixo peso muito grave", paciente1.diagnostico());
		assertEquals("Baixo peso grave", paciente2.diagnostico());
		assertEquals("Baixo peso", paciente3.diagnostico());
		assertEquals("Peso normal", paciente4.diagnostico());
		assertEquals("Sobrepeso", paciente5.diagnostico());
		assertEquals("Obesidade grau I", paciente6.diagnostico());
		assertEquals("Obesidade grau II", paciente7.diagnostico());
		assertEquals("Obesidade grau III (obesidade mórbida)", paciente8.diagnostico());
	}

}
