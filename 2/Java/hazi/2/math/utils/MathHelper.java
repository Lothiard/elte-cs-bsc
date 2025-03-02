package math.utils;

public class MathHelper {
    public long factorial(int n) {
        long result = 1;
        for(int i = 1; i <= n; ++i) {
            result *= i;
        }
        return result;
    }
}
