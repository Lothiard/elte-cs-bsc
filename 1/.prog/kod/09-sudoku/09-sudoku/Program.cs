namespace _09_sudoku {
    internal class Program {
        static void Main(string[] args) {
            // deklaráció
            int[,] s = new int[9, 9] {
                {3, 0, 0, 8, 0, 1, 0, 0, 2 },
                {2, 0, 1, 0, 3, 0, 6, 0, 4 },
                {0, 0, 0, 2, 0, 4, 0, 0, 0 },
                {8, 0, 9, 0, 0, 0, 1, 0, 6 },
                {0, 6, 0, 0, 0, 0, 0, 5, 0 },
                {7, 0, 2, 0, 0, 0, 4, 0, 9 },
                {0, 0, 0, 5, 0, 9, 0, 0, 0 },
                {9, 0, 4, 0, 8, 0, 7, 0, 5 },
                {6, 0, 0, 1, 0, 7, 0, 0, 3 }
                };
            int db;

            // beolvasás
            beolvas(ref s);

            // feldolgozás
            feldolgoz(out db, s);

            // kiírás
            kiiras(db);
        }

        static void beolvas(ref int[,] s) {
            Console.WriteLine("Add meg soronként a számokat, soron belül szóközzel elválasztva.");
            for (int i = 1; i <= 9; i++) {
                Console.Write("{0}. sor: ", i);
                string[] sortomb = Console.ReadLine().Split(" ");
                for (int j = 1; j <= 9; j++) {
                    int.TryParse(sortomb[j - 1], out s[i - 1, j - 1]);
                }
            }
        }

        static void feldolgoz(out int db, int[,] s) {
            db = 0;
            for (int k = 1; k <= 81; k++) {
                if (s[(k - 1) / 9 + 1 - 1, (k - 1) % 9 + 1 - 1] == 5) {
                    db = db + 1;
                }
            }
        }
        static void kiiras(int db) {
            Console.WriteLine("Az 5-ös számok száma: {0}", db);
        }
    }
}
