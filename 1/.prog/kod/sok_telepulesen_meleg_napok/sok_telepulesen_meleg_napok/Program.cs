using System;

namespace sok_telepulesen_meleg_napok {
    internal class Program {
        static void Main (string[] args) {
            // deklaralas
            int[,] hom;
            int[] napokdb, napok;
            int db;

            // beolvasas
            hom = beolvas_biro();

            // feladat megoldas
            napokdb = masol(hom);
            (db, napok) = kivalogat(hom, napokdb);

            // kiiras
            kiir(db, napok);
        }

        static int[,] beolvas () {
            if (Console.IsInputRedirected) {
                return beolvas_biro();
            } else {
                return beolvas_kezi();
            }
        }

        static int[,] beolvas_biro () {
            string[] sor = Console.ReadLine().Split(" ");
            int n = int.Parse(sor[0]);
            int m = int.Parse(sor[1]);
            int[,] hom = new int[n + 1, m + 1];
            for (int i = 1; i <= n; ++i) {
                sor = Console.ReadLine().Split(" ");
                for (int j = 1; j <= m; ++j) {
                    hom[i, j] = int.Parse(sor[j - 1]);
                }
            }
            return hom;
        }

        static int[,] beolvas_kezi () {
            int n, m;
            bool jo;
            do {
                Console.ResetColor();
                Console.Write("Települések száma = ");
                jo = int.TryParse(Console.ReadLine(), out n) && n >= 0;
                if (!jo) {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Természetes szám kell!");
                }
            } while (!jo);
            do {
                Console.ResetColor();
                Console.Write("napok száma = ");
                jo = int.TryParse(Console.ReadLine(), out m) && m >= 0;
                if (!jo) {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Természetes szám kell!");
                }
            } while (!jo);
            int[,] hom = new int[n + 1, m + 1];
            for (int i = 1; i <= n; ++i) {
                for (int j = 1; j <= m; ++j) {
                    do {
                        Console.ResetColor();
                        Console.Write("{0}. település {1}. nap hőmérséklete = ", i, j);
                        jo = int.TryParse(Console.ReadLine(), out hom[i, j]) && hom[i, j] >= -50 && hom[i, j] <= 50;
                        if (!jo) {
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine("a hőmérsékletnek -50 és 50 fok között kell lennie!");
                        }
                    } while (!jo);
                }
            }
            return hom;
        }

        static int nagyobb(int index, int[,] hom) {
            int n = hom.GetLength(0) - 1;
            
            int db = 0;
            for (int i = 1; i <= n; ++i) {
                if (hom[i, index] >= 30) {
                    ++db;
                }
            }
            return db;
        }

        static int[] masol (int[,] hom) {
            int m = hom.GetLength(1) - 1;
            int[] napokdb = new int[m + 1];

            for(int i = 1; i <= m; ++i) {
                napokdb[i] = nagyobb(i, hom);
            }
            return napokdb;
        }

        static (int db, int[] napok) kivalogat (int[,] hom, int[] napokdb) {
            int n = hom.GetLength(0) - 1;
            int m = hom.GetLength(1) - 1;
            int[] napok = new int[n + 1];

            int db = 0;
            for (int i = 1; i <= m; ++i) {
                if (napokdb[i] >= (n + 1) / 2) { // a specifikacio ezek szerint felfele kerekit, de a c# nem. Emiatt csak akkor mukodik ez jol ha nem engedem meg az egyenloseget
                                                 // tehat ha ellentmondok a dokumentacionak.
                                                 // Taps azoknak akik megirtak ezt a retardalt specifikacio szerkesztot, egyenek homokot

                                                 // ha nem ertened esetleg akkor ha > helyett >= raksz akkor a harmadik napot is kivalogatja mert 1 > 3 / 2 (ahol 3/2 = 1, mivel 1.5 lenne de a pontot es az azt koveto szamokat lehgyja).
                                                 // igy 1 >= 1 mert fogyatekos
                                                 // szerintem van egy utad Klettner emailjebe

                                                 // illetve azt is gondold at nagyon jol hogy lehet hogy a masolas es a kivalogatast egy fuggvenybe kell rakni mert ugy rajzoltad ki a stukit
                                                 // ha viszont egy fuggvenybe rakod akkor az egesz kodot ugy at kell irni ahogy van. En csak a ketto kozul valasztottam egyet de te tudod.
                    ++db;
                    napok[db] = i;
                }
            }
            return (db, napok);
        }

        static void kiir (int db, int[] napok) {
            if (true) {
                Console.WriteLine(db);
                for (int i = 1; i <= db; i++) {
                    Console.Write("{0} ", napok[i]);
                }
                Console.WriteLine();
            } else {
                Console.ForegroundColor = ConsoleColor.Green;
                if (db == 0) {
                    Console.WriteLine("Nincs a feltételnek megfelelő település!");
                } else {
                    Console.WriteLine("{0} darab feltételnek megfelelő település is van, sorszámaik:", db);
                    for (int i = 1; i < db; ++i) {
                        Console.Write("{0}, ", napok[i]);
                    }
                    Console.WriteLine(napok[db]);
                }
                Console.ForegroundColor = ConsoleColor.Black;
                Console.BackgroundColor = ConsoleColor.Gray;
                Console.WriteLine("Kérem, nyomjon ENTER-t a folytatáshoz!");
                Console.ResetColor();
                Console.ReadLine();
            }
        }
    }
}
