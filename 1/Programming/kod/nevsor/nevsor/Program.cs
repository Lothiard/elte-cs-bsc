using System;

namespace nevsor {
    internal class Program {
        struct Diak {
            public string nev;
            public int magassag;
        } 
        static void Main(string[] args) {
            // deklaralas
            int n;
            bool no;
            int i;

            // beolvasas
            int.TryParse(Console.ReadLine(), out n);
            Diak[] p = new Diak[n];
            for(i = 0; i < n; ++i) {
                string[] reszek = Console.ReadLine().Split(' ');

                p[i].nev = reszek[0];
                p[i].magassag = int.Parse(reszek[1]);
            }

            // feladat megoldas
            no = false;
            i = 0;

            while(!no && i < n - 1) {
                if (p[i].magassag > p[i+1].magassag) {
                    no = true;
                } else {
                    i = i + 1;
                }
            }

            // kiiras
            if(!no) {
                Console.WriteLine("IGEN");
            } else {
                Console.WriteLine("NEM");
            }

        }
    }
}
