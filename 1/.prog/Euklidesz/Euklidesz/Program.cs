using System;

namespace Euklidesz {
    internal class Program {
        static void Main(string[] args) {
            // deklaralas
            int a, b, maradek, oszto;

            // beolvasas
            Console.Write("a=");
            a = int.Parse(Console.ReadLine());

            Console.Write("b=");
            b = int.Parse(Console.ReadLine());

            // feladatmegoldas
            if(a < b) {
                (a, b) = (b, a);
            }

            maradek = a % b;

            while(maradek > 0) {
                a = b;
                b = maradek;
                maradek = a % b;
            }

            oszto = b;

            // kiiras
            Console.WriteLine("oszto={0}", oszto);
        }
    }
}
