using System;
using System.Threading.Tasks;

namespace ELTE.TicTacToeGame.Persistence
{
    /// <summary>
    /// Tic-Tac-Toe adatelérés interfésze.
    /// </summary>
    public interface ITicTacToeDataAccess
    {
        /// <summary>
        /// Fájl betöltése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        /// <returns>A beolvasott mezőértékek.</returns>
        Task<Player[]> LoadAsync(String path);

        /// <summary>
        /// Fájl mentése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        /// <param name="values">A mezőértékek.</param>
        Task SaveAsync(String path, Player[] values);
    }
}
