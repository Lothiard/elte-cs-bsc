package math.utils;

public class Sequences {
    public int fibonacci(int n) {
        if (n <= 1) return n;
        int a = 0, b = 1;
        for (int i = 2; i <= n; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        return b;
    }

    public long catalan(int n) {
        MathHelper seged = new MathHelper();

        return seged.factorial(2 * n) / (seged.factorial(n + 1) * seged.factorial(n));
    }
}
