namespace Tetris.Persistence
{
    public interface ITetrisDataAccess
    {
        #region Async Methods
        Task SaveAsync(string filePath, TetrisPersistence.GameState state);
        Task<TetrisPersistence.GameState?> LoadAsync(string filePath);

        #endregion

        #region Sync Methods
        void Save(string filePath, TetrisPersistence.GameState state);
        TetrisPersistence.GameState? Load(string filePath);

        #endregion
    }
}