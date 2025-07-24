package quicktest7;

public class MathUtils {
    public static int maxNaturalNumber(int n) throws IllegalArgumentException {
        if (n < 0) {
            throw new IllegalArgumentException();
        }
        return ++n;
    }
}
