namespace szignum {
    internal class Program {
        static void Main(string[] args) {
            // Deklaracio
            double x;
            int szignum = 0;

            // Beolvasas
            Console.Write("X: ");
            x = double.Parse(Console.ReadLine());

            // Feladatmegoldas

            if (x < 0) {
                szignum = -1;
            } else if (x > 0) {
                szignum = 1;
            } else if (x == 0) {
                szignum = 0;
            }

            // Kiiras
            Console.WriteLine("Szignum: {0}", szignum);
        }
    }
}
