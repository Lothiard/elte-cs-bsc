using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using ELTE.TicTacToeGame.Model;
using ELTE.TicTacToeGame.Persistence;
using Microsoft.Win32;

namespace ELTE.TicTacToeGame.View
{
    /// <summary>
    /// Tic-Tac-Toe ablak típusa.
    /// </summary>
    public partial class TicTacToeWindow : Window
    {
        #region Private fields

        private TicTacToeModel _model; // játék
        private Button[,] _buttonGrid; // gombrács
        private OpenFileDialog? _openFileDialog;
        private SaveFileDialog? _saveFileDialog;

        #endregion

        #region Constructors

        /// <summary>
        /// Tic-Tac-Toe ablak példányosítása.
        /// </summary>
        public TicTacToeWindow()
        {
            InitializeComponent();

            // modell létrehozása és eseménykezelők társítása
            _model = new TicTacToeModel(new TicTacToeBinaryFileDataAccess());
            // a modellt úgy hozzuk létre, hogy fájl alapú adateléréssel fog rendelkezni

            _model.FieldChanged += new EventHandler<FieldChangedEventArgs>(Model_FieldChanged);
            _model.GameOver += new EventHandler(Model_GameOver);
            _model.GameWon += new EventHandler<GameWonEventArgs>(Model_GameWon);

            _buttonGrid = null!; // kezdetben null, de használat előtt garantáltan inicializáljuk majd
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Tábla létrehozása.
        /// </summary>
        private void GenerateTable()
        {
            _buttonGrid = new Button[3, 3];
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    _buttonGrid[i, j] = new GridButton(i, j);
                    _buttonGrid[i, j].FontSize = Height / 5; // betűméret
                    _buttonGrid[i, j].Background = Brushes.White;
                    _buttonGrid[i, j].Click += new RoutedEventHandler(Button_Click);
                    // közös eseménykezelő hozzárendelése minden gombhoz

                    _buttonGrid[i, j].SetValue(Grid.RowProperty, i);
                    _buttonGrid[i, j].SetValue(Grid.ColumnProperty, j);
                    // beállítjuk a függőségi tulajdonságokat

                    _gameGrid.Children.Add(_buttonGrid[i, j]);
                    // felvesszük az ablakra a gombot
                }
        }

        /// <summary>
        /// Tábla beállítása.
        /// </summary>
        private void SetTable()
        {
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    switch (_model[i, j])
                    {
                        case Player.PlayerO:
                            _buttonGrid[i, j].Background = Brushes.Yellow;
                            _buttonGrid[i, j].Content = "O";
                            break;
                        case Player.PlayerX:
                            _buttonGrid[i, j].Background = Brushes.Orange;
                            _buttonGrid[i, j].Content = "X";
                            break;
                        case Player.NoPlayer:
                            _buttonGrid[i, j].Background = Brushes.White;
                            _buttonGrid[i, j].Content = String.Empty;
                            break;
                    }
                }
        }

        #endregion

        #region Model event handlers

        /// <summary>
        /// Játék megnyerésének eseménykezelése.
        /// </summary>
        private void Model_GameWon(object? sender, GameWonEventArgs e)
        {
            switch (e.Player)
            {
                case Player.PlayerO:
                    MessageBox.Show("A kör játékos győzött!", "Játék vége!", MessageBoxButton.OK, MessageBoxImage.Asterisk);
                    break;
                case Player.PlayerX:
                    MessageBox.Show("A kereszt játékos győzött!", "Játék vége!", MessageBoxButton.OK, MessageBoxImage.Asterisk);
                    break;
            }
            _model.NewGame();
            SetTable();
        }

        /// <summary>
        /// Játék végének eseménykezelése.
        /// </summary>
        private void Model_GameOver(object? sender, EventArgs e)
        {
            MessageBox.Show("Döntetlen játék!", "Játék vége!", MessageBoxButton.OK, MessageBoxImage.Asterisk);
            _model.NewGame();
            SetTable();
        }

