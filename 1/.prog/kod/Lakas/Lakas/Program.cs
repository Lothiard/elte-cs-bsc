using System;

namespace Lakas {
    internal class Program {
        public struct Lakas {
            public int ter;
            public int ar;
        }
        static void Main(string[] args) {
            // deklaralas
            int i;
            string[] sor;
            // Be
            int n;

            // Ki
            int draga, nagydb, hanyfele, szazdb;

            // beolvasas
            int.TryParse(Console.ReadLine(), out n);
            Lakas[] t = new Lakas[n];
            int[] szaz = new int[n];

            for(i = 1; i <= n; ++i) {
                sor = Console.ReadLine().Split(' ');

                int.TryParse(sor[0], out t[i - 1].ter);
                int.TryParse(sor[1], out t[i - 1].ar);
            }

            // feladatmegoldas
            a(out draga, i, n, t);
            b(out nagydb, i, n, t);
            c(out hanyfele, i, n, t);
            d(out szazdb, i, n, t, ref szaz);
            kiiras(draga, nagydb, hanyfele, szazdb, szaz);
        }

        static void a (out int draga, int i, int n, Lakas[] t) {
            int maxert = t[0].ar;
            draga = 0;
            for (i = 1; i <= n; ++i) {
                if (maxert < t[i - 1].ar) {
                    maxert = t[i - 1].ar;
                    draga = i;
                }
            }
        }

        static void b(out int nagydb, int i, int n, Lakas[] t) {
            nagydb = 0;
            for(i = 1; i <= n; ++i) {
                if (t[i - 1].ar < 40 && t[i - 1].ter > 100) {
                    ++nagydb;
                }
            }
        }

        static bool voltmar(int i, Lakas[] t) {
            int j = 1;
            while (j - 1 <= i && t[i - 1].ter != t[j - 1].ter) {
                ++j;
            }
            return j > i - 1;
        }

        static void c(out int hanyfele, int i, int n, Lakas[] t) {
            hanyfele = 0;
            for(i = 1; i <= n; ++i) {
                if(voltmar(i, t)) {
                    ++hanyfele;
                }
            }
        }

        static void d(out int szazdb, int i, int n, Lakas[] t, ref int[] szaz) {
            szazdb = 0;
            for(i = 1; i <= n; ++i) {
                if (t[i - 1].ar > 100) {
                    ++szazdb;
                    szaz[szazdb - 1] = i;
                }
            }
        }

        static void kiiras(int draga, int nagydb, int hanyfele, int szazdb, int[] szaz) {
            Console.WriteLine(draga);
            Console.WriteLine(nagydb);
            Console.WriteLine(hanyfele);
            Console.Write("{0} ", szazdb);
            for (int i = 0; i < szazdb; ++i) {
                Console.Write("{0} ", szaz[i]);
            }
        }
    }
}
