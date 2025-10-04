using System;

namespace Tetris.Model
{
    public class TetrisGameEventArgs : EventArgs
    {
        public int ClearedLines { get; set; }
        public bool IsGameOver { get; set; }

        public TetrisGameEventArgs(int clearedLines = 0, bool isGameOver = false)
        {
            ClearedLines = clearedLines;
            IsGameOver = isGameOver;
        }
    }
}