        /// <summary>
        /// Modell mezőváltozásának eseménykezelése.
        /// </summary>
        private void Model_FieldChanged(object? sender, FieldChangedEventArgs e)
        {
            switch (e.Player)
            {
                case Player.PlayerO:
                    _buttonGrid[e.X, e.Y].Background = Brushes.Yellow;
                    _buttonGrid[e.X, e.Y].Content = "O";
                    break;
                case Player.PlayerX:
                    _buttonGrid[e.X, e.Y].Background = Brushes.Orange;
                    _buttonGrid[e.X, e.Y].Content = "X";
                    break;
                case Player.NoPlayer:
                    _buttonGrid[e.X, e.Y].Background = Brushes.White;
                    _buttonGrid[e.X, e.Y].Content = String.Empty;
                    break;
            }
        }

        #endregion

        #region Window event handlers

        /// <summary>
        /// Ablak betöltésének eseménykezelése.
        /// </summary>
        private void Window_Loaded(object? sender, RoutedEventArgs e)
        {
            _model.NewGame();

            GenerateTable();

            SizeChanged += new SizeChangedEventHandler(Window_SizeChanged);
        }

        /// <summary>
        /// Ablak méretváltásának eseménykezelése.
        /// </summary>
        private void Window_SizeChanged(object? sender, SizeChangedEventArgs e)
        {
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    // a gombok szövegméretét állítjuk be az új mérethez arányosan
                    _buttonGrid[i, j].FontSize = Height / 5;
                }
        }

        #endregion

        #region Grid event handlers

        /// <summary>
        /// Gombrács eseménykezelője.
        /// </summary>
        private void Button_Click(object? sender, RoutedEventArgs e)
        {
            if (sender is GridButton button)
            {
                Int32 x = button.GridX; // rácskoordináták kiolvasása
                Int32 y = button.GridY;

                try
                {
                    _model.StepGame(x, y); // lépés a játékban
                }
                catch
                {
                }
            }
        }

        #endregion

        #region Menu event handlers

        /// <summary>
        /// Új játék menüpontjának eseménykezelője.
        /// </summary>
        private void MenuGameNew_Click(object sender, RoutedEventArgs e)
        {
            _model.NewGame();
            SetTable();
        }

        /// <summary>
        /// Játék betöltés menüpontjának eseménykezelője.
        /// </summary>
        private async void MenuGameLoad_Click(object sender, RoutedEventArgs e)
        {
            if (_openFileDialog == null)
            {
                _openFileDialog = new OpenFileDialog();
                _openFileDialog.Title = "Tic-Tac-Toe - Játék betöltése";
                _openFileDialog.Filter = "Játékmentések|*.sav";
            }

            if (_openFileDialog.ShowDialog() == true)
            {
                try
                {
                    await _model.LoadGameAsync(_openFileDialog.FileName);
                }
                catch (TicTacToeDataException)
                {
                    MessageBox.Show("Hiba keletkezett a betöltés során.", "Tic-Tac-Toe", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        /// <summary>
        /// Játék mentés menüpontjának eseménykezelője.
        /// </summary>
        private async void MenuGameSave_Click(object sender, RoutedEventArgs e)
        {
            if (_saveFileDialog == null)
            {
                _saveFileDialog = new SaveFileDialog();
                _saveFileDialog.Title = "Tic-Tac-Toe - Játék mentése";
                _saveFileDialog.Filter = "Játékmentések|*.sav";
            }

            if (_saveFileDialog.ShowDialog() == true)
            {
                try
                {
                    await _model.SaveGameAsync(_saveFileDialog.FileName);
                }
                catch (TicTacToeDataException)
                {
                    MessageBox.Show("Hiba keletkezett a mentés során.", "Tic-Tac-Toe", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        /// <summary>
        /// Kilépés menüpontjának eseménykezelője.
        /// </summary>
        private void MenuGameExit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        #endregion
    }
}
