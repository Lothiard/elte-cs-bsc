using System;

namespace emberek {
    internal class Program {
        public struct Ember {
            public int kor;
            public int fiz;
        }
        static void Main(string[] args) {
            // deklaralas es beolvasas
            int i;
            string[] sor;
            // Be
            int n;

            // Ki
            int legidosebb;
            int kisebb;
            int eletkor;
            int harmincAlattDb;

            // beolvasas
            int.TryParse(Console.ReadLine(), out n);
            Ember[] emberek = new Ember[n];
            int[] harmincAlatt = new int[n];

            for(i = 1; i <= n; ++i) {
                sor = Console.ReadLine().Split(' ');
                int.TryParse(sor[0], out emberek[i - 1].kor);
                int.TryParse(sor[1], out emberek[i - 1].fiz);
            }

            // feladatmegoldas
            a_feladat(emberek, out legidosebb, i, n);
            b_feladat(out kisebb, i, n, emberek);
            c_feladat(out eletkor, i, n, emberek);
            d_feladat(out harmincAlattDb, i, n, emberek, ref harmincAlatt);

            // kiiras
            kiiras(i, legidosebb, kisebb, eletkor, harmincAlattDb, harmincAlatt);
        }

        static void a_feladat(Ember[] emberek, out int legidosebb, int i, int n) {
            int maxert = emberek[0].kor;
            legidosebb = 0;

            for (i = 2; i <= n; ++i) {
                if (emberek[i - 1].kor > maxert) {
                    maxert = emberek[i - 1].kor;
                    legidosebb = i;
                }
            }
        }

        static void b_feladat(out int kisebb, int i, int n, Ember[] emberek) {
            kisebb = 0;
            for (i = 1; i <= n; ++i) {
                if (emberek[i - 1].fiz < 200000 && emberek[i - 1].kor > 40) {
                    kisebb++;
                }
            }
        }

        static bool kulonb(int i, Ember[] emberek) {
            int j = 1;
            while(j - 1 <= i && emberek[i - 1].kor != emberek[j - 1].kor) {
                j++;
            }
            return j > i - 1;
        }

        static void c_feladat(out int eletkor, int i, int n, Ember[] emberek) {
            eletkor = 0;
            for (i = 1; i <= n; ++i) {
                if(kulonb(i, emberek)) {
                    eletkor++;
                }
            }
        }

        static void d_feladat(out int harmincAlattDb, int i, int n, Ember[] emberek, ref int[] harmincAlatt) {
            harmincAlattDb = 0;
            for (i = 1; i <= n; ++i) {
                if (emberek[i - 1].kor < 30) {
                    harmincAlattDb++;
                    harmincAlatt[harmincAlattDb - 1] = i;
                }
            }
        }

        static void kiiras(int i, int legidosebb, int kisebb, int eletkor, int harmincAlattDb, int[] harmincAlatt) {
            Console.WriteLine(legidosebb);
            Console.WriteLine(kisebb);
            Console.WriteLine(eletkor);
            Console.Write("{0} ", harmincAlattDb);
            for (i = 0; i < harmincAlattDb; ++i) {
                Console.Write("{0} ", harmincAlatt[i]);
            }
        }
    }
}
