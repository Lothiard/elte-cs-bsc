using ELTE.TicTacToeGame.Persistence;
using System;
using System.Threading.Tasks;

namespace ELTE.TicTacToeGame.Model
{
    /// <summary>
    /// Tic-Tac-Toe játék modell interfésze.
    /// </summary>
    public interface ITicTacToeModel
    {
        /// <summary>
        /// Aktuális játékos lekérdezése.
        /// </summary>
        Player CurrentPlayer { get; }

        /// <summary>
        /// Lépésszám lekérdezése.
        /// </summary>
        Int32 StepNumber { get; }

        /// <summary>
        /// Mezőérték lekérdezése, vagy beállítása.
        /// </summary>
        /// <param name="x">Oszlop index.</param>
        /// <param name="y">Sor index.</param>
        /// <returns>A mező értéke.</returns>
        Player this[Int32 x, Int32 y] { get; }

        /// <summary>
        ///  Játék kezdetének eseménye.
        /// </summary>
        event EventHandler? GameStarted;

        /// <summary>
        /// Játék végének eseménye.
        /// </summary>
        event EventHandler? GameOver;

        /// <summary>
        /// Játék megnyerésének eseménye.
        /// </summary>
        event EventHandler<GameWonEventArgs>? GameWon;

        /// <summary>
        /// Mezőváltozás eseménye.
        /// </summary>
        event EventHandler<FieldChangedEventArgs>? FieldChanged;

        /// <summary>
        /// Új játék indítása.
        /// </summary>
        void NewGame();

        /// <summary>
        /// Játék léptetése.
        /// </summary>
        /// <param name="x">Oszlop index.</param>
        /// <param name="y">Sor index.</param>
        void StepGame(Int32 x, Int32 y);

        /// <summary>
        /// Játék betöltése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        Task LoadGameAsync(String path);

        /// <summary>
        /// Játék mentése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        Task SaveGameAsync(String path);
    }
}
