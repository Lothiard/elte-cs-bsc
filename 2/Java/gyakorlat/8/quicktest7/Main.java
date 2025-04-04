package quicktest7;

public class Main {
    public static void main(String[] args) {
        int result = 0;
        try {
            result = MathUtils.maxNaturalNumber(-1);
        } catch (IllegalArgumentException e) {
            System.out.println("number cannot be negative");
        }
    }
}
