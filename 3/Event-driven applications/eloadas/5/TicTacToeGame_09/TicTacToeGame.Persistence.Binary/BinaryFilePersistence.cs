using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace ELTE.TicTacToeGame.Persistence
{
    /// <summary>
    /// Tic-Tac-Toe bináris fájl alapú adatelérés típusa.
    /// </summary>
    public class BinaryFilePersistence : IPersistence
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
                Byte[] fileData = await Task.Run(() => File.ReadAllBytes(path)); // fájl bináris tartalmának aszinkron beolvasása

                // konvertálás és tömbbé alakítás
                return fileData.Select(fileByte => (Player)fileByte).ToArray();
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
                // az értékeket egy byte tömbbe konvertáljuk
                Byte[] fileData = values.Select(value => (Byte)value).ToArray();

                // kiírjuk a tartalmat a megadott fájlba
                await Task.Run(() => File.WriteAllBytes(path, fileData));
            }
            catch // ha bármi hiba történt
            {
                throw new DataException("Error occurred during writing.");
            }
        }
    }
}
