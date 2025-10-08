namespace Tetris.Persistence
{
    public class TetrisDataException : Exception
    {
        public TetrisDataException(string message) : base(message) { }
        public TetrisDataException(string message, Exception innerException) : base(message, innerException) { }
    }
}
