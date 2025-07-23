namespace Rational {
    internal class Program {
        static void Main(string[] args) {
            Rac a = new Rac(-3, 2);
            Rac b = new Rac(-1, 2);

            Console.WriteLine(a + b);
            Console.WriteLine(a - b);
            Console.WriteLine(a * b);
            Console.WriteLine(a / b);

            try {
                Rac c = new Rac(-1, 0);
            } catch (DivideByZeroException e) {
                Console.WriteLine("bruh");
            }
        }
    }
}
