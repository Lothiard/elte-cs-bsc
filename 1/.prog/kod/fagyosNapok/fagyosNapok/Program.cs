using System;

namespace fagyosNapok {
    public struct Idojaras {
        public int min, max;
    }
    internal class Program {
        static void Main(string[] args) {
            // deklaralas
            int n, fagy, i, j;

            // beolvasas
            int.TryParse(Console.ReadLine(), out n);
            Idojaras[] ho = new Idojaras[n];

            for (i = 1; i <= n; ++i) {
                string[] input = Console.ReadLine().Split(' ');

                ho[i - 1].min = int.Parse(input[0]);
                ho[i - 1].max = int.Parse(input[1]);
            }

            // feladat megoldas
            fagy = 0;
            for(i = 1; i <= n; ++i) {
                if (ho[i - 1].min < 0) {
                    fagy = fagy + 1;
                }
            }

            // kiiras
            Console.WriteLine(fagy);
        }
    }
}
