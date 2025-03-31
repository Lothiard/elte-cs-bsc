package iodemo;

public class SumMain {
    public static void main(String[] args) {
        String filename = "iodemo/in.txt"; // lehetne akar null is 
        try {
            Sum.AddNumbers(filename);
        } catch (NullPointerException e) {
            Sum.AddNumbers("iodemo/defaultIn.txt"); 
        }
    }
}