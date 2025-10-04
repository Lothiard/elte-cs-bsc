using System;

namespace Tetris.Persistence
{
    public interface ITetrisDataAccess
    {
        void Save(string filePath, TetrisPersistence.GameState state);
        TetrisPersistence.GameState? Load(string filePath);
    }
}