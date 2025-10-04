using System;
using System.IO;
using System.Text.Json;

namespace Tetris.Persistence
{
    public class TetrisFileDataAccess : ITetrisDataAccess
    {
        public void Save(string filePath, TetrisPersistence.GameState state)
        {
            string json = JsonSerializer.Serialize(state, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(filePath, json);
        }

        public TetrisPersistence.GameState? Load(string filePath)
        {
            string json = File.ReadAllText(filePath);
            return JsonSerializer.Deserialize<TetrisPersistence.GameState>(json);
        }
    }
}