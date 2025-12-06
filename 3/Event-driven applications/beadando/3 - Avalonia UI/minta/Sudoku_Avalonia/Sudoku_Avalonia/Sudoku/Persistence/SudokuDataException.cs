using System;

namespace ELTE.Sudoku.Persistence
{
    /// <summary>
    /// Sudoku adatelérés kivétel típusa.
    /// </summary>
    public class SudokuDataException : Exception
    {
        /// <summary>
        /// Sudoku adatelérés kivétel példányosítása.
        /// </summary>
        public SudokuDataException() { }
    }
}
