using System;

namespace Tetris.Model
{
    public class TetrisGameEventArgs : EventArgs
    {
        #region Properties

        public bool IsGameOver { get; }

        #endregion

        #region Constructor

        public TetrisGameEventArgs(bool isGameOver = false)
        {
            IsGameOver = isGameOver;
        }

        #endregion
    }
}