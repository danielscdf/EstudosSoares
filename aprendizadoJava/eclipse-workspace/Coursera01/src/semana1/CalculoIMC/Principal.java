package semana1.CalculoIMC;

public class Principal {
	public static void main(String[] args) {
		//Paciente paciente1 = new Paciente(74,1.74);
		//Paciente paciente2 = new Paciente(58,1.41);
		//Paciente paciente3 = new Paciente(55,1.73);
		
        Paciente paciente1 = new Paciente(40, 1.60);  
        Paciente paciente2 = new Paciente(60, 1.90);
        Paciente paciente3 = new Paciente(53, 1.70);  
        Paciente paciente4 = new Paciente(80, 1.80);  
        Paciente paciente5 = new Paciente(85, 1.80);  
        Paciente paciente6 = new Paciente(110, 1.80);  
        Paciente paciente7 = new Paciente(110, 1.70);  
        Paciente paciente8 = new Paciente(110, 1.60);  
		System.out.println("Paciente1 possui IMC: "+paciente1.calcularIMC()+" diagnóstico: "+paciente1.diagnostico()); 
		System.out.println("Paciente2 possui IMC: "+paciente2.calcularIMC()+" diagnóstico: "+paciente2.diagnostico()); 
		System.out.println("Paciente3 possui IMC: "+paciente3.calcularIMC()+" diagnóstico: "+paciente3.diagnostico()); 
		System.out.println("Paciente4 possui IMC: "+paciente4.calcularIMC()+" diagnóstico: "+paciente4.diagnostico()); 
		System.out.println("Paciente5 possui IMC: "+paciente5.calcularIMC()+" diagnóstico: "+paciente5.diagnostico()); 
		System.out.println("Paciente6 possui IMC: "+paciente6.calcularIMC()+" diagnóstico: "+paciente6.diagnostico()); 
		System.out.println("Paciente7 possui IMC: "+paciente7.calcularIMC()+" diagnóstico: "+paciente7.diagnostico()); 
		System.out.println("Paciente8 possui IMC: "+paciente8.calcularIMC()+" diagnóstico: "+paciente8.diagnostico()); 
	}
}
