using System;
using System.Drawing;

namespace Tetris.Model
{
    public class TetrisGame
    {
        public int Rows { get; private set; }
        public int Cols { get; private set; }
        public int[,] Board { get; set; }
        public int CurrentTetrominoIndex { get; set; }
        public (int row, int col)[] CurrentBlock { get; set; }
        public int BlockRow { get; set; }
        public int BlockCol { get; set; }
        public bool IsGameOver { get; private set; }
        public readonly (int row, int col)[][] Tetrominoes = new (int, int)[][]
        {
            new (int, int)[] { (0,0), (0,1), (0,2), (0,3) }, // I
            new (int, int)[] { (0,0), (0,1), (1,0), (1,1) }, // O
            new (int, int)[] { (0,1), (1,0), (1,1), (1,2) }, // T
            new (int, int)[] { (0,1), (0,2), (1,0), (1,1) }, // S
            new (int, int)[] { (0,0), (0,1), (1,1), (1,2) }, // Z
            new (int, int)[] { (0,0), (1,0), (1,1), (1,2) }, // J
            new (int, int)[] { (0,2), (1,0), (1,1), (1,2) }  // L
        };
        public readonly Color[] TetrominoColors = new Color[]
        {
            Color.Cyan, Color.Yellow, Color.Purple, Color.Green, 
            Color.Red, Color.Blue, Color.Orange
        };
        private Random rng = new Random();

        public TetrisGame(int rows, int cols)
        {
            Rows = rows;
            Cols = cols;
            Board = new int[Rows, Cols];
            IsGameOver = false;
        }

        public void Reset()
        {
            Board = new int[Rows, Cols];
            IsGameOver = false;
            SpawnNewTetromino();
        }

        public void SpawnNewTetromino()
        {
            CurrentTetrominoIndex = rng.Next(Tetrominoes.Length);
            CurrentBlock = (ValueTuple<int, int>[])Tetrominoes[CurrentTetrominoIndex].Clone();
            BlockRow = 0;
            BlockCol = Cols / 2 - 2;
            if (!CanMoveTo(BlockRow, BlockCol, CurrentBlock))
            {
                IsGameOver = true;
            }
        }

        public bool CanMoveTo(int newRow, int newCol, (int row, int col)[] block)
        {
            foreach (var (dr, dc) in block)
            {
                int r = newRow + dr;
                int c = newCol + dc;
                if (r < 0 || r >= Rows || c < 0 || c >= Cols || Board[r, c] != 0)
                {
                    return false;
                }
            }
            return true;
        }

        public bool MoveDown()
        {
            if (CurrentBlock != null && CanMoveTo(BlockRow + 1, BlockCol, CurrentBlock))
            {
                BlockRow++;
                return true;
            }
            return false;
        }

        public bool MoveLeft()
        {
            if (CurrentBlock != null && CanMoveTo(BlockRow, BlockCol - 1, CurrentBlock))
            {
                BlockCol--;
                return true;
            }
            return false;
        }

        public bool MoveRight()
        {
            if (CurrentBlock != null && CanMoveTo(BlockRow, BlockCol + 1, CurrentBlock))
            {
                BlockCol++;
                return true;
            }
            return false;
        }

        public void Rotate()
        {
            if (CurrentBlock == null) return;
            var rotated = new (int row, int col)[CurrentBlock.Length];
            for (int i = 0; i < CurrentBlock.Length; i++)
            {
                rotated[i] = (CurrentBlock[i].col, -CurrentBlock[i].row);
            }
            int minRow = rotated.Min(x => x.row);
            int minCol = rotated.Min(x => x.col);
            for (int i = 0; i < rotated.Length; i++)
            {
                rotated[i] = (rotated[i].row - minRow, rotated[i].col - minCol);
            }
            if (CanMoveTo(BlockRow, BlockCol, rotated))
            {
                CurrentBlock = rotated;
            }
        }

        public void LandCurrentPiece()
        {
            if (CurrentBlock == null) return;
            foreach (var (dr, dc) in CurrentBlock)
            {
                int r = BlockRow + dr;
                int c = BlockCol + dc;
                if (r >= 0 && r < Rows && c >= 0 && c < Cols)
                {
                    Board[r, c] = CurrentTetrominoIndex + 1;
                }
            }
        }

        public void ClearFullLines()
        {
            for (int row = Rows - 1; row >= 0; row--)
            {
                bool full = true;
                for (int col = 0; col < Cols; col++)
                {
                    if (Board[row, col] == 0)
                    {
                        full = false;
                        break;
                    }
                }
                if (full)
                {
                    for (int r = row; r > 0; r--)
                    {
                        for (int c = 0; c < Cols; c++)
                        {
                            Board[r, c] = Board[r - 1, c];
                        }
                    }
                    for (int c = 0; c < Cols; c++)
                    {
                        Board[0, c] = 0;
                    }
                    row++;
                }
            }
        }
    }
}
