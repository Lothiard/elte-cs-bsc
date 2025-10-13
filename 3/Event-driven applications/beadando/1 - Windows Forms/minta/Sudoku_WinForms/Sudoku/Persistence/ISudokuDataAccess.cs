using System;
using System.Threading.Tasks;

namespace ELTE.Sudoku.Persistence
{
    /// <summary>
    /// Sudoku fájl kezelő felülete.
    /// </summary>
    public interface ISudokuDataAccess
    {
        /// <summary>
        /// Fájl betöltése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        /// <returns>A fájlból beolvasott játéktábla.</returns>
        Task<SudokuTable> LoadAsync(String path);

        /// <summary>
        /// Fájl mentése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        /// <param name="table">A fájlba kiírandó játéktábla.</param>
        Task SaveAsync(String path, SudokuTable table);
    }
}
