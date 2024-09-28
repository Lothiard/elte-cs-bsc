using System;

namespace _3_csere {
    internal class Program {
        static void Main(string[] args) {
            // deklarizacio
            double a, b;

            // adatbeolvasas
            Console.Write("a=");
            a = double.Parse(Console.ReadLine());

            Console.Write("b=");
            b = double.Parse(Console.ReadLine());

            // feladatmegoldas
                // 1. megoldas
            /*
            double temp = a;
            a = b;
            b = temp;
            */

                // 2. megoldas (meno)
            (a, b) = (b, a);

            // eredmeny kiiratas
            Console.WriteLine("a={0}", a);
            Console.WriteLine("b={0}", b);
        }
    }
}
