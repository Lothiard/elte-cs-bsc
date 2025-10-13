using System;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Tetris.Model
{
    public class TetrisGameModel
    {
        #region Properties

        public int Rows { get; set; }
        public int Cols { get; set; }
        public int[,] Board { get; set; }
        public int CurrentTetrominoIndex { get; set; }
        public (int row, int col)[]? CurrentBlock { get; set; }
        public int BlockRow { get; set; }
        public int BlockCol { get; set; }
        public bool IsGameOver { get; private set; }
        private readonly (int row, int col)[][] _tetrominoes = new[]
        {
            new[] { (row: 0, col: 0), (row: 0, col: 1), (row: 0, col: 2), (row: 0, col: 3) }, // I
            new[] { (row: 0, col: 0), (row: 0, col: 1), (row: 1, col: 0), (row: 1, col: 1) }, // O
            new[] { (row: 0, col: 1), (row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2) }, // T
            new[] { (row: 0, col: 1), (row: 0, col: 2), (row: 1, col: 0), (row: 1, col: 1) }, // S
            new[] { (row: 0, col: 0), (row: 0, col: 1), (row: 1, col: 1), (row: 1, col: 2) }, // Z
            new[] { (row: 0, col: 0), (row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2) }, // J
            new[] { (row: 0, col: 2), (row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2) }  // L
        };
        private readonly Random rng = new Random();
        private readonly Color[] _tetrominoColors = new[]
        {
            Color.Cyan, Color.Yellow, Color.Purple, Color.Green, 
            Color.Red, Color.Blue, Color.Orange
        };

        public Color[] TetrominoColors => (Color[])_tetrominoColors.Clone();

        public int TetrominoCount => _tetrominoes.Length;

        private TetrisTimer _gameTimer;
        private System.Windows.Forms.Timer _gameTickTimer;
        
        public TimeSpan ElapsedTime => _gameTimer.ElapsedTime;
        public bool IsTimerRunning => _gameTimer.IsRunning;
        public bool IsTimerPaused => _gameTimer.IsPaused;

        #endregion

        #region Events

        public event EventHandler<TetrisGameEventArgs>? GameStateChanged;
        public event EventHandler<TetrisGameEventArgs>? GameOver;
        public event EventHandler? GameTimerElapsed;
        public event EventHandler? GameTick;

        #endregion

        #region Constructor

        public TetrisGameModel(int rows, int cols)
        {
            Rows = rows;
            Cols = cols;
            Board = new int[Rows, Cols];
            IsGameOver = false;
            
            _gameTimer = new TetrisTimer();
            _gameTimer.Elapsed += OnGameTimerElapsed;
            
            _gameTickTimer = new System.Windows.Forms.Timer();
            _gameTickTimer.Interval = 500;
            _gameTickTimer.Tick += OnGameTickTimer_Tick;
        }

        #endregion

        #region Game Timing Methods

        public void StartTimer()
        {
            _gameTimer.Start();
            _gameTickTimer.Start();
        }

        public void StopTimer()
        {
            _gameTickTimer.Stop();
            _gameTimer.Stop();
        }

        public void PauseTimer()
        {
            _gameTickTimer.Stop();
            _gameTimer.Pause();
        }

        public void ResumeTimer()
        {
            _gameTimer.Resume();
            _gameTickTimer.Start();
        }

        public void SetTimerPausedTime(TimeSpan time)
        {
            _gameTimer.SetPausedTime(time);
        }

        private void OnGameTimerElapsed(object? sender, EventArgs e)
        {
            GameTimerElapsed?.Invoke(this, EventArgs.Empty);
        }

        private void OnGameTickTimer_Tick(object? sender, EventArgs e)
        {
            if (IsGameOver || IsTimerPaused) return;
            
            DoGameTick();
            GameTick?.Invoke(this, EventArgs.Empty);
        }

        private void DoGameTick()
        {
            if (!MoveDown())
            {
                LandCurrentPiece();
                ClearFullLines();
                SpawnNewTetromino();
            }
        }

        #endregion

        #region Public Methods

        public (int row, int col)[] GetTetromino(int index)
        {
            if (index < 0 || index >= _tetrominoes.Length)
                throw new ArgumentOutOfRangeException(nameof(index));

            return (ValueTuple<int, int>[])_tetrominoes[index].Clone();
        }

        public void Reset()
        {
            Board = new int[Rows, Cols];
            IsGameOver = false;
            SpawnNewTetromino();
            OnGameStateChanged(new TetrisGameEventArgs());
        }

        public void SpawnNewTetromino()
        {
            CurrentTetrominoIndex = rng.Next(_tetrominoes.Length);
            CurrentBlock = (ValueTuple<int, int>[])_tetrominoes[CurrentTetrominoIndex].Clone();
            BlockRow = 0;
            BlockCol = Cols / 2 - 2;
            if (!CanMoveTo(BlockRow, BlockCol, CurrentBlock))
            {
                IsGameOver = true;
                OnGameOver(new TetrisGameEventArgs(true));
            }
            else
            {
                OnGameStateChanged(new TetrisGameEventArgs());
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
            if (CurrentBlock == null) return false;
            
            if (CanMoveTo(BlockRow + 1, BlockCol, CurrentBlock))
            {
                BlockRow++;
                OnGameStateChanged(new TetrisGameEventArgs());
                return true;
            }
            return false;
        }

        public bool MoveLeft()
        {
            if (CurrentBlock == null) return false;
            
            if (CanMoveTo(BlockRow, BlockCol - 1, CurrentBlock))
            {
                BlockCol--;
                OnGameStateChanged(new TetrisGameEventArgs());
                return true;
            }
            return false;
        }

        public bool MoveRight()
        {
            if (CurrentBlock == null) return false;
            
            if (CanMoveTo(BlockRow, BlockCol + 1, CurrentBlock))
            {
                BlockCol++;
                OnGameStateChanged(new TetrisGameEventArgs());
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
                OnGameStateChanged(new TetrisGameEventArgs());
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
                OnGameStateChanged(new TetrisGameEventArgs());
            }
        }

        #endregion

        #region Event Methods

        protected virtual void OnGameStateChanged(TetrisGameEventArgs e)
        {
            GameStateChanged?.Invoke(this, e);
        }

        protected virtual void OnGameOver(TetrisGameEventArgs e)
        {
            GameOver?.Invoke(this, e);
        }

        #endregion
    }
}
