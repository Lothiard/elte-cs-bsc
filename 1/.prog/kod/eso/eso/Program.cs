using System;

namespace eso {
    internal class Program {
        static void Main(string[] args) {
            int i;
            int n, maxhet, monotondb, felemin;
            int[,] c;
            int[] mindenhet;
            int[] monoton;

            beolvas(out n, out c, i);
            
        }

        static void beolvas (out int n, out int[,] c, int i) {
            string[] line;
            int.TryParse(Console.ReadLine(), out n);

            c = new int[n + 1, 7 + 1];

            line = Console.ReadLine().Split(' ');
            for (i = 1; i <= n; ++i) {
                int.TryParse(line[0], out c[i, 1]);
                int.TryParse(line[1], out c[i, 2]);
                int.TryParse(line[2], out c[i, 3]);
                int.TryParse(line[3], out c[i, 4]);
                int.TryParse(line[4], out c[i, 5]);
                int.TryParse(line[5], out c[i, 6]);
                int.TryParse(line[6], out c[i, 7]);
            }
        }

        static void a() {
            for(int i = 1; i < )
        }
    }
}
