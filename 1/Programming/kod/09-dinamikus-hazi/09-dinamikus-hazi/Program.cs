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
            List<string> jelesek = new List<string>();

            // beolvasás: spec be
            beolvas(out n, out diakok);

            // feldolgozás: stuki
            kivalogat(n, diakok, ref jelesek);

            // kiírás
            kiir(jelesek);
        }
        static void beolvas(out int n, out Diak[] diakok) {
            Console.Write("n = ");
            int.TryParse(Console.ReadLine(), out n);
            diakok = new Diak[n];
            for (int i = 1; i <= n; i++) {
                Console.Write("{0}. nev = ", i);
                diakok[i - 1].nev = Console.ReadLine();
                Console.Write("{0}. jegy = ", i);
                int.TryParse(Console.ReadLine(), out diakok[i - 1].jegy);
            }
        }

        static void kivalogat(int n, Diak[] diakok, ref List<string> jelesek) {
            jelesek.Clear();
            for (int i = 1; i <= diakok.Length; i++) {
                if (diakok[i - 1].jegy == 5) {
                    jelesek.Add(diakok[i - 1].nev);
                }
            }
        }

        static void kiir(List<string> jelesek) {
            for (int i = 1; i <= jelesek.Count; i++) {
                Console.WriteLine(jelesek[i - 1]);
            }
        }
    }
}