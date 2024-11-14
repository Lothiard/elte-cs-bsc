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
            a_feladat(t, n, orak, ref osszoraszam);
            b_feladat(out maxoraszam, orak, n, out maxtanardb, maxtanarok, tanar, out maxtanar);
            c_feladat(out osztalyoraidb, n, orak, oa, osztalyorai);
            d_feladat(out targyakdb, n, orak, targyak);

            // kiiras
            kiiras(t, osszoraszam, maxtanar, osztalyoraidb, osztalyorai, targyakdb, targyak);

        }

        // beolvas
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

        // a) feladat
        static void a_feladat(int t, int n, Tora[] orak, ref int[] osszoraszam) {
            for (int i = 1; i <= t; ++i) {
                osszoraszam[i - 1] = tanaroraszam(i, n, orak);
            }
        }

        static int tanaroraszam(int tanar, int n, Tora[] orak) {
            int tanaroraszam = 0;
            for (int i = 1; i <= n; ++i) {
                tanaroraszam += tanaroraja(tanar, i, orak);
            }
            return tanaroraszam;
        }

        static int tanaroraja(int tanar, int ora, Tora[] orak) {
            if (tanar == orak[ora - 1].tanar) {
                return orak[ora - 1].oraszam;
            } else {
                return 0;
            }
        }

        // b) feladat
        static void b_feladat(out int maxoraszam, Tora[] orak, int n, out int maxtanardb, string[] maxtanarok, string[] tanar, out string maxtanar) {
            maxoraszam = orak[1 - 1].oraszam;
            for (int i = 1 + 1; i <= n; ++i) {
                if(maxoraszam > orak[i - 1].oraszam) {
                    maxoraszam = orak[i - 1].oraszam;
                }
            }

            maxtanardb = 0;
            for (int i = 1; i <= n; ++i) {
                if (orak[i - 1].oraszam == maxoraszam) {
                    maxtanardb++;
                    maxtanarok[maxtanardb - 1] = tanar[orak[i - 1].tanar - 1];
                }
            }

            maxtanar = maxtanarok[1 - 1];
            for (int i = 1 + 1; i <= maxtanardb; ++i) {
                if (String.Compare(maxtanar, maxtanarok[i - 1], StringComparison.Ordinal) < 0) { // valami nem jo
                    maxtanar = maxtanarok[i - 1];
                }
            }
        }

        // c) feladat
        static void c_feladat(out int osztalyoraidb, int n, Tora[] orak, string oa, string[] osztalyorai) {
            osztalyoraidb = 0;
            for (int i = 1; i <= n; ++i) {
                if (orak[i - 1].osztaly == oa) {
                    osztalyoraidb++;
                    osztalyorai[osztalyoraidb - 1] = orak[i - 1].targynev;
                }
            }
        }

        // d) feladat
        static void d_feladat(out int targyakdb, int n, Tora[] orak, string[] targyak) {
            targyakdb = 0;
            for (int i = 1; i < n; ++i) {
                if(elso(i, orak)) {
                    targyakdb++;
                    targyak[targyakdb - 1] = orak[i - 1].targynev;
                }
            }
        }

        static bool elso(int ora, Tora[] orak) {
            int i = 1;
            while (i <= ora - 1 && orak[i - 1].targynev != orak[ora - 1].targynev) {
                i++;
            }
            return i > ora - 1;
        }

        static void kiiras(int t, int[] osszoraszam, string maxtanar, int osztalyoraidb, string[] osztalyorai, int targyakdb, string[] targyak) {
            // a) feladat
            for (int i = 1; i <= t; ++i) {
                Console.Write(osszoraszam[i - 1] + " ");
            }
            Console.WriteLine();

            // b) feladat
            Console.WriteLine(maxtanar);

            // c) feladat
            Console.Write(osztalyoraidb);
            for (int i = 1; i <= osztalyorai.Length; ++i) {
                Console.Write("," + osztalyorai[i - 1]); // TODO fix ,,,,
            }
            Console.WriteLine();

            // d) feladat
            Console.Write(targyakdb);
            for (int i = 1; i <= targyak.Length; ++i) {
                Console.Write("," + targyak[i - 1]); // TODO fix bad result
            }
            Console.WriteLine();
        }
    }
}
 