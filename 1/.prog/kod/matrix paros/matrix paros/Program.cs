namespace matrix_paros {
    internal class Program {
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
            // 1 
            //parosak = 0;
            //for (i = 0; i < n; ++i) {
            //    parosak += sor(i, m, matrix);
            //}

            //static int sor (int ind, int m, int[,] matrix) {
            //    int db = 0;
            //    for (int i = 0; i < m; ++i) {
            //        if (matrix[ind, i] % 2 == 0) {
            //            ++db;
            //        }
            //    }
            //    return db;
            //}

            // 2
            //parosak = 0;
            //for (i = 0; i < n; ++i) {
            //    int db = 0;

            //    for (j = 0; j < m; ++j) {
            //        if (matrix[i, j] % 2 == 0) {
            //            ++db;
            //        }
            //    }
            //    parosak += db;
            //}

            // 3
            //parosak = 0;
            //for(i = 0; i < n*m; ++i) {
            //    if(matrix[i / m, i % m] % 2 == 0) {
            //        ++parosak;
            //    }
            //}




            // kiiras
            Console.WriteLine(parosak);
        }
    }
}
