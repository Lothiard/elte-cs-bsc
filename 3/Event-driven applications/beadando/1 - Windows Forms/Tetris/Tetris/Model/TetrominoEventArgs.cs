using System;

namespace Tetris.Model
{
    public class TetrominoEventArgs : EventArgs
    {
        #region Properties

        public int TetrominoIndex { get; private set; }
        public int Row { get; private set; }
        public int Col { get; private set; }
        public (int row, int col)[] Block { get; private set; }

        #endregion

        #region Constructor

        public TetrominoEventArgs(int tetrominoIndex, int row, int col, (int row, int col)[] block)
        {
            TetrominoIndex = tetrominoIndex;
            Row = row;
            Col = col;
            Block = block;
        }

        #endregion
    }
}