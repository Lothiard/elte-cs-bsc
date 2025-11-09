using ELTE.TicTacToeGame.Persistence;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ELTE.TicTacToeGame.Model
{
    /// <summary>
    /// Tic-Tac-Toe játék modell típusa.
    /// </summary>
    public class BasicTicTacToeModel : ITicTacToeModel
    {
        #region Private fields

        private Player _currentPlayer; // aktuális játékos
        private Player[,] _gameTable; // játéktábla
        private Int32 _stepNumber; // lépésszám
        private ITicTacToeDataAccess _dataAccess; // adatelérés

        #endregion

        #region Public properties

        /// <summary>
        /// Lépésszám lekérdezése.
        /// </summary>
        public Int32 StepNumber { get { return _stepNumber; } }

        /// <summary>
        /// Játéktábla méretének lekérdezése.
        /// </summary>
        public int TableSize
        {
            get { return _gameTable.GetLength(0); }
        }

        /// <summary>
        /// Aktuális játékos lekérdezése.
        /// </summary>
        public Player CurrentPlayer { get { return _currentPlayer; } }

        /// <summary>
        /// Mezőérték lekérdezése, vagy beállítása.
        /// </summary>
        /// <param name="x">Oszlop index.</param>
        /// <param name="y">Sor index.</param>
        /// <returns>A mező értéke.</returns>
        public Player this[Int32 x, Int32 y]
        {
            get
            {
                if (x < 0 || x >= _gameTable.GetLength(0)) // ellenőrizzük a tartományt
                    throw new ArgumentException("Bad column index.", "x");
                if (y < 0 || y >= _gameTable.GetLength(1))
                    throw new ArgumentException("Bad row index.", "y");

                return _gameTable[x, y];
            }
        }

        #endregion

        #region Events

        /// <summary>
        ///  Játék kezdetének eseménye.
        /// </summary>
        public event EventHandler? GameStarted;

        /// <summary>
        /// Játék végének eseménye.
        /// </summary>
        public event EventHandler? GameOver;

        /// <summary>
        /// Játék megnyerésének eseménye.
        /// </summary>
        public event EventHandler<GameWonEventArgs>? GameWon;

        /// <summary>
        /// Mezőváltozás eseménye.
        /// </summary>
        public event EventHandler<FieldChangedEventArgs>? FieldChanged;


        #endregion

        #region Constructors

        /// <summary>
        /// Tic-Tac-Toe játék modell példányosítása.
        /// </summary>
        /// <param name="dataAccess">Az adatelérés.</param>
        public BasicTicTacToeModel(ITicTacToeDataAccess dataAccess, int size = 3)
        {
            _gameTable = new Player[size, size]; // mátrix létrehozása
            _dataAccess = dataAccess;

            NewGame();
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Új játék indítása.
        /// </summary>
        public void NewGame()
        {
            for (Int32 i = 0; i < _gameTable.GetLength(0); i++) // végigmegyünk a mátrix elemein
                for (Int32 j = 0; j < _gameTable.GetLength(1); j++)
                {
                    _gameTable[i, j] = Player.NoPlayer; // a játékosok pozícióit töröljük
                }

            _stepNumber = 0;
            _currentPlayer = Player.PlayerX; // először az X lép

            OnGameStarted();
        }

        /// <summary>
        /// Játék léptetése.
        /// </summary>
        /// <param name="x">Oszlop index.</param>
        /// <param name="y">Sor index.</param>
        public void StepGame(Int32 x, Int32 y)
        {
            if (x < 0 || x >= _gameTable.GetLength(0)) // ellenőrizzük a tartományt
                throw new ArgumentOutOfRangeException("x", "Bad column index.");
            if (y < 0 || y >= _gameTable.GetLength(1))
                throw new ArgumentOutOfRangeException("y", "Bad row index.");
            if (_stepNumber >= _gameTable.Length) // ellenőrizzük a lépésszámot
                throw new InvalidOperationException("Game is over!");
            if (_gameTable[x, y] != Player.NoPlayer) // ellenőrizzük a mezőt
                throw new InvalidOperationException("Field is not empty!");

            _gameTable[x, y] = _currentPlayer; // pozíció rögzítése
            OnFieldChanged(x, y, _currentPlayer); // jelezzük egy eseménykiváltással, hogy változott a mező

            _stepNumber++;
            _currentPlayer = _currentPlayer == Player.PlayerO ? Player.PlayerX : Player.PlayerO;
            // beállítjuk a következő játékost

            CheckGame();
        }

        /// <summary>
        /// Játék betöltése (aszinkron módon).
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        public async Task LoadGameAsync(String path)
        {
            if (_dataAccess == null)
                return;

            // végrehajtjuk a betöltést
            Player[] values = await _dataAccess.LoadAsync(path);

            if (values.Length != _gameTable.Length)
                throw new TicTacToeDataException("Error occurred during game loading.");

            if (values.Count(value => value == Player.PlayerO) != values.Count(value => value == Player.PlayerX) && values.Count(value => value == Player.PlayerO) + 1 != values.Count(value => value == Player.PlayerX))
                // ellenőrizzük, hogy megfelelő számú lépés történt-e a játékosok részéről (leszámoljuk, hány lépés történt az egyes játékosok részéről)
                throw new TicTacToeDataException("Error occurred during game loading.");

            _stepNumber = values.Count(value => value != Player.NoPlayer); // leszámoljuk, hány lépés történt
            _currentPlayer = _stepNumber % 2 == 0 ? Player.PlayerX : Player.PlayerO; // a lépésszámból kijön az aktuális játékos

            // beállítjuk az értékeket
            for (Int32 i = 0; i < _gameTable.GetLength(0); i++)
                for (Int32 j = 0; j < _gameTable.GetLength(1); j++)
                {
                    _gameTable[i, j] = values[i * _gameTable.GetLength(0) + j];

                    OnFieldChanged(i, j, _gameTable[i, j]);
                }

            OnGameStarted();

            CheckGame();
        }

        /// <summary>
        /// Játék mentése (aszinkron módon).
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        public async Task SaveGameAsync(String path)
        {
            if (_dataAccess == null)
                return;

            // az értékeket kimásoljuk egy új tömbbe
            Player[] values = new Player[_gameTable.Length];
            for (Int32 i = 0; i < _gameTable.GetLength(0); i++)
                for (Int32 j = 0; j < _gameTable.GetLength(1); j++)
                {
                    values[i * _gameTable.GetLength(0) + j] = _gameTable[i, j];
                }

            // végrehajtjuk a mentést
            await _dataAccess.SaveAsync(path, values);
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Játék ellenőrzése.
        /// </summary>
        private void CheckGame()
        {
            Player won = Player.NoPlayer;

            for (int i = 0; i < _gameTable.GetLength(0); ++i) // sorok ellenőrzése
                for (int j = 0; j < _gameTable.GetLength(1) - 2; ++j)
                {
                    if (_gameTable[i, j] != Player.NoPlayer && _gameTable[i, j] == _gameTable[i, j + 1] &&
                        _gameTable[i, j] == _gameTable[i, j + 2])
                        won = _gameTable[i, j];
                }

            for (int j = 0; j < _gameTable.GetLength(1); ++j) // oszlopok ellenőrzése
                for (int i = 0; i < _gameTable.GetLength(0) - 2; ++i)
                {
                    if (_gameTable[i, j] != Player.NoPlayer && _gameTable[i, j] == _gameTable[i + 1, j] &&
                        _gameTable[i, j] == _gameTable[i + 2, j])
                        won = _gameTable[i, j];
                }

            for (int i = 0; i < _gameTable.GetLength(0) - 2; ++i) // Jobbra-lefele átlók ellenőrzése
                for (int j = 0; j < _gameTable.GetLength(1) - 2; ++j)
                {
                    if (_gameTable[i, j] != Player.NoPlayer &&
                        _gameTable[i, j] == _gameTable[i + 1, j + 1] && _gameTable[i, j] == _gameTable[i + 2, j + 2])
                        won = _gameTable[i, j];
                }

            for (int i = 2; i < _gameTable.GetLength(0); ++i) // Jobbra-felfele átlók ellenőrzése
                for (int j = 0; j < _gameTable.GetLength(1) - 2; ++j)
                {
                    if (_gameTable[i, j] != Player.NoPlayer &&
                        _gameTable[i, j] == _gameTable[i - 1, j + 1] && _gameTable[i, j] == _gameTable[i - 2, j + 2])
                        won = _gameTable[i, j];
                }

            if (won != Player.NoPlayer) // ha valaki győzött
            {
                OnGameWon(won); // esemény kiváltása
            }
            else if (_stepNumber == _gameTable.Length) // döntetlen játék
            {
                OnGameOver(); // esemény kiváltása
            }
        }

        #endregion

        #region Event triggers

        /// <summary>
        /// Játék kezdetének eseménykiváltása.
        /// </summary>
        private void OnGameStarted()
        {
            GameStarted?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Játék végének eseménykiváltása.
        /// </summary>
        private void OnGameOver()
        {
            GameOver?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Játék megnyerésének eseménykiváltása.
        /// </summary>
        /// <param name="player">A győztes játékos.</param>
        private void OnGameWon(Player player)
        {
            GameWon?.Invoke(this, new GameWonEventArgs(player));
        }

        /// <summary>
        /// Mezőváltozás eseménykiváltása.
        /// </summary>
        /// <param name="x">Oszlop index.</param>
        /// <param name="y">Sor index.</param>
        /// <param name="player">Játékos.</param>
        private void OnFieldChanged(Int32 x, Int32 y, Player player)
        {
            FieldChanged?.Invoke(this, new FieldChangedEventArgs(x, y, player));
        }

        #endregion
    }
}
