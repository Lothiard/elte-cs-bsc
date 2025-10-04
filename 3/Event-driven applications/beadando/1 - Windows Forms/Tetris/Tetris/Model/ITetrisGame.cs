using System;
using System.Drawing;

namespace Tetris.Model
{
    public interface ITetrisGame
    {
        #region Properties

        int Rows { get; }
        int Cols { get; }
        int[,] Board { get; }
        int CurrentTetrominoIndex { get; }
        (int row, int col)[] CurrentBlock { get; }
        int BlockRow { get; }
        int BlockCol { get; }
        bool IsGameOver { get; }
        Color[] TetrominoColors { get; }

        #endregion

        #region Events

        event EventHandler<TetrominoEventArgs> TetrominoMoved;
        event EventHandler<TetrominoEventArgs> TetrominoRotated;
        event EventHandler<TetrisGameEventArgs> GameStateChanged;
        event EventHandler<TetrominoEventArgs> TetrominoSpawned;
        event EventHandler<TetrisGameEventArgs> GameOver;
        event EventHandler<TetrisGameEventArgs> LinesCleared;

        #endregion

        #region Methods

        void Reset();
        void SpawnNewTetromino();
        bool MoveDown();
        bool MoveLeft();
        bool MoveRight();
        void Rotate();
        void LandCurrentPiece();
        void ClearFullLines();
        bool CanMoveTo(int newRow, int newCol, (int row, int col)[] block);

        #endregion
    }
}