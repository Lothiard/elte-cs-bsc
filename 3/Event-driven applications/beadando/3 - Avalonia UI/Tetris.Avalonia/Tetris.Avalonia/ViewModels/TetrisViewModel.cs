using System;
using System.Windows.Threading;
using Tetris.Model;

namespace Tetris.ViewModel
{
    /// <summary>
    /// Tetris nézetmodell típusa.
    /// </summary>
    public class TetrisViewModel : ViewModelBase
    {
        #region Fields

        private TetrisGameModel _model; // modell

        #endregion

        #region Properties

        /// <summary>
        /// Új játék kezdése parancs lekérdezése.
        /// </summary>
        public DelegateCommand NewGameCommand { get; private set; }

        /// <summary>
        /// Játék betöltése parancs lekérdezése.
        /// </summary>
        public DelegateCommand LoadGameCommand { get; private set; }

        /// <summary>
        /// Játék mentése parancs lekérdezése.
        /// </summary>
        public DelegateCommand SaveGameCommand { get; private set; }

        /// <summary>
        /// Szüneteltetés parancs lekérdezése.
        /// </summary>
        public DelegateCommand PauseGameCommand { get; private set; }

        /// <summary>
        /// Kilépés parancs lekérdezése.
        /// </summary>
        public DelegateCommand ExitCommand { get; private set; }

        /// <summary>
        /// Balra mozgatás parancs lekérdezése.
        /// </summary>
        public DelegateCommand MoveLeftCommand { get; private set; }

        /// <summary>
        /// Jobbra mozgatás parancs lekérdezése.
        /// </summary>
        public DelegateCommand MoveRightCommand { get; private set; }

        /// <summary>
        /// Forgatás parancs lekérdezése.
        /// </summary>
        public DelegateCommand RotateCommand { get; private set; }

        /// <summary>
        /// Lefelé mozgatás parancs lekérdezése.
        /// </summary>
        public DelegateCommand MoveDownCommand { get; private set; }

        /// <summary>
        /// Játéktábla lekérdezése.
        /// </summary>
        public Int32[,] Board
        {
            get { return _model.Board; }
        }

        /// <summary>
        /// Fennmaradt játékidő lekérdezése.
        /// </summary>
        public String GameTime
        {
            get { return _model.ElapsedTime.ToString("mm\\:ss"); }
        }

        /// <summary>
        /// Játék vége állapot lekérdezése.
        /// </summary>
        public Boolean IsGameOver
        {
            get { return _model.IsGameOver; }
        }

        /// <summary>
        /// Sorok számának lekérdezése.
        /// </summary>
        public Int32 Rows
        {
            get { return _model.Rows; }
        }

        /// <summary>
        /// Oszlopok számának lekérdezése.
        /// </summary>
        public Int32 Cols
        {
            get { return _model.Cols; }
        }

        /// <summary>
        /// Aktuális blokk lekérdezése.
        /// </summary>
        public (int row, int col)[]? CurrentBlock
        {
            get { return _model.CurrentBlock; }
        }

        /// <summary>
        /// Aktuális blokk sor pozíciójának lekérdezése.
        /// </summary>
        public Int32 BlockRow
        {
            get { return _model.BlockRow; }
        }

        /// <summary>
        /// Aktuális blokk oszlop pozíciójának lekérdezése.
        /// </summary>
        public Int32 BlockCol
        {
            get { return _model.BlockCol; }
        }

        /// <summary>
        /// Aktuális tetromino index lekérdezése.
        /// </summary>
        public Int32 CurrentTetrominoIndex
        {
            get { return _model.CurrentTetrominoIndex; }
        }

        #endregion

        #region Events

        /// <summary>
        /// Új játék eseménye.
        /// </summary>
        public event EventHandler? NewGame;

        /// <summary>
        /// Játék betöltésének eseménye.
        /// </summary>
        public event EventHandler? LoadGame;

        /// <summary>
        /// Játék mentésének eseménye.
        /// </summary>
        public event EventHandler? SaveGame;

        /// <summary>
        /// Játék szüneteltetésének eseménye.
        /// </summary>
        public event EventHandler? PauseGame;

        /// <summary>
        /// Játékból való kilépés eseménye.
        /// </summary>
        public event EventHandler? ExitGame;

        #endregion

        #region Constructors

