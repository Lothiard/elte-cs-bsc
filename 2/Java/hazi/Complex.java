class Complex {
    private double real;
    private double img;

    public Complex(double real, double img) {
        this.real = real;
        this.img = img;
    }

    public static double abs(Complex num) {
        return Math.sqrt(Math.pow(num.real,2) + Math.pow(num.img,2));
    }

    public static Complex add(Complex num, Complex c) {
        num.real += c.real;
        num.img += c.img;
        return num;
    }

    public static Complex sub(Complex num, Complex c) {
        num.real -= c.real;
        num.img -= c.img;
        return num;
    }

    public static Complex mul(Complex num, Complex c) {
        double tempReal = num.real;
        double tempImg = num.img;
        num.real = tempReal * c.real - tempImg * c.img;
        num.img = tempReal * c.img + tempImg * c.real;
        return num;
    }

    public static void main(String[] args) {
        Complex num = new Complex(1, 2);

        System.out.println("abszolut ertek:");
        System.out.println(abs(num));

        System.out.println("osszeg:");
        add(num, new Complex(2, 3));
        System.out.println(num.real + " + " + num.img + "i");

        System.out.println("abszolut ertek:");
        sub(num, new Complex(3, 4));
        System.out.println(num.real + " + " + num.img + "i");

        System.out.println("abszolut ertek:");
        mul(num, new Complex(4, 5));
        System.out.println(num.real + " + " + num.img + "i");
    }
}