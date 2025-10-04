using System;
using System.IO;
using System.Text.Json;

namespace Tetris.Persistence
{
    public class TetrisFileDataAccess : ITetrisDataAccess
    {
        #region Public Methods

        public void Save(string filePath, TetrisPersistence.GameState state)
        {
            try
            {
                string json = JsonSerializer.Serialize(state, new JsonSerializerOptions { WriteIndented = true });
                File.WriteAllText(filePath, json);
            }
            catch (IOException ex)
            {
                throw new IOException("Error writing save file.", ex);
            }
        }

        public TetrisPersistence.GameState? Load(string filePath)
        {
            try
            {
                string json = File.ReadAllText(filePath);
                return JsonSerializer.Deserialize<TetrisPersistence.GameState>(json);
            }
            catch (IOException ex)
            {
                throw new IOException("Error reading save file.", ex);
            }
            catch (JsonException ex)
            {
                throw new JsonException("Invalid save file format.", ex);
            }
        }

        #endregion
    }
}