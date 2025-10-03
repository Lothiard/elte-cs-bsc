using System;
using System.IO;
using System.Text.Json;

namespace Tetris.Persistence
{
    public static class TetrisPersistence
    {
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

        public static void Save(string filePath, GameState state)
        {
            string json = JsonSerializer.Serialize(state, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(filePath, json);
        }

        public static GameState? Load(string filePath)
        {
            string json = File.ReadAllText(filePath);
            return JsonSerializer.Deserialize<GameState>(json);
        }
    }
}
