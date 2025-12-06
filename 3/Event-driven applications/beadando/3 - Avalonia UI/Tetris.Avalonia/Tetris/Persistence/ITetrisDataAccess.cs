using System.Threading.Tasks;

namespace Tetris.Persistence
{
    public interface ITetrisDataAccess
    {
        Task SaveAsync(string filePath, TetrisPersistence.GameState state);
        Task<TetrisPersistence.GameState?> LoadAsync(string filePath);
    }
}