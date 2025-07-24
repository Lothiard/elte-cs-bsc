using System;

namespace matrix_paros {
    internal class Program1 {
        static void Main (string[] args) {
            int i, j;
            string temp;
            // deklaralas es beolvlasas
            int n, m, parosak;

            int.TryParse(Console.ReadLine(), out n);
            int.TryParse(Console.ReadLine(), out m);
            int[,] matrix = new int[n, m];

            for (i = 0; i < n; ++i) {
                temp = Console.ReadLine();
                for (j = 0; j < m; ++j) {
                    matrix[i, j] = temp[j];
                }
            }

            // feladatmegoldas
            parosak = 0;
            for (i = 0; i < n; ++i) {
                int db = 0;
                
                for (j = 0; j < m; ++j) {
                    if (matrix[i, j] % 2 == 0) {
                        ++db;
                    }
                }
                parosak += db;
            }


            // kiiras
            Console.WriteLine(parosak);
        }
    }
}
