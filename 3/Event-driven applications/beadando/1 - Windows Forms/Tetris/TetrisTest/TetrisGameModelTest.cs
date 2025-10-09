using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Tetris.Model;

namespace Tetris.Test
{
    [TestClass]
    public sealed class TetrisGameModelTest
    {
        private TetrisGameModel? _model;
        private MockTimer? _mockTimer;
        private int _gameStateChangedCount;
        private int _gameOverCount;
        
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
        
        [TestMethod]
        public void InitializeTest()
        {
            var model = new TetrisGameModel(20, 10);
            
            Assert.AreEqual(20, model.Rows);
            Assert.AreEqual(10, model.Cols);
            Assert.IsNotNull(model.Board);
            Assert.AreEqual(20, model.Board.GetLength(0));
            Assert.AreEqual(10, model.Board.GetLength(1));
            Assert.IsFalse(model.IsGameOver);
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
            
            Assert.IsTrue(_model.CanMoveTo(5, 5, _model.CurrentBlock ?? Array.Empty<(int row, int col)>()));
            
            Assert.IsFalse(_model.CanMoveTo(-1, 0, _model.CurrentBlock ?? Array.Empty<(int row, int col)>()));
            Assert.IsFalse(_model.CanMoveTo(0, -1, _model.CurrentBlock ?? Array.Empty<(int row, int col)>()));
            Assert.IsFalse(_model.CanMoveTo(_model.Rows, 0, _model.CurrentBlock ?? Array.Empty<(int row, int col)>()));
            Assert.IsFalse(_model.CanMoveTo(0, _model.Cols, _model.CurrentBlock ?? Array.Empty<(int row, int col)>()));
            
            var testBlock = new (int row, int col)[] { (1, 0) };
            
            Assert.IsFalse(_model.CanMoveTo(9, 4, testBlock));
        }
        
        [TestMethod]
        [TestCategory("Rotation")]
        public void Rotate_WithSpace_RotatesBlockCorrectly()
        {
            if (_model == null) return;
            
            _model.CurrentTetrominoIndex = 2;
            if (_model.Tetrominoes.Length > 2)
            {
                var sourceBlock = _model.Tetrominoes[2];
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
        
        private void GameStateChanged(object? sender, TetrisGameEventArgs e)
        {
            _gameStateChangedCount++;
        }
        
        private void GameOver(object? sender, TetrisGameEventArgs e)
        {
            _gameOverCount++;
        }
    }
}