using System;

namespace gyak6 {
    internal class Program {
        static void betunkent(string szoveg) {
            for(int i = 0; i < szoveg.Length; ++i) {
                Console.WriteLine(szoveg[i]);
            }
        }

        static int hatvany(int alap, int kitevo) {
            int eredmeny = 1;
        
            for (int i = 0; i < kitevo; ++i) {
                eredmeny *= alap;
            }

            return eredmeny;
        }

        static void csere(ref int x, ref int y) {
            (x, y) = (y, x);
        }

        static int szum(ref int[] szamsor) {
            int s = 0;
            for (int i = 1; i <= szamsor.Length; ++i) {
                s += szamsor[i - 1];
            }
            return s;
        }

        static void tombolvas(out int[] tomb) {
            int n;
            int.TryParse(Console.ReadLine(), out n);
            
            tomb = new int[n];
            for(int i = 1; i <= n; ++i) {
                int.TryParse(Console.ReadLine(), out tomb[i - 1]);
            }
        }

        static void Main(string[] args) {
            //1
            //string input = Console.ReadLine();

            //2
            //betunkent(input);
            //Console.WriteLine(hatvany(5, 4));

            //3
            //int x = 5; int y = 10; 
            //Console.WriteLine("x: " + x + " y: " + y);
            //csere(ref x, ref y);
            //Console.WriteLine("x: " + x + " y: " + y);

            //4
            /*
            int n;
            int.TryParse(Console.ReadLine(), out n);
            Console.WriteLine();
            int[] szamsor = new int[n];

            for (int i = 0; i < n; ++i) {
                int.TryParse(Console.ReadLine(), out szamsor[i]);
            }

            Console.WriteLine();
            Console.WriteLine(szum(szamsor));
            */

            //5
            int[] tomb;
            tombolvas(out tomb);
            for(int i = 1; i <= tomb.Length; ++i) {
                Console.WriteLine("tomb[{0}]: ", tomb[i- 1]);
            }

        }
    }
}
