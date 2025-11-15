using System;
using System.Windows;
using System.Windows.Input;
using System.Windows.Threading;
using Microsoft.Win32;
using Tetris.Model;
using Tetris.ViewModel;
using Tetris.Persistence;

namespace Tetris.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private TetrisGameModel _model;
        private TetrisViewModel _viewModel;
        private DispatcherTimer _uiTimer;

        public MainWindow()
        {
            InitializeComponent();
            
            // Initialize UI timer for updating display
            _uiTimer = new DispatcherTimer();
            _uiTimer.Interval = TimeSpan.FromMilliseconds(100);
            _uiTimer.Tick += UiTimer_Tick;
            
            // Initialize game with default size (8x16)
            InitializeGame(8, 16);
        }

        private void InitializeGame(int cols, int rows)
        {
            // Clean up old model if exists
            if (_model != null)
            {
                _model.GameStateChanged -= ViewModel_GameStateChanged;
                _model.GameOver -= ViewModel_GameOver;
                _model.Dispose();
            }

            // Create new model and viewmodel
            _model = new TetrisGameModel(rows, cols);
            _viewModel = new TetrisViewModel(_model);

            // Wire up events
            _viewModel.NewGame += ViewModel_NewGame;
            _viewModel.LoadGame += ViewModel_LoadGame;
            _viewModel.SaveGame += ViewModel_SaveGame;
            _viewModel.ExitGame += ViewModel_ExitGame;
            _model.GameStateChanged += ViewModel_GameStateChanged;
            _model.GameOver += ViewModel_GameOver;

            // Set DataContext
            DataContext = _viewModel;

            // Update the UniformGrid rows and columns
            UpdateGameBoard(cols, rows);
        }

        private void UpdateGameBoard(int cols, int rows)
        {
            // Each cell is 30x30 pixels
            const int cellSize = 30;
            
            GameBoard.Width = cols * cellSize;
            GameBoard.Height = rows * cellSize;
            
            // Update the ItemsPanel template
            var itemsControl = GameBoard;
            itemsControl.ItemsPanel = new System.Windows.Controls.ItemsPanelTemplate();
            var factory = new System.Windows.FrameworkElementFactory(typeof(System.Windows.Controls.Primitives.UniformGrid));
            factory.SetValue(System.Windows.Controls.Primitives.UniformGrid.RowsProperty, rows);
            factory.SetValue(System.Windows.Controls.Primitives.UniformGrid.ColumnsProperty, cols);
            itemsControl.ItemsPanel.VisualTree = factory;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // Wire up keyboard controls
            KeyDown += MainWindow_KeyDown;
            
            // Wire up board size combo box
            cmbBoardSize.SelectionChanged += CmbBoardSize_SelectionChanged;
            
            // Wire up pause button
            btnPause.Click += BtnPause_Click;
        }

        private void MainWindow_KeyDown(object sender, KeyEventArgs e)
        {
            if (_model.IsGameOver || _model.IsTimerPaused)
                return;

            switch (e.Key)
            {
                case Key.A:
                    _model.MoveLeft();
                    break;
                case Key.D:
                    _model.MoveRight();
                    break;
                case Key.S:
                    _model.MoveDown();
                    break;
                case Key.W:
                case Key.Space:
                    _model.Rotate();
                    break;
            }
        }

        private void CmbBoardSize_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            if (cmbBoardSize.SelectedItem == null)
                return;

            var item = (System.Windows.Controls.ComboBoxItem)cmbBoardSize.SelectedItem;
            var tag = item.Tag.ToString();
            var parts = tag.Split(',');
            
            if (parts.Length == 2 && int.TryParse(parts[0], out int cols) && int.TryParse(parts[1], out int rows))
            {
                InitializeGame(cols, rows);
            }
        }

        private void BtnPause_Click(object sender, RoutedEventArgs e)
        {
            if (_model.IsTimerPaused)
            {
                _model.ResumeTimer();
                _uiTimer.Start();
                btnPause.Content = "Szünet";
            }
            else if (_model.IsTimerRunning)
            {
                _model.PauseTimer();
                _uiTimer.Stop();
                btnPause.Content = "Folytat";
            }
        }

        private void UiTimer_Tick(object sender, EventArgs e)
        {
            // Force update of time display
            _viewModel.OnPropertyChanged(nameof(_viewModel.GameTime));
        }

        #region ViewModel Event Handlers

        private void ViewModel_NewGame(object? sender, EventArgs e)
        {
            _model.Reset();
            _model.StartTimer();
            _uiTimer.Start();
            btnPause.Content = "Szünet";
            btnPause.IsEnabled = true;
            btnSave.IsEnabled = true;
            
            // Enable focus for keyboard input
            Focus();
        }

        private void ViewModel_GameStateChanged(object? sender, EventArgs e)
        {
            // ViewModel will handle the refresh
        }

        private void ViewModel_GameOver(object? sender, EventArgs e)
        {
            _model.StopTimer();
            _uiTimer.Stop();
            btnPause.IsEnabled = false;
            btnSave.IsEnabled = false;
            
            // Update UI before showing message
            Dispatcher.Invoke(() => { }, System.Windows.Threading.DispatcherPriority.Render);
            
            MessageBox.Show(
                $"Játék vége!\nJátékidő: {_model.ElapsedTime:hh\\:mm\\:ss}",
                "Tetris",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }

        private async void ViewModel_LoadGame(object? sender, EventArgs e)
        {
            try
            {
                var dialog = new OpenFileDialog
                {
                    Title = "Tetris játék betöltése",
                    Filter = "Tetris fájl|*.tetris"
                };

                if (dialog.ShowDialog() == true)
                {
                    var gameState = await TetrisPersistence.LoadAsync(dialog.FileName);
                    
                    if (gameState != null)
                    {
                        // Check if board size changed
                        bool sizeChanged = gameState.Cols != _model.Cols || gameState.Rows != _model.Rows;
                        
                        if (sizeChanged)
                        {
                            // Reinitialize with loaded board size
                            InitializeGame(gameState.Cols, gameState.Rows);
                        }
                        
                        // Restore game state
                        Array.Copy(gameState.Board, _model.Board, gameState.Board.Length);
                        _model.CurrentTetrominoIndex = gameState.CurrentTetrominoIndex;
                        _model.CurrentBlock = gameState.CurrentBlock;
                        _model.BlockRow = gameState.BlockRow;
                        _model.BlockCol = gameState.BlockCol;
                        _model.SetTimerPausedTime(gameState.PausedTime);
                        
                        // Manually trigger GameStateChanged to refresh the UI
                        _model.OnGameStateChanged();
                        
                        // Update UI controls
                        btnPause.IsEnabled = true;
                        btnSave.IsEnabled = true;
                        btnPause.Content = "Szünet";
                        
                        // Update combobox selection
                        UpdateBoardSizeComboBox(gameState.Cols, gameState.Rows);
                        
                        // Focus window for keyboard input
                        Focus();
                        
                        MessageBox.Show("Játék sikeresen betöltve!", "Tetris", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"A betöltés sikertelen!\n{ex.Message}", "Hiba", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void UpdateBoardSizeComboBox(int cols, int rows)
        {
            // Update combobox to match loaded board size
            for (int i = 0; i < cmbBoardSize.Items.Count; i++)
            {
                var item = (System.Windows.Controls.ComboBoxItem)cmbBoardSize.Items[i];
                var tag = item.Tag.ToString();
                var parts = tag.Split(',');
                
                if (parts.Length == 2 && 
                    int.TryParse(parts[0], out int itemCols) && 
                    int.TryParse(parts[1], out int itemRows) &&
                    itemCols == cols && itemRows == rows)
                {
                    cmbBoardSize.SelectedIndex = i;
                    break;
                }
            }
        }

        private async void ViewModel_SaveGame(object? sender, EventArgs e)
        {
            try
            {
                var dialog = new SaveFileDialog
                {
                    Title = "Tetris játék mentése",
                    Filter = "Tetris fájl|*.tetris",
                    DefaultExt = "tetris"
                };

                if (dialog.ShowDialog() == true)
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

                    await TetrisPersistence.SaveAsync(dialog.FileName, gameState);
                    MessageBox.Show("Játék sikeresen mentve!", "Tetris", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"A mentés sikertelen!\n{ex.Message}", "Hiba", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ViewModel_ExitGame(object? sender, EventArgs e)
        {
            Close();
        }

        #endregion

        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            base.OnClosing(e);
            
            if (_model.IsTimerRunning && !_model.IsGameOver)
            {
                var result = MessageBox.Show(
                    "A játék folyamatban van. Biztosan ki szeretne lépni?",
                    "Tetris",
                    MessageBoxButton.YesNo,
                    MessageBoxImage.Question);

                if (result == MessageBoxResult.No)
                {
                    e.Cancel = true;
                    return;
                }
            }

            _uiTimer.Stop();
            _model?.Dispose();
        }
    }
}
