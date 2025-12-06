using System;
using Avalonia.Threading;
using CommunityToolkit.Mvvm.Input;
using Tetris.Model;

namespace Tetris.Avalonia.ViewModels
{
    /// <summary>
    /// Tetris nézetmodell típusa.
    /// </summary>
    public class TetrisViewModel : ViewModelBase
    {
        #region Fields

        private TetrisGameModel _model; // modell
        private int _selectedBoardSize = 1; // 0=4, 1=8, 2=12
        private string _pauseButtonText = "Szünet";
        private bool _isSaveEnabled = false;
        private bool _isPauseEnabled = false;
        private bool _isLoadEnabled = true;

        #endregion

        #region Properties

        /// <summary>
        /// Új játék kezdése parancs lekérdezése.
        /// </summary>
        public RelayCommand NewGameCommand { get; private set; }

        /// <summary>
        /// Játék betöltése parancs lekérdezése.
        /// </summary>
        public RelayCommand LoadGameCommand { get; private set; }

        /// <summary>
        /// Játék mentése parancs lekérdezése.
        /// </summary>
        public RelayCommand SaveGameCommand { get; private set; }

        /// <summary>
        /// Szüneteltetés parancs lekérdezése.
        /// </summary>
        public RelayCommand PauseGameCommand { get; private set; }

        /// <summary>
        /// Kilépés parancs lekérdezése.
        /// </summary>
        public RelayCommand ExitCommand { get; private set; }

        /// <summary>
        /// Balra mozgatás parancs lekérdezése.
        /// </summary>
        public RelayCommand MoveLeftCommand { get; private set; }

        /// <summary>
        /// Jobbra mozgatás parancs lekérdezése.
        /// </summary>
        public RelayCommand MoveRightCommand { get; private set; }

        /// <summary>
        /// Forgatás parancs lekérdezése.
        /// </summary>
        public RelayCommand RotateCommand { get; private set; }

        /// <summary>
        /// Lefelé mozgatás parancs lekérdezése.
        /// </summary>
        public RelayCommand MoveDownCommand { get; private set; }

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

        /// <summary>
        /// Kiválasztott pályaméret index lekérdezése vagy beállítása.
        /// </summary>
        public Int32 SelectedBoardSize
        {
            get { return _selectedBoardSize; }
            set
            {
                if (_selectedBoardSize != value)
                {
                    _selectedBoardSize = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Szünet gomb szövegének lekérdezése.
        /// </summary>
        public String PauseButtonText
        {
            get { return _pauseButtonText; }
            set
            {
                if (_pauseButtonText != value)
                {
                    _pauseButtonText = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Mentés gomb engedélyezett állapotának lekérdezése.
        /// </summary>
        public Boolean IsSaveEnabled
        {
            get { return _isSaveEnabled; }
            set
            {
                if (_isSaveEnabled != value)
                {
                    _isSaveEnabled = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Szünet gomb engedélyezett állapotának lekérdezése.
        /// </summary>
        public Boolean IsPauseEnabled
        {
            get { return _isPauseEnabled; }
            set
            {
                if (_isPauseEnabled != value)
                {
                    _isPauseEnabled = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Betöltés gomb engedélyezett állapotának lekérdezése.
        /// </summary>
        public Boolean IsLoadEnabled
        {
            get { return _isLoadEnabled; }
            set
            {
                if (_isLoadEnabled != value)
                {
                    _isLoadEnabled = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Modell lekérdezése (a View rendereléshez).
        /// </summary>
        internal TetrisGameModel Model
        {
            get { return _model; }
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

            NewGameCommand = new RelayCommand(OnNewGame);
            LoadGameCommand = new RelayCommand(OnLoadGame);
            SaveGameCommand = new RelayCommand(OnSaveGame);
            PauseGameCommand = new RelayCommand(OnPauseGame);
            ExitCommand = new RelayCommand(OnExitGame);
            
            MoveLeftCommand = new RelayCommand(OnMoveLeft);
            MoveRightCommand = new RelayCommand(OnMoveRight);
            RotateCommand = new RelayCommand(OnRotate);
            MoveDownCommand = new RelayCommand(OnMoveDown);
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

        /// <summary>
        /// Játék állapot frissítése új játék indításakor.
        /// </summary>
        public void SetNewGameState()
        {
            IsSaveEnabled = false;
            IsPauseEnabled = true;
            IsLoadEnabled = false;
            PauseButtonText = "Szünet";
        }

        /// <summary>
        /// Játék állapot frissítése játék vége esetén.
        /// </summary>
        public void SetGameOverState()
        {
            IsSaveEnabled = false;
            IsPauseEnabled = false;
            IsLoadEnabled = true;
        }

        /// <summary>
        /// Játék állapot frissítése szüneteltetéskor.
        /// </summary>
        public void SetPausedState()
        {
            PauseButtonText = "Folytatás";
            IsSaveEnabled = true;
            IsLoadEnabled = true;
        }

        /// <summary>
        /// Játék állapot frissítése folytatáskor.
        /// </summary>
        public void SetResumedState()
        {
            PauseButtonText = "Szünet";
            IsSaveEnabled = false;
            IsLoadEnabled = false;
        }

        #endregion

        #region Game event handlers

        /// <summary>
        /// Játékmodell állapot megváltozásának eseménykezelője.
        /// </summary>
        private void Model_GameStateChanged(object? sender, EventArgs e)
        {
            if (!Dispatcher.UIThread.CheckAccess())
            {
                Dispatcher.UIThread.InvokeAsync(() => { Model_GameStateChanged(sender, e); });
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
            if (!Dispatcher.UIThread.CheckAccess())
            {
                Dispatcher.UIThread.InvokeAsync(() => { Model_GameOver(sender, e); });
                return;
            }

            OnPropertyChanged(nameof(IsGameOver));
            SetGameOverState();
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
