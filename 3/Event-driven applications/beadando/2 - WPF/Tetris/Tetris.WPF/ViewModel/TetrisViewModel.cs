using System;
using System.Collections.ObjectModel;
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
        /// Kilépés parancs lekérdezése.
        /// </summary>
        public DelegateCommand ExitCommand { get; private set; }

        /// <summary>
        /// Játékmező gyűjtemény lekérdezése.
        /// </summary>
        public ObservableCollection<TetrisField> Fields { get; set; }

        /// <summary>
        /// Játékidő lekérdezése.
        /// </summary>
        public String GameTime
        {
            get { return _model.ElapsedTime.ToString(@"hh\:mm\:ss"); }
        }

        /// <summary>
        /// Játék vége állapotának lekérdezése.
        /// </summary>
        public Boolean IsGameOver
        {
            get { return _model.IsGameOver; }
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
            // játék csatlakoztatása
            _model = model;
            _model.GameStateChanged += Model_GameStateChanged;
            _model.GameOver += Model_GameOver;

            // parancsok kezelése
            NewGameCommand = new DelegateCommand(param => OnNewGame());
            LoadGameCommand = new DelegateCommand(param => OnLoadGame());
            SaveGameCommand = new DelegateCommand(param => OnSaveGame());
            ExitCommand = new DelegateCommand(param => OnExitGame());

            // játéktábla létrehozása
            Fields = new ObservableCollection<TetrisField>();
            for (Int32 row = 0; row < _model.Rows; row++)
            {
                for (Int32 col = 0; col < _model.Cols; col++)
                {
                    Fields.Add(new TetrisField
                    {
                        IsLocked = false,
                        Text = String.Empty,
                        X = row,
                        Y = col
                    });
                }
            }

            RefreshTable();
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Tábla frissítése.
        /// </summary>
        private void RefreshTable()
        {
            // Tábla celláinak frissítése
            for (int row = 0; row < _model.Rows; row++)
            {
                for (int col = 0; col < _model.Cols; col++)
                {
                    int index = row * _model.Cols + col;
                    int cellValue = _model.Board[row, col];
                    Fields[index].Text = cellValue > 0 ? "■" : String.Empty;
                }
            }

            // Aktuális tetromino megjelenítése
            if (_model.CurrentBlock != null)
            {
                foreach (var (dr, dc) in _model.CurrentBlock)
                {
                    int r = _model.BlockRow + dr;
                    int c = _model.BlockCol + dc;
                    if (r >= 0 && r < _model.Rows && c >= 0 && c < _model.Cols)
                    {
                        int index = r * _model.Cols + c;
                        Fields[index].Text = "■";
                    }
                }
            }

            OnPropertyChanged(nameof(GameTime));
            OnPropertyChanged(nameof(IsGameOver));
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

            RefreshTable();
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
        /// Játékból való kilépés eseménykiváltása.
        /// </summary>
        private void OnExitGame()
        {
            ExitGame?.Invoke(this, EventArgs.Empty);
        }

        #endregion
    }
}
