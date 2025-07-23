// Restye János Barnabás / F8U9I2 / f8u9i2@inf.elte.hu //

using System;

namespace eleg_resztvevo_a_kihivas_napjan_ {
    internal class Program {
        public struct Telepules {
            public string nev;
            public int lelek, resztvevo;
        }
        static void Main(string[] args) {
            // deklaralas, beolvasas
            int i;
            int n;

            int.TryParse(Console.ReadLine(), out n);
            Telepules[] nevezes = new Telepules[n];

            bool van;
            int sok;

            for (i = 1; i <= n; ++i) {
                nevezes[i - 1].nev = Console.ReadLine();
                int.TryParse(Console.ReadLine(), out nevezes[i - 1].lelek);
                int.TryParse(Console.ReadLine(), out nevezes[i - 1].resztvevo);
            }

            // feladatmegoldas
            keres(out van, out sok, n, i, nevezes);

            // kiiras
            kiiras(van, sok);
        }

        static int ossz (int j, int i, Telepules[] nevezes) {
            int s = 0;
            for(i = 1; i <= j; ++i) {
                s += nevezes[i - 1].resztvevo;
            }
            return s;
        }
        static void keres(out bool van, out int sok, int n, int i, Telepules[] nevezes) {
            van = false;
            sok = 1;
            while(!van && sok <= n) {
                if(ossz(sok, i, nevezes) > 10000) {
                    van = true;
                } else {
                    ++sok;
                }
            }
        }

        static void kiiras(bool van, int sok) {
            if(!van) {
                sok = -1;
            }

            Console.WriteLine(sok);
        }
    }
}
