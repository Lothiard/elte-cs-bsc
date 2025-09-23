using System;

namespace ELTE.TicTacToeGame.Model
{
    /// <summary>
    /// Játék megnyerésének eseményargumetum típusa.
    /// </summary>
    public class GameWonEventArgs : EventArgs
    {
        /// <summary>
        /// Játékos lekérdezése.
        /// </summary>
        public Player Player { get; private set; }

        /// <summary>
        /// Játék megnyerésének eseményargumetum 
        /// </summary>
        /// <param name="player"></param>
        public GameWonEventArgs(Player player) { Player = player; }
    }
}
