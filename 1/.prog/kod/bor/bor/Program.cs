using System;
using System.Data;

namespace bor {
    internal class Program {
        public struct T {
            public int term, ar;
        }
        static void Main (string[] args) {
            // deklaralas, beolvasas
            int i;
            string[] temp = new string[2];
            int n;
            int.TryParse(Console.ReadLine(), out n);

            T[] bor = new T[n + 1];
            int minert;
            int nagyevdb;
            int[] nagyev = new int[n + 1];
            int termmin;
            int nagyevmax;
            int kulondb;
            int rekorddb;
            int[] rekord = new int[n + 1];

            for (i = 1; i <= n; ++i) {
                temp = Console.ReadLine().Split(' ');

                int.TryParse(temp[0], out bor[i].term);
                int.TryParse(temp[1], out bor[i].ar);
            }

            // feladat
            a1(out termmin, out minert, bor, i, n);
            b1(out nagyevdb, i, n, bor, ref nagyev);
            b2(out nagyevmax, nagyev, i, nagyevdb);
            c1(out kulondb, i, n, bor);
            d1(out rekorddb, i, n, ref rekord, bor);

            // kiiras
            Console.WriteLine(termmin);
            Console.WriteLine(nagyevmax);
            Console.WriteLine(kulondb);
            Console.Write(rekorddb);
            for(i = 1; i <= rekorddb; ++i) {
                Console.Write("{0} ", rekord[i]);
            }
        }

        static void a1 (out int termmin, out int minert, T[] bor, int i, int n) {
            termmin = 1;
            minert = bor[1].term;
            for (i = 1+1; i <= n; ++i) {
                if (minert > bor[i].term) {
                    minert = bor[i].term;
                    termmin = i;
                }
            }
        }

        static void b1 (out int nagyevdb, int i, int n, T[] bor, ref int[] nagyev) {
            nagyevdb = 0;
            for(i = 1; i <= n; ++i) {
                if (bor[i].term > 1000) {
                    ++nagyevdb;
                    nagyev[nagyevdb] = bor[i].ar;
                }
            }
        }

        static void b2(out int nagyevmax, int[] nagyev, int i, int nagyevdb) {
            nagyevmax = nagyev[1];
            for(i = 1+1; i <= nagyevdb; ++i) {
                if(nagyevmax < nagyev[i]) {
                    nagyevmax = nagyev[i];
                }
            }
        }

        static bool voltmar(int ind, int i, T[] bor) {
            i = 1;
            while(i <= ind - 1 && bor[i].ar != bor[ind].ar) {
                ++i;
            }
            return i > ind - 1;
        }

        static void c1 (out int kulondb, int i, int n, T[] bor) {
            kulondb = 0;
            for (i = 1; i <= n; ++i) {
                if (voltmar(i, i, bor)) {
                    ++kulondb;
                }
            }
        }

        static bool ujrekord(int ind, int i, T[] bor) {
            i = 1;
            while(i <= ind - 1 && bor[i].term < bor[ind].term) {
                ++i;
            }
            return i > ind - 1;
        }

        static void d1 (out int rekorddb, int i, int n, ref int[] rekord, T[] bor) {
            rekorddb = 0;
            for(i = 1; i <= n; ++i) {
                if(ujrekord(i, i, bor)) {
                    ++rekorddb;
                    rekord[rekorddb] = i;
                }
            }
        }
    }
}
