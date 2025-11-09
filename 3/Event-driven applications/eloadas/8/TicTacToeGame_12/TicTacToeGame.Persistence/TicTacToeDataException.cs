using System;

namespace ELTE.TicTacToeGame.Persistence
{
    /// <summary>
    /// Tic-Tac-Toe adat kivétel típusa.
    /// </summary>
    public class TicTacToeDataException : Exception
    {
        /// <summary>
        /// Tic-Tac-Toe adat kivétel példányosítása.
        /// </summary>
        public TicTacToeDataException(String message) : base(message) { }
    }
}
