package math;
import math.utils.*;

class MathMain {
    public static void main(String[] args) {
        Sequences sorozat = new Sequences();

        System.out.println("Fibonacci sorozat elso 10 eleme");
        for(int i = 0; i < 10; ++i) {
            System.out.println(sorozat.fibonacci(i));
        }

        System.out.println("Catalan sorozat elso 10 eleme");
        for(int i = 0; i < 10; ++i) {
            System.out.println(sorozat.catalan(i));
        }
    }
}