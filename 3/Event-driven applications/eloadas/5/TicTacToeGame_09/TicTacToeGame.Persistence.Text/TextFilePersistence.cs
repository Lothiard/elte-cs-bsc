using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace ELTE.TicTacToeGame.Persistence
{
    /// <summary>
    /// Tic-Tac-Toe szöveges fájl alapú adatelérés típusa.
    /// </summary>
    public class TextFilePersistence : IPersistence
    {
        /// <summary>
        /// Fájl betöltése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        /// <returns>A beolvasott mezőértékek.</returns>
        public async Task<Player[]> LoadAsync(String path)
        {
            if (path == null)
                throw new ArgumentNullException("path");

            try
            {
                using (StreamReader reader = new StreamReader(path)) // fájl megnyitása olvasásra
                {
                    String[] numbers = (await reader.ReadToEndAsync()).Split(); // fájl tartalmának feldarabolása a whitespace karakterek mentén

                    // a szöveget számmá, majd játékossá konvertáljuk, és ezzel a tömbbel visszatérünk
                    return numbers.Select(number => (Player)Int32.Parse(number)).ToArray();

                    // ugyanez ciklussal:
                    /*
                    Player[] values = new Player[numbers.Length];
                    for (Int32 i = 0; i < values.Length; i++)
                        values[i] = (Player)Int32.Parse(numbers[i]);
                    return values;
                    */
                } // bezárul a fájl
            }
            catch // ha bármi hiba történt
            {
                throw new DataException("Error occurred during reading.");
            }
        }

        /// <summary>
        /// Fájl mentése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        /// <param name="values">A mezőértékek.</param>
        public async Task SaveAsync(String path, Player[] values)
        {
            if (path == null)
                throw new ArgumentNullException("path");
            if (values == null)
                throw new ArgumentNullException("values");

            try
            {
                using (StreamWriter writer = new StreamWriter(path)) // fájl megnyitása írásra
                {
                    // a mezőket számmá, majd szöveggé konvertáljuk, végül aggregáljuk őket szóközökkel közrezárva
                    await writer.WriteAsync(values.Select(value => ((Int32)value).ToString()). Aggregate((value1, value2) => value1 + " " + value2));

                    // ugyanez ciklussal:
                    /*
                    for (Int32 i = 0; i < values.Length - 1; i++)
                    {
                        await writer.WriteAsync((Int32)values[i] + " "); // kiírjuk a mezőket
                    }
                    await writer.WriteAsync((Int32)values[values.Length - 1]);
                    */
                }
            }
            catch // ha bármi hiba történt
            {
                throw new DataException("Error occurred during writing.");
            }
        }
    }
}