        /// <summary>
        /// Tetris nézetmodell példányosítása.
        /// </summary>
        /// <param name="model">A modell típusa.</param>
        public TetrisViewModel(TetrisGameModel model)
        {
            _model = model;
            _model.GameStateChanged += new EventHandler(Model_GameStateChanged);
            _model.GameOver += new EventHandler(Model_GameOver);

            NewGameCommand = new DelegateCommand(param => OnNewGame());
            LoadGameCommand = new DelegateCommand(param => OnLoadGame());
            SaveGameCommand = new DelegateCommand(param => OnSaveGame());
            PauseGameCommand = new DelegateCommand(param => OnPauseGame());
            ExitCommand = new DelegateCommand(param => OnExitGame());
            
            MoveLeftCommand = new DelegateCommand(param => OnMoveLeft());
            MoveRightCommand = new DelegateCommand(param => OnMoveRight());
            RotateCommand = new DelegateCommand(param => OnRotate());
            MoveDownCommand = new DelegateCommand(param => OnMoveDown());
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Modell frissítése új modellel.
        /// </summary>
        /// <param name="model">Az új modell.</param>
        public void UpdateModel(TetrisGameModel model)
        {
            if (_model != null)
            {
                _model.GameStateChanged -= Model_GameStateChanged;
                _model.GameOver -= Model_GameOver;
            }

            _model = model;
            _model.GameStateChanged += Model_GameStateChanged;
            _model.GameOver += Model_GameOver;

            OnPropertyChanged(nameof(Board));
            OnPropertyChanged(nameof(Rows));
            OnPropertyChanged(nameof(Cols));
            OnPropertyChanged(nameof(CurrentBlock));
            OnPropertyChanged(nameof(BlockRow));
            OnPropertyChanged(nameof(BlockCol));
            OnPropertyChanged(nameof(CurrentTetrominoIndex));
            OnPropertyChanged(nameof(GameTime));
            OnPropertyChanged(nameof(IsGameOver));
        }

        /// <summary>
        /// Játékidő frissítése.
        /// </summary>
        public void RefreshGameTime()
        {
            OnPropertyChanged(nameof(GameTime));
        }

        #endregion

        #region Game event handlers

        /// <summary>
        /// Játékmodell állapot megváltozásának eseménykezelője.
        /// </summary>
        private void Model_GameStateChanged(object? sender, EventArgs e)
        {
            if (!Dispatcher.CurrentDispatcher.CheckAccess())
            {
                Dispatcher.CurrentDispatcher.BeginInvoke(() => { Model_GameStateChanged(sender, e); });
                return;
            }

            OnPropertyChanged(nameof(Board));
            OnPropertyChanged(nameof(CurrentBlock));
            OnPropertyChanged(nameof(BlockRow));
            OnPropertyChanged(nameof(BlockCol));
            OnPropertyChanged(nameof(CurrentTetrominoIndex));
            OnPropertyChanged(nameof(GameTime));
        }

        /// <summary>
        /// Játék végének eseménykezelője.
        /// </summary>
        private void Model_GameOver(object? sender, EventArgs e)
        {
            if (!Dispatcher.CurrentDispatcher.CheckAccess())
            {
                Dispatcher.CurrentDispatcher.BeginInvoke(() => { Model_GameOver(sender, e); });
                return;
            }

            OnPropertyChanged(nameof(IsGameOver));
        }

        #endregion

        #region Movement methods

        /// <summary>
        /// Balra mozgatás.
        /// </summary>
        private void OnMoveLeft()
        {
            if (_model.IsGameOver || !_model.IsTimerRunning || _model.IsTimerPaused)
                return;

            _model.MoveLeft();
        }

        /// <summary>
        /// Jobbra mozgatás.
        /// </summary>
        private void OnMoveRight()
        {
            if (_model.IsGameOver || !_model.IsTimerRunning || _model.IsTimerPaused)
                return;

            _model.MoveRight();
        }

        /// <summary>
        /// Forgatás.
        /// </summary>
        private void OnRotate()
        {
            if (_model.IsGameOver || !_model.IsTimerRunning || _model.IsTimerPaused)
                return;

            _model.Rotate();
        }

        /// <summary>
        /// Lefelé mozgatás.
        /// </summary>
        private void OnMoveDown()
        {
            if (_model.IsGameOver || !_model.IsTimerRunning || _model.IsTimerPaused)
                return;

            _model.MoveDown();
        }

        #endregion

        #region Event methods

        /// <summary>
        /// Új játék indításának eseménykiváltása.
        /// </summary>
        private void OnNewGame()
        {
            NewGame?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Játék betöltése eseménykiváltása.
        /// </summary>
        private void OnLoadGame()
        {
            LoadGame?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Játék mentése eseménykiváltása.
        /// </summary>
        private void OnSaveGame()
        {
            SaveGame?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Játék szüneteltetése eseménykiváltása.
        /// </summary>
        private void OnPauseGame()
        {
            PauseGame?.Invoke(this, EventArgs.Empty);
        }

        /// <summary>
        /// Játékból való kilépés eseménykiváltása.
        /// </summary>
        private void OnExitGame()
        {
            ExitGame?.Invoke(this, EventArgs.Empty);
        }

        #endregion
    }
}
