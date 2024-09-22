using System;

namespace utolsoSzamjegy {
    internal class Program {
        static void Main(string[] args) {
            bool helyes = false;

            while (!helyes) {
                Console.WriteLine("Kerek egy egesz szamot!");
                int input;
                if (int.TryParse(Console.ReadLine(), out input)) {
                    helyes = true;
                    Console.WriteLine("A(z) {1} utolso szamjegye: {0}", input % 10, input);
                } else {
                    Console.WriteLine("Nem egesz szam");
                }
            }
        }
    }
}
