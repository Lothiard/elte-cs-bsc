using System;

namespace ELTE.TicTacToeGame.Persistence
{
    /// <summary>
    /// Tic-Tac-Toe adat kivétel típusa.
    /// </summary>
    public class DataException : Exception
    {
        /// <summary>
        /// Tic-Tac-Toe adat kivétel példányosítása.
        /// </summary>
        public DataException(String message) : base(message) { }
    }
}
