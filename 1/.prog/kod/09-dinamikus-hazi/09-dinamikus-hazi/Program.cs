using System;

namespace _09_dinamikus_hazi {
    internal class Program {
        struct Diak {
            public string nev;
            public int jegy;
        }
        static void Main(string[] args) {
            // dekl: spec be + ki
            int n; Diak[] diakok;
            int db; string[] jelesek;

            // beolvasás: spec be
            beolvas(out n, out diakok, out jelesek);

            // feldolgozás: stuki
            kivalogat(out db, n, diakok, ref jelesek);

            // kiírás
            kiir(db, jelesek);
        }
        static void beolvas(out int n, out Diak[] diakok, out string[] jelesek) {
            Console.Write("n = ");
            int.TryParse(Console.ReadLine(), out n);
            diakok = new Diak[n];
            jelesek = new string[n];
            for (int i = 1; i <= n; i++) {
                Console.Write("{0}. nev = ", i);
                diakok[i - 1].nev = Console.ReadLine();
                Console.Write("{0}. jegy = ", i);
                int.TryParse(Console.ReadLine(), out diakok[i - 1].jegy);
            }
        }

        static void kivalogat(out int db, int n, Diak[] diakok, ref string[] jelesek) {
            db = 0;
            for (int i = 1; i <= n; i++) {
                if (diakok[i - 1].jegy == 5) {
                    db = db + 1;
                    jelesek[db - 1] = diakok[i - 1].nev;
                }
            }
        }

        static void kiir(int db, string[] jelesek) {
            Console.WriteLine("{0} db jeles tanuló:", db);
            for (int i = 1; i <= db; i++) {
                Console.WriteLine(jelesek[i - 1]);
            }
        }
    }
}