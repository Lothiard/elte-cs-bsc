using System;
using System.Drawing;
using System.Linq;

namespace Tetris.Model
{
    public class TetrisGame : ITetrisGame
    {
        #region Properties

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
        private readonly Color[] tetrominoColors = new Color[]
        {
            Color.Cyan, Color.Yellow, Color.Purple, Color.Green, 
            Color.Red, Color.Blue, Color.Orange
        };
        public Color[] TetrominoColors => tetrominoColors;
        private Random rng = new Random();

        #endregion

        #region Events

        public event EventHandler<TetrominoEventArgs> TetrominoMoved;
        public event EventHandler<TetrominoEventArgs> TetrominoRotated;
        public event EventHandler<TetrisGameEventArgs> GameStateChanged;
        public event EventHandler<TetrominoEventArgs> TetrominoSpawned;
        public event EventHandler<TetrisGameEventArgs> GameOver;
        public event EventHandler<TetrisGameEventArgs> LinesCleared;

        #endregion

        #region Constructor

        public TetrisGame(int rows, int cols)
        {
            Rows = rows;
            Cols = cols;
            Board = new int[Rows, Cols];
            IsGameOver = false;
        }

        #endregion

        #region Public Methods

        public void Reset()
        {
            Board = new int[Rows, Cols];
            IsGameOver = false;
            SpawnNewTetromino();
            OnGameStateChanged(new TetrisGameEventArgs());
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
                OnGameOver(new TetrisGameEventArgs(0, true));
            }
            else
            {
                OnTetrominoSpawned(new TetrominoEventArgs(CurrentTetrominoIndex, BlockRow, BlockCol, CurrentBlock));
            }
        }

        public bool CanMoveTo(int newRow, int newCol, (int row, int col)[] block)
        {
            foreach (var (dr, dc) in block)
            {
                int r = newRow + dr;
                int c = newCol + dc;
                if (r < 0 || c < 0 || r >= Rows || c >= Cols || Board[r, c] != 0)
                {
                    return false;
                }
            }
            return true;
        }

        public bool MoveDown()
        {
            if (CanMoveTo(BlockRow + 1, BlockCol, CurrentBlock))
            {
                BlockRow++;
                OnTetrominoMoved(new TetrominoEventArgs(CurrentTetrominoIndex, BlockRow, BlockCol, CurrentBlock));
                return true;
            }
            return false;
        }

        public bool MoveLeft()
        {
            if (CanMoveTo(BlockRow, BlockCol - 1, CurrentBlock))
            {
                BlockCol--;
                OnTetrominoMoved(new TetrominoEventArgs(CurrentTetrominoIndex, BlockRow, BlockCol, CurrentBlock));
                return true;
            }
            return false;
        }

        public bool MoveRight()
        {
            if (CanMoveTo(BlockRow, BlockCol + 1, CurrentBlock))
            {
                BlockCol++;
                OnTetrominoMoved(new TetrominoEventArgs(CurrentTetrominoIndex, BlockRow, BlockCol, CurrentBlock));
                return true;
            }
            return false;
        }

        public void Rotate()
        {
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
                OnTetrominoRotated(new TetrominoEventArgs(CurrentTetrominoIndex, BlockRow, BlockCol, CurrentBlock));
            }
        }

        public void LandCurrentPiece()
        {
            foreach (var (dr, dc) in CurrentBlock)
            {
                int r = BlockRow + dr;
                int c = BlockCol + dc;
                if (r >= 0 && r < Rows && c >= 0 && c < Cols)
                {
                    Board[r, c] = CurrentTetrominoIndex + 1;
                }
            }
            OnGameStateChanged(new TetrisGameEventArgs());
        }

        public void ClearFullLines()
        {
            int linesCleared = 0;
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
                    linesCleared++;
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
            
            if (linesCleared > 0)
            {
                OnLinesCleared(new TetrisGameEventArgs(linesCleared));
            }
        }

        #endregion

        #region Event Methods

        protected virtual void OnTetrominoMoved(TetrominoEventArgs e)
        {
            TetrominoMoved?.Invoke(this, e);
        }

        protected virtual void OnTetrominoRotated(TetrominoEventArgs e)
        {
            TetrominoRotated?.Invoke(this, e);
        }

        protected virtual void OnGameStateChanged(TetrisGameEventArgs e)
        {
            GameStateChanged?.Invoke(this, e);
        }

        protected virtual void OnTetrominoSpawned(TetrominoEventArgs e)
        {
            TetrominoSpawned?.Invoke(this, e);
        }

        protected virtual void OnGameOver(TetrisGameEventArgs e)
        {
            GameOver?.Invoke(this, e);
        }

        protected virtual void OnLinesCleared(TetrisGameEventArgs e)
        {
            LinesCleared?.Invoke(this, e);
        }

        #endregion
    }
}
