using ELTE.TicTacToeGame.Persistence;
using System;

namespace ELTE.TicTacToeGame.Model
{
    /// <summary>
    /// Mezőváltozás eseményargumentum típusa.
    /// </summary>
    public class FieldChangedEventArgs : EventArgs
    {
        /// <summary>
        /// Játékos lekérdezése.
        /// </summary>
        public Player Player { get; private set; }
        /// <summary>
        /// Oszlop index lekérdezése.
        /// </summary>
        public Int32 X { get; private set; }
        /// <summary>
        /// Sor index lekérdezése.
        /// </summary>
        public Int32 Y { get; private set; }

        /// <summary>
        /// Mezőváltozás eseményargumentum példányosítása.
        /// </summary>
        /// <param name="x">Oszlop index.</param>
        /// <param name="y">Sor index.</param>
        /// <param name="player">Játékos.</param>
        public FieldChangedEventArgs(Int32 x, Int32 y, Player player)
        {
            Player = player;
            X = x;
            Y = y;
        }
    }
}
