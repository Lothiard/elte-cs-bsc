using System;
using System.Collections.ObjectModel;
using System.Linq;
using Avalonia.Threading;
using CommunityToolkit.Mvvm.Input;
using ELTE.Sudoku.Model;
using ELTE.Sudoku.Persistence;

namespace ELTE.Sudoku.Avalonia.ViewModels
{
    /// <summary>
    /// Sudoku nézetmodell típusa.
    /// </summary>
    public class SudokuViewModel : ViewModelBase
    {
        #region Fields

        private SudokuGameModel _model; // modell

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
        /// Kilépés parancs lekérdezése.
        /// </summary>
        public RelayCommand ExitCommand { get; private set; }

        /// <summary>
        /// Játékmező gyűjtemény lekérdezése.
        /// </summary>
        public ObservableCollection<SudokuField> Fields { get; set; }

        /// <summary>
        /// Lépések számának lekérdezése.
        /// </summary>
        public Int32 GameStepCount
        {
            get { return _model.GameStepCount; }
        }

        /// <summary>
        /// Fennmaradt játékidő lekérdezése.
        /// </summary>
        public String GameTime
        {
            get { return TimeSpan.FromSeconds(_model.GameTime).ToString("g"); }
        }

        /// <summary>
        /// Alacsony nehézségi szint állapotának lekérdezése.
        /// </summary>
        public Boolean IsGameEasy
        {
            get { return _model.GameDifficulty == GameDifficulty.Easy; }
            set
            {
                if (_model.GameDifficulty == GameDifficulty.Easy)
                    return;

                _model.GameDifficulty = GameDifficulty.Easy;
                OnPropertyChanged(nameof(IsGameEasy));
                OnPropertyChanged(nameof(IsGameMedium));
                OnPropertyChanged(nameof(IsGameHard));
            }
        }

        /// <summary>
        /// Közepes nehézségi szint állapotának lekérdezése.
        /// </summary>
        public Boolean IsGameMedium
        {
            get { return _model.GameDifficulty == GameDifficulty.Medium; }
            set
            {
                if (_model.GameDifficulty == GameDifficulty.Medium)
                    return;

                _model.GameDifficulty = GameDifficulty.Medium;
                OnPropertyChanged(nameof(IsGameEasy));
                OnPropertyChanged(nameof(IsGameMedium));
                OnPropertyChanged(nameof(IsGameHard));
            }
        }

        /// <summary>
        /// Magas nehézségi szint állapotának lekérdezése.
        /// </summary>
        public Boolean IsGameHard
        {
            get { return _model.GameDifficulty == GameDifficulty.Hard; }
            set
            {
                if (_model.GameDifficulty == GameDifficulty.Hard)
                    return;

                _model.GameDifficulty = GameDifficulty.Hard;
                OnPropertyChanged(nameof(IsGameEasy));
                OnPropertyChanged(nameof(IsGameMedium));
                OnPropertyChanged(nameof(IsGameHard));
            }
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
        /// Sudoku nézetmodell példányosítása.
        /// </summary>
        /// <param name="model">A modell típusa.</param>
        public SudokuViewModel(SudokuGameModel model)
        {
            // játék csatlakoztatása
            _model = model;
            _model.FieldChanged += new EventHandler<SudokuFieldEventArgs>(Model_FieldChanged);
            _model.GameAdvanced += new EventHandler<SudokuEventArgs>(Model_GameAdvanced);
            _model.GameOver += new EventHandler<SudokuEventArgs>(Model_GameOver);
            _model.GameCreated += new EventHandler<SudokuEventArgs>(Model_GameCreated);

            // parancsok kezelése
            NewGameCommand = new RelayCommand(OnNewGame);
            LoadGameCommand = new RelayCommand(OnLoadGame);
            SaveGameCommand = new RelayCommand(OnSaveGame);
            ExitCommand = new RelayCommand(OnExitGame);

            // játéktábla létrehozása
            Fields = new ObservableCollection<SudokuField>();
            for (Int32 i = 0; i < _model.TableSize; i++) // inicializáljuk a mezőket
            {
                for (Int32 j = 0; j < _model.TableSize; j++)
                {
                    Fields.Add(new SudokuField
                    {
                        IsLocked = true,
                        Text = String.Empty,
                        X = i,
                        Y = j,
                        StepCommand = new RelayCommand<Tuple<Int32, Int32>>(position =>
                        {
                            if (position != null)
                                StepGame(position.Item1, position.Item2);
                        })
                        // ha egy mezőre léptek, akkor jelezzük a léptetést, változtatjuk a lépésszámot
                    });
                }
            }

            RefreshTable();
        }

        public SudokuViewModel() :this(new SudokuGameModel(new SudokuFileDataAccess(), new SudokuTimerInheritance()))
        {
            
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Tábla frissítése.
        /// </summary>
        private void RefreshTable()
        {
            foreach (SudokuField field in Fields) // inicializálni kell a mezőket is
            {
                field.Text = !_model.IsEmpty(field.X, field.Y) ? _model[field.X, field.Y].ToString() : String.Empty;
                field.IsLocked = _model.IsLocked(field.X, field.Y);
            }

            OnPropertyChanged(nameof(GameTime));
            OnPropertyChanged(nameof(GameStepCount));
        }

        /// <summary>
        /// Játék léptetése eseménykiváltása.
        /// </summary>
        /// <param name="x">A lépett mező X koordinátája.</param>
        /// <param name="y">A lépett mező Y koordinátája.</param>
        private void StepGame(Int32 x, Int32 y)
        {
            _model.Step(x, y);
        }

        #endregion

        #region Game event handlers

        /// <summary>
        /// Játékmodell mező megváltozásának eseménykezelője.
        /// </summary>
        private void Model_FieldChanged(object? sender, SudokuFieldEventArgs e)
        {
            // mező frissítése
            SudokuField field = Fields.Single(f => f.X == e.X && f.Y == e.Y);

            field.Text =
                !_model.IsEmpty(field.X, field.Y)
                    ? _model[field.X, field.Y].ToString()
                    : String.Empty; // visszaírjuk a szöveget
            OnPropertyChanged(nameof(GameStepCount)); // jelezzük a lépésszám változást
        }

        /// <summary>
        /// Játék végének eseménykezelője.
        /// </summary>
        private void Model_GameOver(object? sender, SudokuEventArgs e)
        {
            foreach (SudokuField field in Fields)
            {
                field.IsLocked = true; // minden mezőt lezárunk
            }
        }

        /// <summary>
        /// Játék előrehaladásának eseménykezelője.
        /// </summary>
        private void Model_GameAdvanced(object? sender, SudokuEventArgs e)
        {
            if (!Dispatcher.UIThread.CheckAccess()) // hamisat ad vissza, ha nem a dispatcher thread-en vagyunk
            {
                Dispatcher.UIThread.InvokeAsync(() => { Model_GameAdvanced(sender, e); });
                return;
            }

            OnPropertyChanged(nameof(GameTime));
        }

        /// <summary>
        /// Játék létrehozásának eseménykezelője.
        /// </summary>
        private void Model_GameCreated(object? sender, SudokuEventArgs e)
        {
            RefreshTable();
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
