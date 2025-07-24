using System;

namespace esos_napok {
    internal class Program {
        static void Main(string[] args) {
            // deklaralas
            int n, db;
            int[] m = new int[100];

            // bekeres
            n = int.Parse(Console.ReadLine());

            for(int i = 0; i < n; ++i) {
                m[i] = int.Parse(Console.ReadLine());
            }

            // feladat megoldas
            db = 0;
            for(int i = 1; i <= n; ++i) {
                if (m[i - 1] > 0) {
                    db = db + 1;
                }
            }

            // kiiras
            Console.WriteLine(db);
        }
    }
}
