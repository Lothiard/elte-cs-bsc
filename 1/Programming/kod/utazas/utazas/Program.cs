using System;

namespace utazas {
    internal class Program {
        public struct Utazas {
            public int tav, ar;
        }

        static void Main (string[] args) {
            // deklaralas
            int i;
            string[] temp = new string[2];
            int n, kozelidb, tavmaxind, dragamax, hanyfele, aranydb;

            int.TryParse(Console.ReadLine(), out n);
            Utazas[] jegy = new Utazas[n + 1];
            int[] kozeli = new int[n + 1];
            int[] hanyszor = new int[n + 1];
            int[] arany = new int[n + 1];

            for (i = 1; i <= n; ++i) {
                temp = Console.ReadLine().Split(' ');
                int.TryParse(temp[0], out jegy[i].tav);
                int.TryParse(temp[1], out jegy[i].ar);
            }

            // feladatmegoldas
            a(out tavmaxind, i, n, jegy);
            b1(out kozelidb, ref kozeli, i, n, jegy);
            b2(out dragamax, kozeli, i, n);
            c1(i, n, ref hanyszor, jegy);
            c2(out hanyfele, i, n, hanyszor);
            d(out aranydb, i, n, jegy, ref arany);

            // kiiras
            Console.WriteLine(tavmaxind);
            Console.WriteLine(dragamax);
            Console.WriteLine(hanyfele);
            Console.Write("{0} ", aranydb);
            if (aranydb > 0) {
                for(i = 1; i <= aranydb; ++i) {
                    Console.Write("{0} ", arany[i]);
                }
            }
        }

        static void a(out int tavmaxind, int i, int n, Utazas[] jegy) {
            tavmaxind = 1;
            int maxert = jegy[1].tav;
            for (i = 1 + 1; i <= n; ++i) {
                if (jegy[i].tav > maxert) {
                    tavmaxind = i;
                    maxert = jegy[i].tav;
                }
            }
        }

        static void b1(out int kozelidb, ref int[] kozeli, int i, int n, Utazas[] jegy) {
            kozelidb = 0;
            for(i = 1; i <= n; ++i) {
                if (jegy[i].tav < 1000) {
                    ++kozelidb;
                    kozeli[kozelidb] = jegy[i].ar;
                }
            }
        }

        static void b2(out int dragamax, int[] kozeli, int i, int n) {
            dragamax = kozeli[1];
            for(i = 1; i <= n; ++i) {
                if (kozeli[i] > dragamax) {
                    dragamax = kozeli[i];
                }
            }
        }

        static int ismetlodik(int ind, int i, int n, Utazas[] jegy) {
            int db = 0;
            for(i = 1; i <= n; ++i) {
                if (jegy[ind].ar == jegy[i].ar) {
                    ++db;
                }
            }
            return db;
        }

        static void c1(int i, int n, ref int[] hanyszor, Utazas[] jegy) {
            for(i = 1; i <= n; ++i) {
                hanyszor[i - 1 + 1] = ismetlodik(i, i, n, jegy);
            }
        }

        static void c2(out int hanyfele, int i, int n, int[] hanyszor) {
            hanyfele = 0;
            for(i = 1; i <= n; ++i) {
                if (hanyszor[i] == 1) {
                    ++hanyfele;
                }
            }
        }

        static void d(out int aranydb, int i, int n, Utazas[] jegy, ref int[] arany) {
            aranydb = 0;
            for(i = 1; i <= n; ++i) {
                if (jegy[i].ar / jegy[i].tav > 100) {
                    ++aranydb;
                    arany[aranydb] = i;
                }
            }
        }
    }
}
