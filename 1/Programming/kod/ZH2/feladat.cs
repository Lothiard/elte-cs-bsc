using System;

namespace zh2 {
    internal class Program {
        public struct Vallal {
            public int elso, utolso;
            public string azon;
        }

        static void Main(string[] args) {
            int i = 1; // maskepp use of unassigned var fv hivasnal
            int n, ossznap, kerdesesMunkaja, egyszerreLegtobb, kulonbozo, lustaDb;
            string kerdeses;
            Vallal[] arr;
            int[] egyszerre;
            int[] elofordulas;
            string[] lustak;

            beolvas(out n, out kerdeses, out arr, out egyszerre, out elofordulas, out lustak);
            elso(i, n, out ossznap, arr);
            masodik(i, n, out kerdesesMunkaja, kerdeses, arr);
            harmadikA(i, n, ref egyszerre, arr);
            harmadikB(i, n, egyszerre, out egyszerreLegtobb);
            negyedik(i, n, out kulonbozo, arr);
            otodikA(i, n, ref elofordulas, arr);
            otodikB(i, n, elofordulas, arr, out lustaDb, ref lustak);
            kiir(i, ossznap, kerdesesMunkaja, egyszerreLegtobb, kulonbozo, lustaDb, lustak);
        }

        static void beolvas(out int n, out string kerdeses, out Vallal[] arr, out int[] egyszerre, out int[] elofordulas, out string[] lustak) {
            string[] line;
            line = Console.ReadLine().Split(' ');

            int.TryParse(line[0], out n);
            kerdeses = line[1];

            arr = new Vallal[n + 1];
            egyszerre = new int[n + 1];
            elofordulas = new int[n + 1];
            lustak = new string[n + 1];

            for(int i = 1; i <= n; ++i) {
                line = Console.ReadLine().Split(' ');
                int.TryParse(line[0], out arr[i].elso);
                int.TryParse(line[1], out arr[i].utolso);
                arr[i].azon = line[2];
            }
        }

        static void elso(int i, int n, out int ossznap, Vallal[] arr) {
            ossznap = 0;
            for(i = 1; i <= n; ++i) {
                ossznap += arr[i].utolso - arr[i].elso + 1;
            }
        }

        static void masodik(int i, int n, out int kerdesesMunkaja, string kerdeses, Vallal[] arr) {
            kerdesesMunkaja = 0;
            for (i = 1; i <= n; ++i) {
                if (arr[i].azon == kerdeses) {
                    kerdesesMunkaja += arr[i].utolso - arr[i].elso + 1;
                }
            }
        }

        static int kiszamol(int nap, int n, Vallal[] arr) {
            int darab = 0;
            for(int j = 1; j <= n; ++j) {
                if (arr[j].elso <= nap && arr[j].utolso >= nap) {
                    ++darab;
                }
            }
            return darab;
        }

        static void harmadikA(int i, int n, ref int[] egyszerre, Vallal[] arr) {
            for(i = 1; i <= n; ++i) {
                egyszerre[i + 1 - 1] = kiszamol(i, n, arr);
            }
        }

        static void harmadikB(int i, int n, int[] egyszerre, out int egyszerreLegtobb) {
            int maxert = egyszerre[1];
            egyszerreLegtobb = 1;
            for(i = 1 + 1; i <= n; ++i) {
                if (egyszerre[i] > maxert) {
                    maxert = egyszerre[i];
                    egyszerreLegtobb = i;
                }
            }
        }

        static bool voltemar(int vallal, Vallal[] arr) {
            int j = 1;
            while(j <= vallal - 1 && arr[j].azon != arr[vallal].azon) {
                ++j;
            }
            return j > vallal - 1;
        }

        static void negyedik(int i, int n, out int kulonbozo, Vallal[] arr) {
            kulonbozo = 0;
            for(i = 1; i <= n; ++i) {
                if(voltemar(i, arr)) {
                    ++kulonbozo;
                }
            }
        }

        static int elofordul(string vallal, int n, Vallal[] arr) {
            int darab = 0;
            for(int j = 1; j <= n; ++j) {
                if (arr[j].azon == vallal) {
                    ++darab;
                }
            }
            return darab;
        }

        static void otodikA(int i, int n, ref int[] elofordulas, Vallal[] arr) {
            for(i = 1; i <=n; ++i) {
                elofordulas[i + 1 - 1] = elofordul(arr[i].azon, n, arr);
            }
        }

        static void otodikB(int i, int n, int[] elofordulas, Vallal[] arr, out int lustaDb, ref string[] lustak) {
            lustaDb = 0;
            for(i = 1;  i <= n; ++i) {
                if (elofordulas[i] == 1) {
                    ++lustaDb;
                    lustak[lustaDb] = arr[i].azon;
                }
            }
        }

        static void kiir(int i, int ossznap, int kerdesesMunkaja, int egyszerreLegtobb, int kulonbozo, int lustaDb, string[] lustak) {
            Console.WriteLine("#");
            Console.WriteLine(ossznap);
            Console.WriteLine("#");
            Console.WriteLine(kerdesesMunkaja);
            Console.WriteLine("#");
            Console.WriteLine(egyszerreLegtobb);
            Console.WriteLine("#");
            Console.WriteLine(kulonbozo);
            Console.WriteLine("#");
            Console.WriteLine(lustaDb);
            for(i = 1; i <= lustaDb; ++i) {
                Console.WriteLine(lustak[i]);
            }
        }
    }
}
