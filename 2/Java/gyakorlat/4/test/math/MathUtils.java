package math;

public class MathUtils {
    public double power(double base, double exponent) {
        double result = 1;
        for(int i = 0; i < Math.abs(exponent); ++i) {
            result *= base;
        }

        if(exponent < 0) {
            result = 1 / result;

            if(base == 0) {
                throw new IllegalArgumentException("Exponent can not be negative if base is zero");
            }
        }

        return result;
    }
}