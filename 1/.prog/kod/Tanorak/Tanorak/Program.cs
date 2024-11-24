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
            int n, t, i;
            string oa, s;
            string[] temp;

            // beolvasas
            temp = Console.ReadLine().Split(' ');
            int.TryParse(temp[0], out n);
            int.TryParse(temp[1], out t);
            oa = temp[2];

            Tora[] orak = new Tora[n + 1];
            string[] tanar = new string[t + 1];


            for (i = 1; i <= t; ++i) {
                tanar[i - 1] = Console.ReadLine();
            }


            for (i = 1; i <= n; ++i) {
                orak[i - 1].targynev = Console.ReadLine();
                int.TryParse(Console.ReadLine(), out orak[i - 1].tanar);
                int.TryParse(Console.ReadLine(), out orak[i - 1].oraszam);
                orak[i - 1].osztaly = Console.ReadLine();
            }

            // Sa
            int maxoraszam, maxtanardb;
            string[] maxtanarok = new string[t + 1];


            // Ki
            int[] osszoraszam = new int[t + 1];
            string maxtanar;
            string[] osztalyorai = new string[t + 1];
            int osztalyoraidb;
            string[] targyak = new string[t + 1];
            int targyakdb;

            // feladatmegoldas
            a_feladat(i, t, ref osszoraszam, orak);
            b_feladat(i, out maxoraszam, orak, n, out maxtanardb, maxtanarok, tanar, out maxtanar);
            c_feladat(i, out osztalyoraidb, n, orak, oa, osztalyorai);
            d_feladat(i, out targyakdb, n, orak, targyak);

            // kiiras
            kiiras(i, t, osszoraszam, maxtanar, osztalyoraidb, osztalyorai, targyakdb, targyak);

        }

        // a) feladat
        static void a_feladat(int i, int t, ref int[] osszoraszam, Tora[] orak) {
            for (i = 1; i <= t; ++i) {
                osszoraszam[i - 1] = tanaroraszam(i, orak);
            }
        }

        static int tanaroraszam(int tanar, Tora[] orak) {
            int s = 0;
            for (int i = 1; i <= orak.Length - 1; ++i) {
                s += tanaroraja(tanar, i, orak);
            }
            return s;
        }

        static int tanaroraja(int tanar, int ora, Tora[] orak) {
            int res;
            if (tanar == orak[ora - 1].tanar) {
                 res = orak[ora - 1].oraszam;
            } else {
                res = 0;
            }

            return res;
        }

        // b) feladat
        static void b_feladat(int i, out int maxoraszam, Tora[] orak, int n, out int maxtanardb, string[] maxtanarok, string[] tanar, out string maxtanar) {
            maxoraszam = orak[1 - 1].oraszam;
            for (i = 1 + 1; i <= n; ++i) {
                if(maxoraszam < orak[i - 1].oraszam) {
                    maxoraszam = orak[i - 1].oraszam;
                }
            }

            maxtanardb = 0;
            for (i = 1; i <= n; ++i) {
                if (orak[i - 1].oraszam == maxoraszam) {
                    ++maxtanardb;
                    maxtanarok[maxtanardb - 1] = tanar[orak[i - 1].tanar - 1];
                }
            }

            maxtanar = maxtanarok[1 - 1];
            for (i = 1 + 1; i <= maxtanardb; ++i) {
                if (maxtanar.CompareTo(maxtanarok[i - 1]) > 0) { // valami nem jo
                    maxtanar = maxtanarok[i - 1];
                }
            }
        }

        // c) feladat
        static void c_feladat(int i, out int osztalyoraidb, int n, Tora[] orak, string oa, string[] osztalyorai) {
            osztalyoraidb = 0;
            for (i = 1; i <= n; ++i) {
                if (orak[i - 1].osztaly == oa) {
                    ++osztalyoraidb;
                    osztalyorai[osztalyoraidb - 1] = orak[i - 1].targynev;
                }
            }
        }

        // d) feladat
        static void d_feladat(int i, out int targyakdb, int n, Tora[] orak, string[] targyak) {
            targyakdb = 0;
            for (i = 1; i <= n; ++i) {
                if(elso(i, orak)) {
                    ++targyakdb;
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

        static void kiiras(int i, int t, int[] osszoraszam, string maxtanar, int osztalyoraidb, string[] osztalyorai, int targyakdb, string[] targyak) {
            // a) feladat
            for (i = 1; i <= t; ++i) {
                Console.Write("{0} ", osszoraszam[i - 1]);
            }
            Console.WriteLine();

            // b) feladat
            Console.WriteLine(maxtanar);

            // c) feladat
            Console.Write(osztalyoraidb);
            for (i = 1; i <= osztalyoraidb; ++i) {
                Console.Write(",{0}", osztalyorai[i - 1]);
            }
            Console.WriteLine();

            // d) feladat
            Console.Write(targyakdb);
            for (i = 1; i <= targyakdb; ++i) {
                Console.Write(",{0}", targyak[i - 1]);
            }
            Console.WriteLine();
        }
    }
}
 