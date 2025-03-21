﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace magas_szintu_ck {
    public static class Mintak {
        #region Összegzés
        #region Általános összegzés
        public static G Szumma<H, G> (int e, int u, Func<int, H> f, G kezd, Func<G, H, int, G> add) {
            G s = kezd;
            for (int i = e; i <= u; i++) {
                s = add(s, f(i), i);
            }
            return s;
        }
        public static G Szumma<H, G> (int e, int u, Func<int, H> f, G kezd, Func<G, H, G> add) {
            return Szumma(e, u, f, kezd, (s, p, i) => add(s, p));
        }
        #endregion
        #region Intervallum számok összegzésre
        public static int Szumma (int e, int u, Func<int, int> f) {
            return Szumma(e, u, f, 0, (s, p) => s + p);
        }
        public static double Szumma (int e, int u, Func<int, double> f) {
            return Szumma(e, u, f, 0.0, (s, p) => s + p);
        }
        #endregion
        #region Tömb
        public static G Szumma<H, G> (H[] arr, G kezd, Func<G, H, G> add) {
            return Szumma(0, arr.Length - 1, i => arr[i], kezd, (s, p, i) => add(s, p));
        }
        #endregion
        #region Tömb számok összegzésre
        public static int Szumma<H> (H[] arr, Func<H, int> f) {
            return Szumma(arr, 0, (s, p) => s + f(p));
        }
        public static int Szumma (int[] arr) {
            return Szumma(arr, p => p);
        }
        public static double Szumma<H> (H[] arr, Func<H, double> f) {
            return Szumma(arr, 0.0, (s, p) => s + f(p));
        }
        public static double Szumma (double[] arr) {
            return Szumma(arr, p => p);
        }
        #endregion
        #endregion

        #region Megszámolás
        #region Intervallum
        public static int Darab (int e, int u, Func<int, bool> t) {
            int db = 0;
            for (int i = e; i <= u; i++) {
                if (t(i)) {
                    db++;
                }
            }
            return db;
        }
        #endregion
        #region Tömb
        public static int Darab<H> (H[] arr, Func<H, bool> t) {
            return Darab(0, arr.Length - 1, i => t(arr[i]));
        }
        #endregion
        #endregion

        #region Maximum-, minimumkiválasztás
        #region Max:Intervallum
        public static (int maxind, H maxert) Max<H> (int e, int u, Func<int, H> f, Func<H, H, bool> isGreater = null) {

            bool _isGreater (H a, H b) {
                if (a is IComparable<H> aa) {
                    return aa.CompareTo(b) > 0;
                } else {
                    return isGreater != null ? isGreater(a, b) : false;
                }
            }

            H maxert = f(e);
            int maxind = e;
            for (int i = e + 1; i <= u; i++) {
                if (_isGreater(f(i), maxert)) {
                    maxert = f(i);
                    maxind = i;
                }
            }
            return (maxind, maxert);
        }
        #endregion
        #region Max:Tömb transzformátumfüggvénnyel
        public static (int maxind, G maxert) Max<H, G> (H[] arr, Func<H, G> f, Func<G, G, bool> isGreater = null) {
            return Max(0, arr.Length - 1, i => f(arr[i]), isGreater);
        }
        #endregion
        #region Max:Tömb
        public static (int maxind, H maxert) Max<H> (H[] arr, Func<H, H, bool> isGreater = null) {
            return Max(arr, p => p, isGreater);
        }
        #endregion

        #region Min:Intervallum
        public static (int minind, H minert) Min<H> (int e, int u, Func<int, H> f, Func<H, H, bool> isSmaller = null) {

            bool _isSmaller (H a, H b) {
                if (a is IComparable<H> aa) {
                    return aa.CompareTo(b) < 0;
                } else {
                    return isSmaller != null ? isSmaller(a, b) : false;
                }
            }

            H minert = f(e);
            int minind = e;
            for (int i = e + 1; i <= u; i++) {
                if (_isSmaller(f(i), minert)) {
                    minert = f(i);
                    minind = i;
                }
            }
            return (minind, minert);
        }

        #endregion
        #region Min:Tömb transzformátumfüggvénnyel
        public static (int minind, G minert) Min<H, G> (H[] arr, Func<H, G> f, Func<G, G, bool> isGreater = null) {
            return Min(0, arr.Length - 1, i => f(arr[i]), isGreater);
        }
        #endregion
        #region Min:Tömb
        public static (int minind, H minert) Min<H> (H[] arr, Func<H, H, bool> isGreater = null) {
            return Min(arr, p => p, isGreater);
        }
        #endregion
        #endregion

        #region Feltételes maximum-, minimumkeresés
        #region FeltMax:Intervallum
        public static (bool van, int maxind, H maxert) FeltMax<H> (int e, int u, Func<int, H> f, Func<int, bool> t, Func<H, H, bool> isGreater = null) {

            bool _isGreater (H a, H b) {
                if (a is IComparable<H> aa) {
                    return aa.CompareTo(b) > 0;
                } else {
                    return isGreater != null ? isGreater(a, b) : false;
                }
            }

            bool van = false;
            H maxert = f(e);
            int maxind = e;
            for (int i = e; i <= u; i++) {
                if (van && t(i)) {
                    if (_isGreater(f(i), maxert)) {
                        maxert = f(i);
                        maxind = i;
                    }
                } else if (!van && t(i)) {
                    van = true;
                    maxert = f(i);
                    maxind = i;
                }
            }
            return (van, maxind, maxert);
        }
        #endregion
        #region FeltMax: Tömb transzformátor függvénnyel
        public static (bool van, int maxind, G maxert) FeltMax<H, G> (H[] arr, Func<H, G> f, Func<H, bool> t, Func<G, G, bool> isGreater = null) {
            return FeltMax(0, arr.Length - 1, i => f(arr[i]), i => t(arr[i]), isGreater);
        }
        #endregion
        #region FeltMax:Tömb 
        public static (bool van, int maxind, H maxert) FeltMax<H> (H[] arr, Func<H, bool> t, Func<H, H, bool> isGreater = null) {
            return FeltMax(arr, p => p, t, isGreater);
        }
        #endregion

        #region FeltMin:Intervallum
        public static (bool van, int minind, H minert) FeltMin<H> (int e, int u, Func<int, H> f, Func<int, bool> t, Func<H, H, bool> isSmaller = null) {

            bool _isSmaller (H a, H b) {
                if (a is IComparable<H> aa) {
                    return aa.CompareTo(b) < 0;
                } else {
                    return isSmaller != null ? isSmaller(a, b) : false;
                }
            }

            bool van = false;
            H minert = f(e);
            int minind = e;
            for (int i = e; i <= u; i++) {
                if (van && t(i)) {
                    if (_isSmaller(f(i), minert)) {
                        minert = f(i);
                        minind = i;
                    }
                } else if (!van && t(i)) {
                    van = true;
                    minert = f(i);
                    minind = i;
                }
            }
            return (van, minind, minert);
        }
        #endregion
        #region FeltMin: Tömb transzformátor függvénnyel
        public static (bool van, int minind, G minert) FeltMin<H, G> (H[] arr, Func<H, G> f, Func<H, bool> t, Func<G, G, bool> isSmaller = null) {
            return FeltMin(0, arr.Length - 1, i => f(arr[i]), i => t(arr[i]), isSmaller);
        }
        #endregion
        #region FeltMin:Tömb 
        public static (bool van, int minind, H minert) FeltMin<H> (H[] arr, Func<H, bool> t, Func<H, H, bool> isSmaller = null) {
            return FeltMin(arr, p => p, t, isSmaller);
        }
        #endregion
        #endregion

        #region Keresés
        #region Intervallum
        public static (bool van, int ind) Keres (int e, int u, Func<int, bool> t) {
            int ind = e;
            while (ind <= u && !t(ind)) {
                ind++;
            }
            bool van = ind <= u;
            return (van, ind);
        }
        #endregion
        #region Tömb 
        public static (bool van, int ind) Keres<H> (H[] arr, Func<H, bool> t) {
            return Keres(0, arr.Length - 1, i => t(arr[i]));
        }
        #endregion
        #region Tömb értékkel
        //public static (bool van, int ind, H ertek) Keres<H>(H[] arr, Func<H, int, bool> t) {
        //  var result = Keres(0, arr.Length - 1, i => t(arr[i], i));
        //  return (result.van, result.ind, arr[result.ind]);
        //}
        #endregion
        #endregion

        #region Eldöntés
        #region Intervallum
        public static bool Van (int e, int u, Func<int, bool> t) {
            return Keres(e, u, t).van;
        }
        #endregion
        #region Tömb
        public static bool Van<H> (H[] arr, Func<H, bool> t) {
            return Keres(arr, t).van;
        }
        #endregion

        #region Mind:Intervallum
        public static bool Mind (int e, int u, Func<int, bool> t) {
            return !Keres(e, u, (i) => !t(i)).van;
        }
        #endregion
        #region Mind:Tömb 
        public static bool Mind<H> (H[] arr, Func<H, bool> t) {
            return !Keres(arr, e => !t(e)).van;
        }
        #endregion
        #endregion

        #region Kiválasztás
        #region Intervallum
        public static int Kivalaszt (int e, Func<int, bool> t) {
            return Keres(e, int.MaxValue, t).ind;
        }
        #endregion
        #region Tömb 
        public static int Kivalaszt<H> (H[] arr, Func<H, bool> t) {
            return Keres(arr, t).ind;
        }
        #endregion
        #endregion

        #region Másolás
        #region Intervallum
        public static H[] Masol<H> (int e, int u, Func<int, H> f) {
            return Szumma(e, u, f, new List<H>(), (s, p, i) => {
                s.Add(p);
                return s;
            }).ToArray();
        }
        #endregion
        #region Tömb 
        public static G[] Masol<H, G> (H[] arr, Func<H, G> f) {
            return Masol(0, arr.Length - 1, i => f(arr[i]));
        }
        public static G[] Masol<H, G> (H[] arr, Func<H, int, G> f) {
            return Masol(0, arr.Length - 1, i => f(arr[i], i));
        }
        #endregion
        #endregion

        #region Kiválogatás
        #region Intervallum
        public static H[] Kivalogat<H> (int e, int u, Func<int, bool> t, Func<int, H> f) {
            return Szumma(e, u, f, new List<H>(), (s, p, i) => {
                if (t(i)) {
                    s.Add(p);
                }
                return s;
            }).ToArray();
        }
        #endregion
        #region Tömb
        public static G[] Kivalogat<H, G> (H[] arr, Func<H, bool> t, Func<H, int, G> f) {
            return Kivalogat(0, arr.Length - 1, i => t(arr[i]), i => f(arr[i], i));
        }
        public static H[] Kivalogat<H> (H[] arr, Func<H, bool> t) {
            return Kivalogat(arr, p => t(p), (p, i) => p);
        }
        #endregion
        #endregion

    }

    internal class Program {
        static void Main(string[] args) {
            // deklaralas
            int maxho, maxind, db;
            int[,] ho;
            int[] y;

            // beolvasas
            ho = beolvas();
            
            // megoldas
            int n = ho.GetLength(0) - 1;
            int m = ho.GetLength(1) - 1;

            (maxind, maxho) = Mintak.Max(1, n * m, i => ho[(i - 1) / m + 1, (i - 1) % m + 1]);
            y = Mintak.Kivalogat(1, n, i => bennevan(i), i => i);
            db = y.Length;

            bool bennevan (int i) {
                return Mintak.Van(1, m, j => ho[i, j] == maxho);
            }

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
                            Console.WriteLine("A hőfoknak -5 és 5 közé kell esnie!");
                        }
                    } while (!jo);
                }
            }
            return ho;
        }
        
        static void kiir (int db, int[] y) {
            if (Console.IsInputRedirected) {
                Console.Write("{0} ", db);
                for (int i = 0; i < db; ++i) {
                    Console.Write("{0} ", y[i]);
                }
                Console.WriteLine();
            } else {
                Console.ForegroundColor = ConsoleColor.Green;
                if (db == 0) {
                    Console.WriteLine("Nincs a feltételnek megfelelő település!");
                } else {
                    Console.WriteLine("{0} darab feltételnek megfelelő település is van, sorszámaik:", db);
                    for (int i = 0; i < db - 1; ++i) {
                        Console.Write("{0}, ", y[i]);
                    }
                    Console.WriteLine(y[db - 1]);
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
