using System;
using System.Drawing;

namespace Tetris.Model
{
    public class TetrisGameModel : IDisposable
    {
        #region Properties

        public int Rows { get; set; }
        public int Cols { get; set; }
        public int[,] Board { get; set; }
        public int CurrentTetrominoIndex { get; set; }
        public (int row, int col)[]? CurrentBlock { get; set; }
        public int BlockRow { get; set; }
        public int BlockCol { get; set; }
        public bool IsGameOver { get; set; }
        private readonly (int row, int col)[][] _tetrominoes =
        [
            [(row: 0, col: 0), (row: 0, col: 1), (row: 0, col: 2), (row: 0, col: 3)], // I
            [(row: 0, col: 0), (row: 0, col: 1), (row: 1, col: 0), (row: 1, col: 1)], // O
            [(row: 0, col: 1), (row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2)], // T
            [(row: 0, col: 1), (row: 0, col: 2), (row: 1, col: 0), (row: 1, col: 1)], // S
            [(row: 0, col: 0), (row: 0, col: 1), (row: 1, col: 1), (row: 1, col: 2)], // Z
            [(row: 0, col: 0), (row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2)], // J
            [(row: 0, col: 2), (row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2)]  // L
        ];
        private readonly Random _rng = new();
        private readonly Color[] _tetrominoColors =
        [
            Color.Cyan,   // I
            Color.Yellow, // O
            Color.Purple, // T
            Color.Green,  // S
            Color.Red,    // Z
            Color.Blue,   // J
            Color.Orange  // L
        ];

        private readonly ITimer _gameTickTimer;
        private DateTime _startTime;
        private TimeSpan _pausedTime;
        private bool _isRunning;
        private bool _isPaused;
        private bool _disposed;
        
        public Color[] TetrominoColors => (Color[])_tetrominoColors.Clone();
        public int TetrominoCount => _tetrominoes.Length;
        
        public TimeSpan ElapsedTime
        {
            get
            {
                if (!_isRunning)
                    return TimeSpan.Zero;

                if (_isPaused)
                    return _pausedTime;

                return _pausedTime + (DateTime.Now - _startTime);
            }
        }
        
        public bool IsTimerRunning => _isRunning;
        public bool IsTimerPaused => _isPaused;

        #endregion

        #region Events

        public event EventHandler? GameStateChanged;
        public event EventHandler? GameOver;

        #endregion

        #region Constructor

        public TetrisGameModel(int rows, int cols)
        {
            Rows = rows;
            Cols = cols;
            Board = new int[Rows, Cols];
            IsGameOver = false;
            _isRunning = false;
            _isPaused = false;
            _pausedTime = TimeSpan.Zero;
            _disposed = false;

            _gameTickTimer = new TetrisTimerAggregation();
            _gameTickTimer.Interval = 500;
            _gameTickTimer.Elapsed += OnGameTickTimer_Elapsed;
        }

        #endregion

        #region Game Timing Methods

        public void StartTimer()
        {
            if (!_isRunning)
            {
                _isRunning = true;
                _isPaused = false;
                _startTime = DateTime.Now;
                _pausedTime = TimeSpan.Zero;
                
                _gameTickTimer.Start();
            }
        }

        public void StopTimer()
        {
            if (_isRunning)
            {
                _isRunning = false;
                _isPaused = false;
                _pausedTime = TimeSpan.Zero;
                
                _gameTickTimer.Stop();
            }
        }

        public void PauseTimer()
        {
            if (_isRunning && !_isPaused)
            {
                _isPaused = true;
                _pausedTime += DateTime.Now - _startTime;
                
                _gameTickTimer.Stop();
            }
        }

        public void ResumeTimer()
        {
            if (_isRunning && _isPaused)
            {
                _isPaused = false;
                _startTime = DateTime.Now;
                
                _gameTickTimer.Start();
            }
        }

        public void SetTimerPausedTime(TimeSpan time)
        {
            _pausedTime = time;
        }

        private void OnGameTickTimer_Elapsed(object? sender, EventArgs e)
        {
            if (IsGameOver || _isPaused) return;
            
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
            OnGameStateChanged();
        }

        public void SpawnNewTetromino()
        {
            CurrentTetrominoIndex = _rng.Next(_tetrominoes.Length);
            CurrentBlock = (ValueTuple<int, int>[])_tetrominoes[CurrentTetrominoIndex].Clone();
            BlockRow = 0;
            BlockCol = Cols / 2 - 2;
            if (!CanMoveTo(BlockRow, BlockCol, CurrentBlock))
            {
                IsGameOver = true;
                OnGameOver();
            }
            else
            {
                OnGameStateChanged();
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
                OnGameStateChanged();
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
                OnGameStateChanged();
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
                OnGameStateChanged();
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
                OnGameStateChanged();
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
            OnGameStateChanged();
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
                OnGameStateChanged();
            }
        }

        #endregion

        #region Event Methods

        public virtual void OnGameStateChanged()
        {
            GameStateChanged?.Invoke(this, EventArgs.Empty);
        }

        protected virtual void OnGameOver()
        {
            GameOver?.Invoke(this, EventArgs.Empty);
        }

        #endregion

        #region IDisposable Implementation

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _gameTickTimer.Stop();
                    _gameTickTimer.Elapsed -= OnGameTickTimer_Elapsed;
                    
                    if (_gameTickTimer is IDisposable disposableTimer)
                    {
                        disposableTimer.Dispose();
                    }
                }

                _disposed = true;
            }
        }

        #endregion
    }
}
