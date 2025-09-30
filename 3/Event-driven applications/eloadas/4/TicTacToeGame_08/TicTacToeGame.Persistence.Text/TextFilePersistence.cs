using System;
using System.IO;
using System.Linq;

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
        public Player[] Load(String path)
        {
            if (path == null)
                throw new ArgumentNullException(nameof(path));

            try
            {
                using (StreamReader reader = new StreamReader(path)) // fájl megnyitása olvasásra
                {
                    String[] numbers = reader.ReadToEnd().Split(); // fájl tartalmának feldarabolása a whitespace karakterek mentén

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
        public void Save(String path, Player[] values)
        {
            if (path == null)
                throw new ArgumentNullException(nameof(path));
            if (values == null)
                throw new ArgumentNullException(nameof(values));

            try
            {
                using (StreamWriter writer = new StreamWriter(path)) // fájl megnyitása írásra
                {
                    // a mezőket számmá, majd szöveggé konvertáljuk, végül aggregáljuk őket szóközökkel közrezárva
                    writer.Write(values.Select(value => ((Int32)value).ToString()).Aggregate((value1, value2) => value1 + " " + value2));

                    // ugyanez ciklussal:
                    /*
                    for (Int32 i = 0; i < values.Length - 1; i++)
                    {
                        writer.Write((Int32)values[i] + " "); // kiírjuk a mezőket
                    }
                    writer.Write((Int32)values[values.Length - 1]);
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
