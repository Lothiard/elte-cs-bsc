using System;
using System.IO;
using System.Text.Json;

namespace Tetris.Persistence
{
    public static class TetrisPersistence
    {
        #region Properties

        public class GameState
        {
            public int Rows { get; set; }
            public int Cols { get; set; }
            public int[,] Board { get; set; }
            public int CurrentTetrominoIndex { get; set; }
            public (int row, int col)[] CurrentBlock { get; set; }
            public int BlockRow { get; set; }
            public int BlockCol { get; set; }
            public TimeSpan PausedTime { get; set; }
            public DateTime SaveTime { get; set; }
        }

        #endregion

        #region Fields

        private static readonly ITetrisDataAccess _dataAccess = new TetrisFileDataAccess();

        #endregion

        #region Public Methods

        public static void Save(string filePath, GameState state)
        {
            _dataAccess.Save(filePath, state);
        }

        public static GameState? Load(string filePath)
        {
            return _dataAccess.Load(filePath);
        }

        #endregion
    }
}
