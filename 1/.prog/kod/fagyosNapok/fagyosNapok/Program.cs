using System;

namespace fagyosNapok {
    internal class Program {
        static void Main(string[] args) {
            // deklaralas
            int n, fagy, i, j;
            int[,] ho;

            // beolvasas
            int.TryParse(Console.ReadLine(), out n);
            ho = new int[n, 2];

            for (i = 1; i <= n; ++i) {
                string[] input = Console.ReadLine().Split(' ');

                ho[i - 1, 0] = int.Parse(input[0]);
                ho[i - 1, 1] = int.Parse(input[1]);
            }

            // feladat megoldas
            fagy = 0;
            for(i = 1; i <= n; ++i) {
                if (ho[i - 1, 0] < 0 || ho[i - 1, 1] < 0) {
                    fagy = fagy + 1;
                }
            }

            // kiiras
            Console.WriteLine(fagy);
        }
    }
}
