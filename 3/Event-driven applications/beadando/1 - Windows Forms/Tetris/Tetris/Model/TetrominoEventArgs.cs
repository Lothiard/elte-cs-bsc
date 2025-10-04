using System;

namespace Tetris.Model
{
    public class TetrominoEventArgs : EventArgs
    {
        public int TetrominoIndex { get; set; }
        public int Row { get; set; }
        public int Col { get; set; }
        public (int row, int col)[] Block { get; set; }

        public TetrominoEventArgs(int tetrominoIndex, int row, int col, (int row, int col)[] block)
        {
            TetrominoIndex = tetrominoIndex;
            Row = row;
            Col = col;
            Block = block;
        }
    }
}