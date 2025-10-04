using System;

namespace Tetris.Model
{
    public class TetrisGameEventArgs : EventArgs
    {
        #region Properties

        public int ClearedLines { get; private set; }
        public bool IsGameOver { get; private set; }

        #endregion

        #region Constructor

        public TetrisGameEventArgs(int clearedLines = 0, bool isGameOver = false)
        {
            ClearedLines = clearedLines;
            IsGameOver = isGameOver;
        }

        #endregion
    }
}