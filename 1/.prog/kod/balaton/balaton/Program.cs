using System;

namespace balaton {
    internal class Program {
        static void Main(string[] args) {
            // deklaracio
            int n, minind, minert, i;

            // beolvasas
            int.TryParse(Console.ReadLine(), out n);
            int[] h = new int[n];

            for(i = 0; i < n; ++i) {
                int.TryParse(Console.ReadLine(), out h[i]);
            }

            // feladat megoldas
            minert = h[0]; minind = 0;
            for (i = 0 + 1; i < n; ++i) {
                if (h[i] < minert) {
                    minert = h[i];
                    minind = i;
                }
            }

            // kiiras
            Console.WriteLine(minert);
        }
    }
}
