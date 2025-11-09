using System;
using System.Windows;
using ELTE.TicTacToeGame.Model;
using ELTE.TicTacToeGame.Persistence;
using ELTE.TicTacToeGame.ViewModel;
using Microsoft.Win32;

namespace ELTE.TicTacToeGame.View
{
    /// <summary>
    /// Alkalmazás típusa.
    /// </summary>
    public partial class App : Application
    {
        private ITicTacToeDataAccess _dataAccess = null!;
        private ITicTacToeModel _model = null!;
        private TicTacToeViewModel _viewModel = null!;
        private TicTacToeWindow _window = null!;
        private OpenFileDialog? _openFileDialog;
        private SaveFileDialog? _saveFileDialog;

        /// <summary>
        /// Alkalmazás példányosítása.
        /// </summary>
        public App()
        {
            Startup += new StartupEventHandler(App_Startup);
        }

        /// <summary>
        /// Alkalmazás indulásának eseménykezelője.
        /// </summary>
        private void App_Startup(object sender, StartupEventArgs e)
        {
            _dataAccess = new TicTacToeBinaryFileDataAccess();

            _model = new BasicTicTacToeModel(_dataAccess);
            _model.GameWon += new EventHandler<GameWonEventArgs>(Model_GameWon);
            _model.GameOver += new EventHandler(Model_GameOver);
            _model.NewGame();

            _viewModel = new TicTacToeViewModel(_model);
            _viewModel.LoadGame += new EventHandler(ViewModel_LoadGame); // kezeljük a nézetmodell eseményeit
            _viewModel.SaveGame += new EventHandler(ViewModel_SaveGame);
            _viewModel.GameExit += new EventHandler(ViewModel_GameExit);

            _window = new TicTacToeWindow();
            _window.DataContext = _viewModel;
            _window.Show();
        }

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
        }

        /// <summary>
        /// Játék végének eseménykezelése.
        /// </summary>
        private void Model_GameOver(object? sender, EventArgs e)
        {
            MessageBox.Show("Döntetlen játék!", "Játék vége!", MessageBoxButton.OK, MessageBoxImage.Asterisk);
            _model.NewGame();
        }

        #endregion

        #region ViewModel event handlers

        /// <summary>
        /// Játék betöltésének eseménykezelője.
        /// </summary>
        private async void ViewModel_LoadGame(object? sender, System.EventArgs e)
        {
            if (_openFileDialog == null)
            {
                _openFileDialog = new OpenFileDialog();
                _openFileDialog.Title = "Tic-Tac-Toe - Játék betöltése";
                _openFileDialog.Filter = "Szövegfájlok|*.txt";
            }

            // nyithatunk új nézetet
            if (_openFileDialog.ShowDialog() == true)
            {
                try
                {
                    await _model.LoadGameAsync(_openFileDialog.FileName); // játék betöltése
                }
                catch (TicTacToeDataException)
                {
                    MessageBox.Show("Hiba keletkezett a betöltés során.", "Tic-Tac-Toe", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        /// <summary>
        /// Játék mentésének eseménykezelője.
        /// </summary>
        private async void ViewModel_SaveGame(object? sender, System.EventArgs e)
        {
            if (_saveFileDialog == null)
            {
                _saveFileDialog = new SaveFileDialog();
                _saveFileDialog.Title = "Tic-Tac-Toe - Játék mentése";
                _saveFileDialog.Filter = "Szövegfájlok|*.txt";
            }

            if (_saveFileDialog.ShowDialog() == true)
            {
                try
                {
                    await _model.SaveGameAsync(_saveFileDialog.FileName); // játék mentése
                }
                catch (TicTacToeDataException)
                {
                    MessageBox.Show("Hiba keletkezett a mentés során.", "Tic-Tac-Toe", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        /// <summary>
        /// Kilépés eseménykezelője.
        /// </summary>
        private void ViewModel_GameExit(object? sender, System.EventArgs e)
        {
            Shutdown(); // a teljes alkalmazás bezárása
        }

        #endregion
    }
}
