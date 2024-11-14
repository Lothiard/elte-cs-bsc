using System;

namespace Tanorak {
    public struct Tora {
        public string targynev, osztaly;
        public int tanar, oraszam;
    }
    internal class Program {
        static void Main(string[] args) {
            // deklaralas
            // Be
            int n;
            int t;
            string oa;
            string[] tanar;
            Tora[] orak;

            // Sa
            int maxoraszam;
            int maxtanardb;
            string[] maxtanarok;

            // Ki
            int[] osszoraszam;
            string maxtanar;
            int osztalyoraidb;
            string[] osztalyorai;
            int targyakdb;
            string[] targyak;

            // beolvasas
            beolvas(out n, out t, out oa, out tanar, out orak, out maxtanarok, out osszoraszam, out osztalyorai, out targyak);

            // feladatmegoldas
            // a) feladat
            a_feladat(ref osszoraszam, ref t, ref orak, ref n);

            kiiras(t, ref osszoraszam);

        }

        static void beolvas(out int n, out int t, out string oa, out string[] tanar, out Tora[] orak, out string[] maxtanarok, out int[] osszoraszam, out string[] osztalyorai, out string[] targyak) {
            string[] temp = Console.ReadLine().Split(' ');
            int.TryParse(temp[0], out n);
            int.TryParse(temp[1], out t);
            oa = temp[2];

            tanar = new string[t];
            orak = new Tora[n];
            maxtanarok = new string[t];
            osszoraszam = new int[t];
            osztalyorai = new string[n];
            targyak = new string[t];


            for (int i = 1; i <= t; ++i) {
                tanar[i - 1] = Console.ReadLine();
            }

            for (int i = 1; i <= n; ++i) {
                orak[i - 1].targynev = Console.ReadLine();
                int.TryParse(Console.ReadLine(), out orak[i - 1].tanar);
                int.TryParse(Console.ReadLine(), out orak[i - 1].oraszam);
                orak[i - 1].osztaly = Console.ReadLine();
            }
        }
        static void a_feladat(ref int[] osszoraszam, ref int t, ref Tora[] orak, ref int n) {
            for (int i = 1; i <= t; ++i) {
                osszoraszam[i - 1] = tanaroraszam(i - 1, ref orak, n);
            }
        }

        static int tanaroraja(int tanar, int ora, ref Tora[] orak) {
            return tanar == orak[ora - 1].tanar ? orak[ora - 1].oraszam : 0;
        }

        static int tanaroraszam(int tanarIndex, ref Tora[] orak, int n) {
            int temp = 0;
            for (int i = 1; i <= n; ++i) {
                temp += tanaroraja(tanarIndex, i, ref orak);
            }
            return temp;
        }

        static void kiiras(int t, ref int[] osszoraszam) {
            for(int i = 1; i <= t; ++i) {
                Console.WriteLine(osszoraszam[i - 1]);
            }
        }
    }
}
