using System;

namespace MintaZH2 {
    internal class Program {
        public struct Lakas {
            public int ter, ar;
        }
        static void Main (string[] args) {
            int i; string[] line;
            int n, nagyArInd, dragaDb, nagyArErt, hanyfele;
            bool van;

            int.TryParse(Console.ReadLine(), out n);

            Lakas[] arr = new Lakas[n + 1];
            int[] draga = new int[n + 1];

            for (i = 1; i < n; ++i) {
                line = Console.ReadLine().Split(' ');

                int.TryParse(line[0], out arr[i].ter);
                int.TryParse(line[1], out arr[i].ar);
            }

            a(out dragaDb, ref draga, i, n, arr);
            B(out van, i, n, arr, out nagyArErt, out nagyArInd);
            c(out hanyfele, i, n, arr);
            kiir(dragaDb, draga, nagyArErt, hanyfele);
        }

        static void a (out int dragaDb, ref int[] draga, int i, int n, Lakas[] arr) {
            dragaDb = 0;
            for (i = 1; i <= n; ++i) {
                if (arr[i].ar > 100) {
                    ++dragaDb;
                    draga[dragaDb] = i;
                }
            }
        }

        static void B (out bool van, int i, int n, Lakas[] arr, out int nagyArErt, out int nagyArInd) {
            van = false;
            nagyArErt = 0;
            nagyArInd = 0;
            for (i = 1; i < n; ++i) {
                if (van && arr[i].ter > 100) {
                    if (nagyArErt < arr[i].ar) {
                        nagyArInd = i;
                        nagyArErt = arr[i].ar;
                    }
                } else if (!van && arr[i].ter > 100) {
                    nagyArInd = i;
                    nagyArErt = arr[i].ar;
                    van = true;
                }
            }
            if (!van) {
                nagyArErt = 0;
            }
        }

        static bool eldont (int i, int n, Lakas[] arr) {
            int j = 1;
            while (j <= n && arr[j].ter != arr[i].ter) {
                ++j;
            }
            return j > n;
        }

        static void c (out int hanyfele, int i, int n, Lakas[] arr) {
            hanyfele = 0;
            for (i = 1; i < n; ++i) {
                if (eldont(i, n, arr)) {
                    ++hanyfele;
                }
            }
        }

        static void kiir(int dragaDb, int[] draga, int nagyArErt, int hanyfele) {
            if(dragaDb != 0) { ++dragaDb; }
            Console.Write("{0} ", dragaDb);
            for(int i = 1; i <= dragaDb; ++i) {
                Console.Write("{0} ", draga[i]);
            }
            Console.WriteLine(draga[dragaDb + 1]);
            //Console.WriteLine(nagyArErt);
            //Console.WriteLine(hanyfele);
        }
    }
}
