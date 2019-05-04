//package br.jus.educacional.aula07;

public class Fibonacci extends Thread {
	private int x;
	public int answer;

	public Fibonacci(int x) {
		this.x = x;
	}

	public void run() {
		if (x <= 2)
			answer = 1;
		else {
			try {
				Fibonacci f1 = new Fibonacci(x - 1);
				Fibonacci f2 = new Fibonacci(x - 2);
				f1.start();
				f2.start();
				f1.join();
				f2.join();
				answer = f1.answer + f2.answer;
			} catch (InterruptedException ex) {
			}
		}
	}

	public static void main(String[] args)
        throws Exception
    {
        try {
        	Fibonacci f = new Fibonacci( Integer.parseInt(args[0]) );
            f.start();
            f.join();
            System.out.println(f.answer);
        }
        catch(Exception e) {
            System.out.println("usage: java Fibonacci NUMBER");
        }
    }
}