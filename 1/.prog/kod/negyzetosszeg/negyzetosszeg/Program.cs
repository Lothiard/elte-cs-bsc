using System;

namespace negyzetosszeg {
    internal class Program {
        static void Main(string[] args) {
            // deklaracio
            int n;
            int no;

            // adatbeolvasas
            Console.Write("n=");
            n = int.Parse(Console.ReadLine());

            // feladatmegoldas
            no = 0;
            for(int i = 1; i <= n; i++) {
                no = no + i*i;
            }

            // eredmeny kiiratas
            Console.WriteLine("no={0}", no);
        }
    }
}
