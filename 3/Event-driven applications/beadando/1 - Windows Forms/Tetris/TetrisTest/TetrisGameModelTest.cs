using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Tetris.Model;

namespace Tetris.Test
{
    [TestClass]
    public sealed class TetrisGameModelTest : IDisposable
    {
        private TetrisGameModel? _model;
        private MockTimer? _mockTimer;
        private int _gameStateChangedCount;
        private int _gameOverCount;
        private bool _disposed = false;
        
        [TestInitialize]
        public void Initialize()
        {
            _model = new TetrisGameModel(16, 8);
            _mockTimer = new MockTimer();
            _gameStateChangedCount = 0;
            _gameOverCount = 0;
            
            _model.GameStateChanged += GameStateChanged;
            _model.GameOver += GameOver;
                
            _model.Reset();
                
            _gameStateChangedCount = 0;
        }

        [TestCleanup]
        public void Cleanup()
        {
            Dispose(true);
        }
        
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        
        private void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _model?.Dispose();
                }
                
                _disposed = true;
            }
        }
        
        [TestMethod]
        public void InitializeTest()
        {
            var model = new TetrisGameModel(20, 10);
            
            try
            {
                Assert.AreEqual(20, model.Rows);
                Assert.AreEqual(10, model.Cols);
                Assert.IsNotNull(model.Board);
                Assert.AreEqual(20, model.Board.GetLength(0));
                Assert.AreEqual(10, model.Board.GetLength(1));
                Assert.IsFalse(model.IsGameOver);
            }
            finally
            {
                model.Dispose();
            }
        }
        
        [TestMethod]
        public void ResetTest()
        {
            if (_model == null) return;
            
            for (int i = 0; i < 5; i++)
            {
                _model.Board[15, i] = 1;
            }
            
            _model.Reset();
            
            for (int row = 0; row < _model.Rows; row++)
            {
                for (int col = 0; col < _model.Cols; col++)
                {
                    Assert.AreEqual(0, _model.Board[row, col], $"[{row}, {col}] cellának üresnek kéne lennie");
                }
            }
            Assert.IsFalse(_model.IsGameOver);
            Assert.IsNotNull(_model.CurrentBlock);
        }
        
        [TestMethod]
        public void MoveDownTest()
        {
            if (_model == null) return;
            int initialRow = _model.BlockRow;
            
            bool result = _model.MoveDown();
            
            Assert.IsTrue(result);
            Assert.AreEqual(initialRow + 1, _model.BlockRow);
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void MoveLeftTest()
        {
            if (_model == null) return;
            int initialCol = _model.BlockCol;
            
            bool result = _model.MoveLeft();
            
            Assert.IsTrue(result);
            Assert.AreEqual(initialCol - 1, _model.BlockCol);
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void MoveRightTest()
        {
            if (_model == null) return;
            int initialCol = _model.BlockCol;
            
            bool result = _model.MoveRight();
            
            Assert.IsTrue(result);
            Assert.AreEqual(initialCol + 1, _model.BlockCol);
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void MoveDownBlockedTest()
        {
            if (_model == null) return;
            
            while (_model.MoveDown()) { }
            _gameStateChangedCount = 0;
            
            bool result = _model.MoveDown();
            
            Assert.IsFalse(result);
            Assert.AreEqual(0, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void LandPieceTest()
        {
            if (_model == null) return;
            int currentTetrominoIndex = _model.CurrentTetrominoIndex;
            var currentBlock = _model.CurrentBlock;
            int blockRow = _model.BlockRow;
            int blockCol = _model.BlockCol;
            
            _model.LandCurrentPiece();
            
            if (currentBlock != null)
            {
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = blockRow + dr;
                    int c = blockCol + dc;
                    if (r >= 0 && r < _model.Rows && c >= 0 && c < _model.Cols)
                    {
                        Assert.AreEqual(currentTetrominoIndex + 1, _model.Board[r, c]);
                    }
                }
            }
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void SpawnTetrominoTest()
        {
            if (_model == null) return;
            
            _model.SpawnNewTetromino();
            
            Assert.IsNotNull(_model.CurrentBlock);
            Assert.AreEqual(0, _model.BlockRow);
            Assert.AreEqual(_model.Cols / 2 - 2, _model.BlockCol);
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void ClearLineTest()
        {
            if (_model == null) return;
            
            for (int col = 0; col < _model.Cols; col++)
            {
                _model.Board[_model.Rows - 1, col] = 1;
            }
            
            _model.ClearFullLines();
            
            for (int col = 0; col < _model.Cols; col++)
            {
                Assert.AreEqual(0, _model.Board[_model.Rows - 1, col], 
                    "A sornak el kellett volna tűnnie.");
            }
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void DetectWallsTest()
        {
            if (_model == null) return;
            
            _model.Board[10, 4] = 1;
            
            Assert.IsTrue(_model.CanMoveTo(5, 5, _model.CurrentBlock ?? []));
            
            Assert.IsFalse(_model.CanMoveTo(-1, 0, _model.CurrentBlock ?? []));
            Assert.IsFalse(_model.CanMoveTo(0, -1, _model.CurrentBlock ?? []));
            Assert.IsFalse(_model.CanMoveTo(_model.Rows, 0, _model.CurrentBlock ?? []));
            Assert.IsFalse(_model.CanMoveTo(0, _model.Cols, _model.CurrentBlock ?? []));
            
            var testBlock = new (int row, int col)[] { (1, 0) };
            
            Assert.IsFalse(_model.CanMoveTo(9, 4, testBlock));
        }
        
        [TestMethod]
        public void RotatesBlockCorrectly()
        {
            if (_model == null) return;
            
            _model.CurrentTetrominoIndex = 2;
            if (_model.TetrominoCount > 2)
            {
                var sourceBlock = _model.GetTetromino(2);
                if (sourceBlock != null)
                {
                    _model.CurrentBlock = new (int row, int col)[sourceBlock.Length];
                    Array.Copy(sourceBlock, _model.CurrentBlock, sourceBlock.Length);
                }
            }
            _model.BlockRow = 5;
            _model.BlockCol = 5;
            
            var originalBlock = new (int row, int col)[_model.CurrentBlock?.Length ?? 0];
            if (_model.CurrentBlock != null)
            {
                for (int i = 0; i < _model.CurrentBlock.Length; i++)
                {
                    originalBlock[i] = _model.CurrentBlock[i];
                }
            }
            
            _model.Rotate();
            
            bool blockChanged = false;
            
            if (_model.CurrentBlock != null)
            {
                for (int i = 0; i < _model.CurrentBlock.Length; i++)
                {
                    if (originalBlock[i].row != _model.CurrentBlock[i].row || 
                        originalBlock[i].col != _model.CurrentBlock[i].col)
                    {
                        blockChanged = true;
                        break;
                    }
                }
            }
            
            Assert.IsTrue(blockChanged, "A tetrominónak forognia kellett volna");
            Assert.AreEqual(1, _gameStateChangedCount);
        }
        
        [TestMethod]
        public void GameStateChangedEventTest()
        {
            if (_model == null) return;
            
            _gameStateChangedCount = 0;
            
            _model.MoveDown();
            
            Assert.AreEqual(1, _gameStateChangedCount, "GameStateChanged eseménynek ki kellett volna váltódnia MoveDown után");
            
            _model.MoveLeft();
            Assert.AreEqual(2, _gameStateChangedCount, "GameStateChanged eseménynek ki kellett volna váltódnia MoveLeft után");
            
            _model.MoveRight();
            Assert.AreEqual(3, _gameStateChangedCount, "GameStateChanged eseménynek ki kellett volna váltódnia MoveRight után");
            
            _model.Rotate();
            Assert.AreEqual(4, _gameStateChangedCount, "GameStateChanged eseménynek ki kellett volna váltódnia Rotate után");
        }
        
        [TestMethod]
        public void GameOverEventTest()
        {
            if (_model == null) return;
            
            _gameOverCount = 0;
            
            for (int col = 0; col < _model.Cols; col++)
            {
                _model.Board[0, col] = 1;
            }
            
            _model.SpawnNewTetromino();
            
            Assert.AreEqual(1, _gameOverCount, "GameOver eseménynek ki kellett volna váltódnia amikor nincs hely új tetrominónak");
            Assert.IsTrue(_model.IsGameOver, "IsGameOver tulajdonságnak igaznak kell lennie");
        }
        
        [TestMethod]
        public void LoadGameTest()
        {
            if (_model == null) return;
            
            _model.Board[5, 3] = 2;
            _model.Board[10, 4] = 3;
            _model.CurrentTetrominoIndex = 4;
            _model.BlockRow = 7;
            _model.BlockCol = 2;
            var savedBlock = _model.GetTetromino(4);
            _model.CurrentBlock = savedBlock;
            
            var savedTime = TimeSpan.FromMinutes(5);
            _model.SetTimerPausedTime(savedTime);
            _model.StartTimer();
            _model.PauseTimer();
            
            Assert.AreEqual(2, _model.Board[5, 3], "A betöltött tábla celláját meg kell őrizni");
            Assert.AreEqual(3, _model.Board[10, 4], "A betöltött tábla celláját meg kell őrizni");
            Assert.AreEqual(4, _model.CurrentTetrominoIndex, "A betöltött tetromino indexet meg kell őrizni");
            Assert.AreEqual(7, _model.BlockRow, "A betöltött BlockRow-t meg kell őrizni");
            Assert.AreEqual(2, _model.BlockCol, "A betöltött BlockCol-t meg kell őrizni");
            Assert.IsNotNull(_model.CurrentBlock, "A betöltött CurrentBlock nem lehet null");
            Assert.AreEqual(savedBlock.Length, _model.CurrentBlock.Length, "A betöltött CurrentBlock hosszának meg kell egyeznie");
        }
        
        private void GameStateChanged(object? sender, EventArgs e)
        {
            _gameStateChangedCount++;
        }
        
        private void GameOver(object? sender, EventArgs e)
        {
            _gameOverCount++;
        }
    }
}