using System;

namespace Kezilabda {
    internal class Program {
        public struct Gol {
            public string orsz;
            public int loves, golok, eff;
        }

        static void Main(string[] args) {
            int jdb, gyakoriOrszInd, maxert, legalabb100, orszagLovesMax, hatekony;
            string orszag, gyakoriOrsz;
            bool van, vanmax, vankeres;

            string[] line;
            int i;

            line = Console.ReadLine().Split(' ');
            int.TryParse(line[0], out jdb);
            orszag = line[1];

            Gol[] arr = new Gol[jdb + 1];
            int[] elofordulas = new int[jdb + 1];

            for (i = 1; i <= jdb; ++i) {
                line = Console.ReadLine().Split(' ');
                arr[i].orsz = line[0];
                int.TryParse(line[1], out arr[i].loves);
                int.TryParse(line[2], out arr[i].golok);
                int.TryParse(line[3], out arr[i].eff);
            }

            a(out van, out legalabb100, jdb, arr);
            b(out vanmax, i, jdb, arr, orszag, out orszagLovesMax);
            c(out vankeres, out hatekony, jdb, arr);
            d1(i, jdb, ref elofordulas, arr);
            d2(out gyakoriOrszInd, out maxert, i, jdb, elofordulas, out gyakoriOrsz, arr);
            kiir(legalabb100, orszagLovesMax, hatekony, gyakoriOrsz);
        }

        static void a(out bool van, out int legalabb100, int jdb, Gol[] arr) {
            van = false;
            legalabb100 = 1;
            while (!van && legalabb100 <= jdb) {
                if (arr[legalabb100].golok > 100) {
                    van = true;
                } else {
                    ++legalabb100;
                }
            }
            if(!van) {
                legalabb100 = -1;
            }
        }

        static void b(out bool vanmax, int i, int jdb, Gol[] arr, string orszag, out int orszagLovesMax) {
            vanmax = false;
            orszagLovesMax = 0;
            for (i = 1; i <= jdb; ++i) {
                if(vanmax && arr[i].orsz == orszag) {
                    if(orszagLovesMax < arr[i].loves) {
                        orszagLovesMax = arr[i].loves;
                    }
                } else if(!vanmax && arr[i].orsz == orszag) {
                    vanmax = true;
                    orszagLovesMax = arr[i].loves;
                }
            }
            if (!vanmax) {
                orszagLovesMax = -1;
            }
        }

        static bool elozoek (int i, Gol[] arr) {
            int j = i - 3;
            while(j <= i - 1 && arr[j].eff < arr[i].eff) {
                ++j;
            }
            return j > i - 1;
        }

        static void c(out bool vankeres, out int hatekony, int jdb, Gol[] arr) {
            vankeres = false;
            hatekony = 4;
            while(!vankeres && hatekony <= jdb) {
                if(elozoek(hatekony, arr)) {
                    vankeres = true;
                } else {
                    ++hatekony;
                }
            }
            if(!vankeres) {
                hatekony = -1;
            }
        }

        static int szamolo (int i, int jdb, Gol[] arr) {
            int db = 0;
            for(int j = 1; j <= jdb; ++j) {
                if (arr[j].orsz == arr[i].orsz) {
                    ++db;
                }
            }
            return db;
        }

        static void d1(int i, int jdb, ref int[] elofordulas, Gol[] arr) {
            for(i = 1; i <= jdb; ++i) {
                elofordulas[i - 1 + 1] = szamolo(i, jdb, arr);
            }
        }

        static void d2(out int GyakoriOrszInd, out int maxert, int i, int jdb, int[] elofordulas, out string GyakoriOrsz, Gol[] arr) {
            GyakoriOrszInd = 1;
            maxert = elofordulas[1];
            for(i = 1 + 1; i <= jdb; ++i) {
                if(maxert < elofordulas[i]) {
                    maxert = elofordulas[i];
                    GyakoriOrszInd = i;
                }
            }
            GyakoriOrsz = arr[GyakoriOrszInd].orsz;
        }

        static void kiir(int legalabb100, int orszagLovesMax, int hatekony, string gyakoriOrsz) {
            Console.WriteLine("#");
            Console.WriteLine(legalabb100);
            Console.WriteLine("#");
            Console.WriteLine(orszagLovesMax); 
            Console.WriteLine("#");
            Console.WriteLine(hatekony);
            Console.WriteLine("#");
            Console.WriteLine(gyakoriOrsz);
        }
    }
}
