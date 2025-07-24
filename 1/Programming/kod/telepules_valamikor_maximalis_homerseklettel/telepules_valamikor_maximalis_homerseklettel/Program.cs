/*
  Készítette: Restye János Barnabás
  Neptun: F8U9I2
  E-mail: f8u9i2@inf.elte.hu
  Feladat: települések, amelyeken előfordul valamelyik napi előrejelzések maximuma
*/

using System;

namespace telepules_valamikor_maximalis_homerseklettel {
    internal class Program {
        static void Main (string[] args) {
            // deklaralas
            int maxho, db;
            int[,] ho;
            int[] y;

            // beolvasas
            ho = beolvas();

            // megoldas
            maxho = max(ho);
            (db, y) = kivalaszt(ho, maxho);

            // kiiras
            kiir(db, y);
        }

        static int[,] beolvas () {
            if (Console.IsInputRedirected) {
                return beolvas_biro();
            } else {
                return beolvas_kezi();
            }
        }
        static int[,] beolvas_biro () {
            string[] line = Console.ReadLine().Split(' ');
            int n = int.Parse(line[0]);
            int m = int.Parse(line[1]);

            int[,] ho = new int[n + 1, m + 1];

            for (int i = 1; i <= n; ++i) {
                line = Console.ReadLine().Split(' ');
                for (int j = 1; j <= line.Length; ++j) {
                    int.TryParse(line[j - 1], out ho[i, j]);
                }
            }
            return ho;
        }

        static int[,] beolvas_kezi () {
            int n, m;
            bool jo;
            do {
                Console.ResetColor();
                Console.Write("Települések száma = ");
                jo = int.TryParse(Console.ReadLine(), out n) && n >= 1 && n <= 1000;
                if (!jo) {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("A települések számának 1 és 1000 közé kell esnie!");
                }
            } while (!jo);
            do {
                Console.ResetColor();
                Console.Write("Napok száma = ");
                jo = int.TryParse(Console.ReadLine(), out m) && m >= 1 && m <= 1000;
                if (!jo) {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("A napok számának 1 és 1000 közé kell esnie!");
                }
            } while (!jo);

            int[,] ho = new int[n + 1, m + 1];
            for (int i = 1; i <= n; ++i) {
                for (int j = 1; j <= m; ++j) {
                    do {
                        Console.ResetColor();
                        Console.Write("{0}. település {1}. nap hőmérséklete = ", i, j);
                        jo = int.TryParse(Console.ReadLine(), out ho[i, j]) && ho[i, j] >= -50 && ho[i, j] <= 50;
                        if (!jo) {
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine("A hőfoknak -50 és 50 közé kell esnie!");
                        }
                    } while (!jo);
                }
            }
            return ho;
        }

        static int max (int[,] ho) {
            int n = ho.GetLength(0) - 1;
            int m = ho.GetLength(1) - 1;

            int maxho = ho[1, 1];
            for (int i = 1 + 1; i <= n * m; ++i) {
                if (maxho < ho[(i - 1) / m + 1, (i - 1) % m + 1]) {
                    maxho = ho[(i - 1) / m + 1, (i - 1) % m + 1];
                }
            }
            return maxho;
        }

        static bool bennevan (int sor, int[,] ho, int maxho) {
            int m = ho.GetLength(1) - 1;

            bool van = false;
            int j = 1;
            while (!van && j <= m) {
                if (ho[sor, j] == maxho) {
                    van = true;
                } else {
                    ++j;
                }
            }
            return van;
        }

        static (int db, int[] y) kivalaszt (int[,] ho, int maxho) {
            int n = ho.GetLength(0) - 1;
            int[] y = new int[n + 1];

            int db = 0;
            for (int i = 1; i <= n; ++i) {
                if (bennevan(i, ho, maxho)) {
                    ++db;
                    y[db] = i;
                }
            }
            return (db, y);
        }

        static void kiir (int db, int[] y) {
            if (Console.IsInputRedirected) {
                Console.Write("{0} ", db);
                for (int i = 1; i <= db; ++i) {
                    Console.Write("{0} ", y[i]);
                }
            } else {
                Console.ForegroundColor = ConsoleColor.Green;
                if (db == 0) {
                    Console.WriteLine("Nincs a feltételnek megfelelő település!");
                } else {
                    Console.WriteLine("{0} darab feltételnek megfelelő település is van, sorszámaik:", db);
                    for (int i = 1; i < db; ++i) {
                        Console.Write("{0}, ", y[i]);
                    }
                    Console.WriteLine(y[db]);
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
