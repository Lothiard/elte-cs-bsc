using System;

namespace negyzetszam {
    internal class Program {
        static void Main(string[] args) {
            // deklaracio
            int n;
            int nszo;
            int i;

            // beolvasas
            Console.Write("n=");
            n = int.Parse(Console.ReadLine());

            // megoldas
            nszo = 0;
            for (i = 1; i <= n; ++i) {
                if(i * i <= n) {
                    nszo = nszo + i * i;
                }
            }

            // kiiras
            Console.Write("nszo={0}", nszo);
        }
    }
}
