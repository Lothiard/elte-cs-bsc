using System;
using System.Threading.Tasks;
using ELTE.Sudoku.Persistence;

namespace ELTE.Sudoku.Model
{
    /// <summary>
    /// Játéknehézség felsorolási típusa.
    /// </summary>
    public enum GameDifficulty { Easy, Medium, Hard }

    /// <summary>
    /// Sudoku játék típusa.
    /// </summary>
    public class SudokuGameModel
    {
        #region Difficulty constants

        private const Int32 GameTimeEasy = 3600;
        private const Int32 GameTimeMedium = 1200;
        private const Int32 GameTimeHard = 600;
        private const Int32 GeneratedFieldCountEasy = 6;
        private const Int32 GeneratedFieldCountMedium = 12;
        private const Int32 GeneratedFieldCountHard = 18;

        #endregion

        #region Fields

        private ISudokuDataAccess _dataAccess; // adatelérés
        private SudokuTable _table; // játéktábla
        private GameDifficulty _gameDifficulty; // nehézség
        private Int32 _gameStepCount; // lépések száma
        private Int32 _gameTime; // játékidő
        private ITimer _timer; // időzítő

        #endregion

        #region Properties

        /// <summary>
        /// Játéktábla méretének lekérdezése.
        /// </summary>
        public Int32 TableSize => _table.Size;

        /// <summary>
        /// Mező értékének lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Mező értéke.</returns>
        public Int32 this[Int32 x, Int32 y] => _table[x, y];

        /// <summary>
        /// Lépések számának lekérdezése.
        /// </summary>
        public Int32 GameStepCount
        {
            get { return _gameStepCount; }
        }

        /// <summary>
        /// Hátramaradt játékidő lekérdezése.
        /// </summary>
        public Int32 GameTime
        {
            get { return _gameTime; }
        }

        /// <summary>
        /// Játék végének lekérdezése.
        /// </summary>
        public Boolean IsGameOver
        {
            get { return (_gameTime == 0 || _table.IsFilled); }
        }

        /// <summary>
        /// Játéknehézség lekérdezése, vagy beállítása.
        /// </summary>
        public GameDifficulty GameDifficulty
        {
            get { return _gameDifficulty; }
            set { _gameDifficulty = value; }
        }

        #endregion

        #region Events

        /// <summary>
        /// Mező megváltozásának eseménye.
        /// </summary>
        public event EventHandler<SudokuFieldEventArgs>? FieldChanged;

        /// <summary>
        /// Játék előrehaladásának eseménye.
        /// </summary>
        public event EventHandler<SudokuEventArgs>? GameAdvanced;

        /// <summary>
        /// Játék végének eseménye.
        /// </summary>
        public event EventHandler<SudokuEventArgs>? GameOver;

        #endregion

        #region Constructor

        /// <summary>
        /// Sudoku játék példányosítása.
        /// </summary>
        /// <param name="dataAccess">Az adatelérés.</param>
        /// <param name="timer">Az időzítő.</param>
        public SudokuGameModel(ISudokuDataAccess dataAccess, ITimer timer)
        {
            _dataAccess = dataAccess;
            _table = new SudokuTable();
            _gameDifficulty = GameDifficulty.Medium;

            // időzítő létrehozása
            _timer = timer;
            _timer.Interval = 1000;
            _timer.Elapsed += new EventHandler(Timer_Elapsed);
        }

        #endregion

        #region Public table accessors

        /// <summary>
        /// Mező értékének lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>A mező értéke.</returns>
        public Int32 GetValue(Int32 x, Int32 y) => _table.GetValue(x, y);

        /// <summary>
        /// Mező kitöltetlenségének lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Igaz, ha a mező ki van töltve, egyébként hamis.</returns>
        public Boolean IsEmpty(Int32 x, Int32 y) => _table.IsEmpty(x, y);

        /// <summary>
        /// Mező zároltságának lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Igaz, ha a mező zárolva van, különben hamis.</returns>
        public Boolean IsLocked(Int32 x, Int32 y) => _table.IsLocked(x, y);

        #endregion

        #region Public game methods

        /// <summary>
        /// Új játék kezdése.
        /// </summary>
        public void NewGame()
        {
            _table = new SudokuTable();
            _gameStepCount = 0;

            switch (_gameDifficulty) // nehézségfüggő beállítása az időnek, illetve a generált mezőknek
            {
                case GameDifficulty.Easy:
                    _gameTime = GameTimeEasy;
                    GenerateFields(GeneratedFieldCountEasy);
                    break;
                case GameDifficulty.Medium:
                    _gameTime = GameTimeMedium;
                    GenerateFields(GeneratedFieldCountMedium);
                    break;
                case GameDifficulty.Hard:
                    _gameTime = GameTimeHard;
                    GenerateFields(GeneratedFieldCountHard);
                    break;
            }

            _timer.Start();
        }

