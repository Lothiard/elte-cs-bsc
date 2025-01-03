using System;

namespace telepules_valamikor_maximalis_homerseklettel {
    internal class Program {
        static void Main(string[] args) {
            int i, j;
            string[] line;
            int n, m, maxho, db;

            line = Console.ReadLine().Split(' ');
            int.TryParse(line[0], out n);
            int.TryParse(line[1], out m);

            int[,] ho = new int[n + 1, m + 1];
            int[] y = new int[n + 1];
            
            for (i = 1; i <= n; ++i) {
                line = Console.ReadLine().Split(' ');
                for (j = 1; j <= line.Length; ++j) {
                    int.TryParse(line[j - 1], out ho[i, j]);
                }
            }

            max(out maxho, ho, m, i, n);
            kivalaszt(out db, i, n, m, ho, maxho, ref y);
            kiir(db, y, i);
        }
        static void max(out int maxho, int[,] ho, int m, int i, int n) {
            maxho = ho[1, 1];
            for(i = 1 + 1; i <= n * m; ++i) {
                if(maxho < ho[(i - 1) / m + 1, (i - 1) % m + 1]) {
                    maxho = ho[(i - 1) / m + 1, (i - 1) % m + 1];
                }
            }
        }

        static bool bennevan(int sor, int m, int[,] ho, int maxho) {
            bool van = false;
            int j = 1;
            while (!van && j <= m) {
                if (ho[sor, j] == maxho) {
                    van = true;
                } else {
                    ++j;
                }
            }
            return van;
        }

        static void kivalaszt(out int db, int i, int n, int m, int[,] ho, int maxho, ref int[] y) {
            db = 0;
            for(i = 1; i <= n; ++i) {
                if(bennevan(i, m, ho, maxho)) {
                    ++db;
                    y[db] = i;
                }
            }
        }

        static void kiir(int db, int[] y, int i) {
            Console.Write("{0} ", db);
            for(i = 1; i <= db; ++i) {
                Console.Write("{0} ", y[i]);
            }
        }
    }
}
