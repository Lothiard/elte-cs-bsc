using System;
using System.ComponentModel;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;
using Microsoft.Win32;
using Tetris.Model;
using Tetris.Persistence;
using Tetris.ViewModel;

namespace Tetris.WPF
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application, IDisposable
    {
        #region Fields

        private TetrisGameModel _model = null!;
        private TetrisViewModel _viewModel = null!;
        private MainWindow _view = null!;
        private DispatcherTimer _timer = null!;
        
        private const int CellSize = 30;

        #endregion

        #region Constructors

        /// <summary>
        /// Alkalmazás példányosítása.
        /// </summary>
        public App()
        {
            Startup += new StartupEventHandler(App_Startup);
            Exit += new ExitEventHandler(App_Exit);
        }

        #endregion

        #region Application event handlers

        private void App_Startup(object? sender, StartupEventArgs e)
        {
            _model = new TetrisGameModel(rows: 16, cols: 8);
            _model.GameStateChanged += new EventHandler(Model_GameStateChanged);
            _model.GameOver += new EventHandler(Model_GameOver);

            _viewModel = new TetrisViewModel(_model);
            _viewModel.NewGame += new EventHandler(ViewModel_NewGame);
            _viewModel.LoadGame += new EventHandler(ViewModel_LoadGame);
            _viewModel.SaveGame += new EventHandler(ViewModel_SaveGame);
            _viewModel.ExitGame += new EventHandler(ViewModel_ExitGame);
            _viewModel.PauseGame += new EventHandler(ViewModel_PauseGame);

            _timer = new DispatcherTimer();
            _timer.Interval = TimeSpan.FromMilliseconds(100);
            _timer.Tick += new EventHandler(Timer_Tick);

            _view = new MainWindow();
            _view.DataContext = _viewModel;
            _view.Closing += new CancelEventHandler(View_Closing);
            _view.KeyDown += new KeyEventHandler(View_KeyDown);

            UpdateCanvasSize(8, 16);
            DrawGame();
            
            _view.Show();
        }

        private void App_Exit(object? sender, ExitEventArgs e)
        {
            _model?.Dispose();
        }

        #endregion

        #region View event handlers

        /// <summary>
        /// Nézet bezárásának eseménykezelője.
        /// </summary>
        private void View_Closing(object? sender, CancelEventArgs e)
        {
            bool restartTimer = _model.IsTimerRunning && !_model.IsTimerPaused;
            
            if (_model.IsTimerRunning && !_model.IsTimerPaused)
            {
                _model.PauseTimer();
            }

            if (MessageBox.Show("Biztos, hogy ki akar lépni?", "Tetris", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.No)
            {
                e.Cancel = true;

                if (restartTimer)
                    _model.ResumeTimer();
            }
            else
            {
                _timer.Stop();
            }
        }

        /// <summary>
        /// Billentyűzet események kezelése.
        /// </summary>
        private void View_KeyDown(object? sender, KeyEventArgs e)
        {
            if (_model.IsGameOver || !_model.IsTimerRunning || _model.IsTimerPaused)
                return;

            switch (e.Key)
            {
                case Key.A:
                    _model.MoveLeft();
                    break;
                case Key.D:
                    _model.MoveRight();
                    break;
                case Key.W:
                    _model.Rotate();
                    break;
                case Key.S:
                    _model.MoveDown();
                    break;
            }
        }

        #endregion

        #region ViewModel event handlers

        /// <summary>
        /// Új játék indításának eseménykezelője.
        /// </summary>
        private void ViewModel_NewGame(object? sender, EventArgs e)
        {
            var comboBox = _view.cmbBoardSize;
            int cols = 8;
            
            if (comboBox.SelectedIndex == 0)
                cols = 4;
            else if (comboBox.SelectedIndex == 1)
                cols = 8;
            else if (comboBox.SelectedIndex == 2)
                cols = 12;

            _model.GameStateChanged -= Model_GameStateChanged;
            _model.GameOver -= Model_GameOver;
            _model.Dispose();

            _model = new TetrisGameModel(rows: 16, cols: cols);
            _model.GameStateChanged += Model_GameStateChanged;
            _model.GameOver += Model_GameOver;

            _viewModel.UpdateModel(_model);

            _model.Reset();
            _model.StartTimer();
            _timer.Start();

            UpdateCanvasSize(cols, 16);

            _view.btnSave.IsEnabled = false;
            _view.btnPause.Content = "Szünet";
            _view.btnPause.IsEnabled = true;
            _view.btnLoad.IsEnabled = false;

            DrawGame();
        }

        /// <summary>
        /// Játék betöltésének eseménykezelője.
        /// </summary>
        private async void ViewModel_LoadGame(object? sender, EventArgs e)
        {
            bool restartTimer = _model.IsTimerRunning && !_model.IsTimerPaused;

            if (_model.IsTimerRunning && !_model.IsTimerPaused)
            {
                _model.PauseTimer();
            }

            try
            {
                OpenFileDialog openFileDialog = new OpenFileDialog();
                openFileDialog.Title = "Tetris játék betöltése";
                openFileDialog.Filter = "Tetris mentés|*.tet";
                
                if (openFileDialog.ShowDialog() == true)
                {
                    try
                    {
                        var gameState = await TetrisPersistence.LoadAsync(openFileDialog.FileName);
                        
                        if (gameState != null)
                        {
                            _model.GameStateChanged -= Model_GameStateChanged;
                            _model.GameOver -= Model_GameOver;
                            _model.Dispose();

                            _model = new TetrisGameModel(gameState.Rows, gameState.Cols);
                            _model.GameStateChanged += Model_GameStateChanged;
                            _model.GameOver += Model_GameOver;

                            _model.Board = gameState.Board!;
                            _model.CurrentTetrominoIndex = gameState.CurrentTetrominoIndex;
                            _model.CurrentBlock = gameState.CurrentBlock;
                            _model.BlockRow = gameState.BlockRow;
                            _model.BlockCol = gameState.BlockCol;
                            _model.SetTimerPausedTime(gameState.PausedTime);

                            _viewModel.UpdateModel(_model);

                            UpdateCanvasSize(gameState.Cols, gameState.Rows);

                            if (gameState.Cols == 4)
                                _view.cmbBoardSize.SelectedIndex = 0;
                            else if (gameState.Cols == 8)
                                _view.cmbBoardSize.SelectedIndex = 1;
                            else if (gameState.Cols == 12)
                                _view.cmbBoardSize.SelectedIndex = 2;

                            _model.StartTimer();
                            _model.PauseTimer();
                            _timer.Start();

                            _view.btnPause.Content = "Folytatás";
                            _view.btnPause.IsEnabled = true;
                            _view.btnSave.IsEnabled = true;

                            DrawGame();
                        }
                    }
                    catch (TetrisDataException)
                    {
                        MessageBox.Show("A fájl betöltése sikertelen!", "Tetris", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            catch
            {
                MessageBox.Show("A fájl betöltése sikertelen!", "Tetris", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            if (restartTimer && !_model.IsGameOver)
                _model.ResumeTimer();
        }

        /// <summary>
        /// Játék mentésének eseménykezelője.
        /// </summary>
        private async void ViewModel_SaveGame(object? sender, EventArgs e)
        {
            if (!_model.IsTimerPaused)
                return;

            try
            {
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.Title = "Tetris játék mentése";
                saveFileDialog.Filter = "Tetris mentés|*.tet";
                
                if (saveFileDialog.ShowDialog() == true)
                {
                    try
                    {
                        var gameState = new TetrisPersistence.GameState
                        {
                            Rows = _model.Rows,
                            Cols = _model.Cols,
                            Board = _model.Board,
                            CurrentTetrominoIndex = _model.CurrentTetrominoIndex,
                            CurrentBlock = _model.CurrentBlock,
                            BlockRow = _model.BlockRow,
                            BlockCol = _model.BlockCol,
                            PausedTime = _model.ElapsedTime,
                            SaveTime = DateTime.Now
                        };

                        await TetrisPersistence.SaveAsync(saveFileDialog.FileName, gameState);
                    }
                    catch (TetrisDataException)
                    {
                        MessageBox.Show("Játék mentése sikertelen!" + Environment.NewLine + 
                                      "Hibás az elérési út, vagy a könyvtár nem írható.", 
                                      "Hiba!", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            catch
            {
                MessageBox.Show("A fájl mentése sikertelen!", "Tetris", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Játékból való kilépés eseménykezelője.
        /// </summary>
        private void ViewModel_ExitGame(object? sender, EventArgs e)
        {
            _view.Close();
        }

        /// <summary>
        /// Játék szüneteltetésének/folytatásának eseménykezelője.
        /// </summary>
        private void ViewModel_PauseGame(object? sender, EventArgs e)
        {
            if (!_model.IsTimerRunning || _model.IsGameOver)
                return;

            if (_model.IsTimerPaused)
            {
                _model.ResumeTimer();
                _view.btnPause.Content = "Szünet";
                _view.btnSave.IsEnabled = false;
                _view.btnLoad.IsEnabled = false;
            }
            else
            {
                _model.PauseTimer();
                _view.btnPause.Content = "Folytatás";
                _view.btnSave.IsEnabled = true;
                _view.btnLoad.IsEnabled = true;
            }
        }

        #endregion

        #region Model event handlers

        /// <summary>
        /// Játékmodell állapot megváltozásának eseménykezelője.
        /// </summary>
        private void Model_GameStateChanged(object? sender, EventArgs e)
        {
            DrawGame();
        }

        /// <summary>
        /// Játék végének eseménykezelője.
        /// </summary>
        private void Model_GameOver(object? sender, EventArgs e)
        {
            if (!Dispatcher.CheckAccess())
            {
                Dispatcher.BeginInvoke(new Action<object?, EventArgs>(Model_GameOver), sender, e);
                return;
            }

            TimeSpan finalGameTime = _model.ElapsedTime;
            
            _timer.Stop();
            _model.StopTimer();
            
            _view.btnSave.IsEnabled = false;
            _view.btnPause.IsEnabled = false;
            _view.btnLoad.IsEnabled = true;

            MessageBox.Show("Vége a játéknak!" + Environment.NewLine +
                          "Játékidő: " + finalGameTime.ToString("mm\\:ss"),
                          "Tetris",
                          MessageBoxButton.OK,
                          MessageBoxImage.Information);
        }

        #endregion

        #region Timer event handlers

        /// <summary>
        /// Időzítő eseménykezelője.
        /// </summary>
        private void Timer_Tick(object? sender, EventArgs e)
        {
            _viewModel.RefreshGameTime();
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Canvas és border méretének frissítése.
        /// </summary>
        private void UpdateCanvasSize(int cols, int rows)
        {
            double canvasWidth = cols * CellSize;
            double canvasHeight = rows * CellSize;
            
            _view.GameCanvas.Width = canvasWidth;
            _view.GameCanvas.Height = canvasHeight;
            
            _view.GameBorder.Width = canvasWidth;
            _view.GameBorder.Height = canvasHeight;
        }

        /// <summary>
        /// Játéktábla kirajzolása.
        /// </summary>
        private void DrawGame()
        {
            if (!Dispatcher.CheckAccess())
            {
                Dispatcher.BeginInvoke(new Action(DrawGame));
                return;
            }

            _view.GameCanvas.Children.Clear();

            DrawGrid();

            for (int row = 0; row < _model.Rows; row++)
            {
                for (int col = 0; col < _model.Cols; col++)
                {
                    if (_model.Board[row, col] != 0)
                    {
                        Rectangle rect = new Rectangle
                        {
                            Width = CellSize,
                            Height = CellSize,
                            Fill = new SolidColorBrush(ConvertColor(_model.TetrominoColors[_model.Board[row, col] - 1])),
                            Stroke = Brushes.Black,
                            StrokeThickness = 1
                        };

                        System.Windows.Controls.Canvas.SetLeft(rect, col * CellSize);
                        System.Windows.Controls.Canvas.SetTop(rect, row * CellSize);
                        _view.GameCanvas.Children.Add(rect);
                    }
                }
            }

            if (_model.CurrentBlock != null && !_model.IsGameOver)
            {
                System.Drawing.Color tetrominoColor = _model.TetrominoColors[_model.CurrentTetrominoIndex];
                
                foreach (var (dr, dc) in _model.CurrentBlock)
                {
                    int row = _model.BlockRow + dr;
                    int col = _model.BlockCol + dc;

                    if (row >= 0 && row < _model.Rows && col >= 0 && col < _model.Cols)
                    {
                        Rectangle rect = new Rectangle
                        {
                            Width = CellSize,
                            Height = CellSize,
                            Fill = new SolidColorBrush(ConvertColor(tetrominoColor)),
                            Stroke = Brushes.Black,
                            StrokeThickness = 1
                        };

                        System.Windows.Controls.Canvas.SetLeft(rect, col * CellSize);
                        System.Windows.Controls.Canvas.SetTop(rect, row * CellSize);
                        _view.GameCanvas.Children.Add(rect);
                    }
                }
            }
        }

        /// <summary>
        /// Háttérrács kirajzolása.
        /// </summary>
        private void DrawGrid()
        {
            var gridBrush = new SolidColorBrush(Color.FromRgb(220, 220, 220));
            
            for (int col = 0; col <= _model.Cols; col++)
            {
                Line line = new Line
                {
                    X1 = col * CellSize,
                    Y1 = 0,
                    X2 = col * CellSize,
                    Y2 = _model.Rows * CellSize,
                    Stroke = gridBrush,
                    StrokeThickness = 1
                };
                _view.GameCanvas.Children.Add(line);
            }

            for (int row = 0; row <= _model.Rows; row++)
            {
                Line line = new Line
                {
                    X1 = 0,
                    Y1 = row * CellSize,
                    X2 = _model.Cols * CellSize,
                    Y2 = row * CellSize,
                    Stroke = gridBrush,
                    StrokeThickness = 1
                };
                _view.GameCanvas.Children.Add(line);
            }
        }

        /// <summary>
        /// System.Drawing.Color konvertálása System.Windows.Media.Color-ra.
        /// </summary>
        private System.Windows.Media.Color ConvertColor(System.Drawing.Color color)
        {
            return System.Windows.Media.Color.FromArgb(color.A, color.R, color.G, color.B);
        }

        #endregion

        #region IDisposable

        /// <summary>
        /// Erőforrások felszabadítása.
        /// </summary>
        public void Dispose()
        {
            _timer?.Stop();
            
            if (_model != null)
            {
                _model.GameStateChanged -= Model_GameStateChanged;
                _model.GameOver -= Model_GameOver;
                _model.Dispose();
            }
            
            if (_viewModel != null)
            {
                _viewModel.NewGame -= ViewModel_NewGame;
                _viewModel.LoadGame -= ViewModel_LoadGame;
                _viewModel.SaveGame -= ViewModel_SaveGame;
                _viewModel.ExitGame -= ViewModel_ExitGame;
                _viewModel.PauseGame -= ViewModel_PauseGame;
            }
            
            if (_view != null)
            {
                _view.Closing -= View_Closing;
                _view.KeyDown -= View_KeyDown;
            }
        }

        #endregion
    }
}
