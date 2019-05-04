//package br.jus.educacional.aula07;

class PrintFibo 
{ 
    public static void main(String args[]) 
  { 
    JavaFib t = new JavaFib (300); 
    t.start ( ); 
  } 
} 
 
class JavaFib extends Thread 
{ 
   
    private int num; 
 
    JavaFib (int itr) 
     { 
       num=itr; 
     } 
    public void run() 
     { 
 //       long[] series = new long[num]; 
 
 //       series[0] = 0; 
 //       series[1] = 1;
    	
 
 
    for(int i=2; i < num; i++) 
        { 
          series[i] = series[i-1] + series[i-2]; 
        } 
 
     System.out.println("Fibonacci Series ateh " + num); 
        for(int i=0; i< num; i++) 
          { 
            System.out.print(series[i] + " "); 
          } 
        } 
}