        /// <summary>
        /// Játék szüneteltetése.
        /// </summary>
        public void PauseGame()
        {
            _timer.Stop();
        }

        /// <summary>
        /// Játék folytatása.
        /// </summary>
        public void ResumeGame()
        {
            if (!IsGameOver)
                _timer.Start();
        }

        /// <summary>
        /// Táblabeli lépés végrehajtása.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        public void Step(Int32 x, Int32 y)
        {
            if (IsGameOver) // ha már vége a játéknak, nem játszhatunk
                return;
            if (_table.IsLocked(x, y)) // ha a mező zárolva van, nem léphetünk
                return;

            _table.StepValue(x, y); // tábla módosítása
            OnFieldChanged(x, y);

            _gameStepCount++; // lépésszám növelés
            OnGameAdvanced();

            if (_table.IsFilled) // ha vége a játéknak, jelezzük, hogy győztünk
            {
                OnGameOver(true);
            }
        }

        /// <summary>
        /// Játék betöltése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        public async Task LoadGameAsync(String path)
        {
            if (_dataAccess == null)
                throw new InvalidOperationException("No data access is provided.");

            _table = await _dataAccess.LoadAsync(path);
            _gameStepCount = 0;

            switch (_gameDifficulty) // játékidő beállítása
            {
                case GameDifficulty.Easy:
                    _gameTime = GameTimeEasy;
                    break;
                case GameDifficulty.Medium:
                    _gameTime = GameTimeMedium;
                    break;
                case GameDifficulty.Hard:
                    _gameTime = GameTimeHard;
                    break;
            }
        }

        /// <summary>
        /// Játék mentése.
        /// </summary>
        /// <param name="path">Elérési útvonal.</param>
        public async Task SaveGameAsync(String path)
        {
            if (_dataAccess == null)
                throw new InvalidOperationException("No data access is provided.");

            await _dataAccess.SaveAsync(path, _table);
        }

        #endregion

        #region Private game methods

        /// <summary>
        /// Mezők generálása.
        /// </summary>
        /// <param name="count">Mezők száma.</param>
        private void GenerateFields(Int32 count)
        {
            Random random = new Random();

            for (Int32 i = 0; i < count; i++)
            {
                Int32 x, y;

                do
                {
                    x = random.Next(_table.Size);
                    y = random.Next(_table.Size);
                } while (!_table.IsEmpty(x, y)); // üres mező véletlenszerű kezelése

                do
                {
                    for (Int32 j = random.Next(10) + 1; j >= 0; j--) // véletlenszerű növelés
                    {
                        _table.StepValue(x, y);
                    }
                } while (_table.IsEmpty(x, y));

                _table.SetLock(x, y);
            }
        }

        #endregion

        #region Private event methods

        /// <summary>
        /// Mező változás eseményének kiváltása.
        /// <param name="x">Mező X koordináta.</param>
        /// <param name="y">Mező Y koordináta.</param>
        /// </summary>
        private void OnFieldChanged(Int32 x, Int32 y)
        {
            FieldChanged?.Invoke(this, new SudokuFieldEventArgs(x, y));
        }

        /// <summary>
        /// Játékidő változás eseményének kiváltása.
        /// </summary>
        private void OnGameAdvanced()
        {
            GameAdvanced?.Invoke(this, new SudokuEventArgs(false, _gameStepCount, _gameTime));
        }

        /// <summary>
        /// Játék vége eseményének kiváltása.
        /// </summary>
        /// <param name="isWon">Győztünk-e a játékban.</param>
        private void OnGameOver(Boolean isWon)
        {
            _timer.Stop();
            GameOver?.Invoke(this, new SudokuEventArgs(isWon, _gameStepCount, _gameTime));
        }

        #endregion

        #region Timer event handlers

        /// <summary>
        /// Időzítő eseménykeztelője.
        /// </summary>
        private void Timer_Elapsed(Object? sender, EventArgs e)
        {
            if (IsGameOver) // ha már vége, nem folytathatjuk
                return;

            _gameTime--;
            OnGameAdvanced();

            if (_gameTime == 0) // ha lejárt az idő, jelezzük, hogy vége a játéknak
                OnGameOver(false);
        }

        #endregion
    }
}
