using System;
using System.ComponentModel;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Data.Core.Plugins;
using Avalonia.Input;
using Avalonia.Markup.Xaml;
using Avalonia.Platform.Storage;
using Avalonia.Threading;
using MsBox.Avalonia;
using MsBox.Avalonia.Enums;
using Tetris.Model;
using Tetris.Persistence;
using Tetris.Avalonia.ViewModels;
using Tetris.Avalonia.Views;

namespace Tetris.Avalonia;

public partial class App : Application, IDisposable
{
    #region Fields

    private TetrisGameModel _model = null!;
    private TetrisViewModel _viewModel = null!;
    private DispatcherTimer? _timer;
    private Canvas? _gameCanvas;
    private Control? _gameBorder;
    private MainView? _mainView;

    #endregion

    #region Properties

    private TopLevel? TopLevel
    {
        get
        {
            return ApplicationLifetime switch
            {
                IClassicDesktopStyleApplicationLifetime desktop => global::Avalonia.Controls.TopLevel.GetTopLevel(desktop.MainWindow),
                ISingleViewApplicationLifetime singleViewPlatform => global::Avalonia.Controls.TopLevel.GetTopLevel(singleViewPlatform.MainView),
                _ => null
            };
        }
    }

    #endregion

    #region Application methods

    public override void Initialize()
    {
        AvaloniaXamlLoader.Load(this);
    }

    public override void OnFrameworkInitializationCompleted()
    {
        // Line below is needed to remove Avalonia data validation.
        // Without this line you will get duplicate validations from both Avalonia and CT
        BindingPlugins.DataValidators.RemoveAt(0);

        // modell létrehozása
        _model = new TetrisGameModel(rows: 16, cols: 8);
        _model.GameStateChanged += Model_GameStateChanged;
        _model.GameOver += Model_GameOver;

        // nézetmodell létrehozása
        _viewModel = new TetrisViewModel(_model);
        _viewModel.NewGame += ViewModel_NewGame;
        _viewModel.LoadGame += ViewModel_LoadGame;
        _viewModel.SaveGame += ViewModel_SaveGame;
        _viewModel.ExitGame += ViewModel_ExitGame;
        _viewModel.PauseGame += ViewModel_PauseGame;

        // időzítő létrehozása
        _timer = new DispatcherTimer();
        _timer.Interval = TimeSpan.FromMilliseconds(100);
        _timer.Tick += Timer_Tick;

        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            var mainWindow = new MainWindow
            {
                DataContext = _viewModel
            };
            
            desktop.MainWindow = mainWindow;
            
            // Set up canvas and keyboard after window is opened
            mainWindow.Opened += (s, e) => SetupMainView(mainWindow);
        }
        else if (ApplicationLifetime is ISingleViewApplicationLifetime singleViewPlatform)
        {
            var mainView = new MainView
            {
                DataContext = _viewModel
            };
            
            singleViewPlatform.MainView = mainView;
            
            // Set up canvas and keyboard after view is attached
            mainView.AttachedToVisualTree += (s, e) => SetupMainView(mainView);
        }

        base.OnFrameworkInitializationCompleted();
    }

    /// <summary>
    /// MainView beállítása - canvas referenciák és billentyűzet kezelés.
    /// </summary>
    private void SetupMainView(Control control)
    {
        // Find MainView in the visual tree
        MainView? mainView = control is MainView mv ? mv : FindMainView(control);
        
        if (mainView != null)
        {
            _mainView = mainView;
            
            // Get canvas and border references
            var gameCanvas = mainView.FindControl<Canvas>("GameCanvas");
            var gameBorder = mainView.FindControl<Control>("GameBorder");
            
            if (gameCanvas != null && gameBorder != null)
            {
                SetCanvasReferences(gameCanvas, gameBorder);
            }
            
            // Set up keyboard handling
            mainView.KeyDown += MainView_KeyDown;
            mainView.Focus();
        }
    }

    /// <summary>
    /// MainView keresése a vizuális fában.
    /// </summary>
    private MainView? FindMainView(Control control)
    {
        if (control is MainView mainView)
            return mainView;
            
        if (control is ContentControl contentControl && contentControl.Content is Control content)
            return FindMainView(content);
            
        return null;
    }

    /// <summary>
    /// Billentyűzet események kezelése.
    /// </summary>
    private void MainView_KeyDown(object? sender, KeyEventArgs e)
    {
        switch (e.Key)
        {
            case Key.A:
                _viewModel.MoveLeftCommand.Execute(null);
                e.Handled = true;
                break;
            case Key.D:
                _viewModel.MoveRightCommand.Execute(null);
                e.Handled = true;
                break;
            case Key.W:
                _viewModel.RotateCommand.Execute(null);
                e.Handled = true;
                break;
            case Key.S:
                _viewModel.MoveDownCommand.Execute(null);
                e.Handled = true;
                break;
        }
    }

    #endregion

    #region Public methods

    /// <summary>
    /// Canvas és border referenciák beállítása.
    /// </summary>
    public void SetCanvasReferences(Canvas gameCanvas, Control gameBorder)
    {
        _gameCanvas = gameCanvas;
        _gameBorder = gameBorder;
        
        if (_gameCanvas != null && _gameBorder != null)
        {
            GameRenderer.UpdateCanvasSize(_gameCanvas, _gameBorder, 8, 16);
            GameRenderer.DrawGame(_gameCanvas, _model);
        }
    }

    #endregion

    #region Model event handlers

    /// <summary>
    /// Játékmodell állapot megváltozásának eseménykezelője.
    /// </summary>
    private void Model_GameStateChanged(object? sender, EventArgs e)
    {
        if (_gameCanvas != null)
        {
            GameRenderer.DrawGame(_gameCanvas, _model);
        }
    }

    /// <summary>
    /// Játék végének eseménykezelője.
    /// </summary>
    private async void Model_GameOver(object? sender, EventArgs e)
    {
        await Dispatcher.UIThread.InvokeAsync(async () =>
        {
            TimeSpan finalGameTime = _model.ElapsedTime;
            
            _timer?.Stop();
            _model.StopTimer();

            // Update button states
            if (_mainView != null)
            {
                var btnSave = _mainView.FindControl<Button>("btnSave");
                var btnPause = _mainView.FindControl<Button>("btnPause");
                var btnLoad = _mainView.FindControl<Button>("btnLoad");
                
                if (btnSave != null) btnSave.IsEnabled = false;
                if (btnPause != null) btnPause.IsEnabled = false;
                if (btnLoad != null) btnLoad.IsEnabled = true;
            }

            await MessageBoxManager.GetMessageBoxStandard(
                    "Tetris",
                    $"Vége a játéknak!{Environment.NewLine}Játékidő: {finalGameTime:mm\\:ss}",
                    ButtonEnum.Ok,
                    Icon.Info)
                .ShowAsync();
        });
    }

    #endregion

    #region ViewModel event handlers

    /// <summary>
    /// Új játék indításának eseménykezelője.
    /// </summary>
    private void ViewModel_NewGame(object? sender, EventArgs e)
    {
        int cols = 8; // Default value
        
        // Get board size from ComboBox if MainView is available
        if (_mainView != null)
        {
            var cmbBoardSize = _mainView.FindControl<ComboBox>("cmbBoardSize");
            if (cmbBoardSize != null)
            {
                cols = cmbBoardSize.SelectedIndex switch
                {
                    0 => 4,
                    1 => 8,
                    2 => 12,
                    _ => 8
                };
            }
        }

        _model.GameStateChanged -= Model_GameStateChanged;
        _model.GameOver -= Model_GameOver;
        _model.Dispose();

        _model = new TetrisGameModel(rows: 16, cols: cols);
        _model.GameStateChanged += Model_GameStateChanged;
        _model.GameOver += Model_GameOver;

        _viewModel.UpdateModel(_model);

        _model.Reset();
        _model.StartTimer();
        _timer?.Start();

        if (_gameCanvas != null && _gameBorder != null)
        {
            GameRenderer.UpdateCanvasSize(_gameCanvas, _gameBorder, cols, 16);
            GameRenderer.DrawGame(_gameCanvas, _model);
        }

        // Update button states
        if (_mainView != null)
        {
            var btnSave = _mainView.FindControl<Button>("btnSave");
            var btnPause = _mainView.FindControl<Button>("btnPause");
            var btnLoad = _mainView.FindControl<Button>("btnLoad");
            
            if (btnSave != null) btnSave.IsEnabled = false;
            if (btnPause != null)
            {
                btnPause.Content = "Szünet";
                btnPause.IsEnabled = true;
            }
            if (btnLoad != null) btnLoad.IsEnabled = false;
        }
    }

    /// <summary>
    /// Játék betöltésének eseménykezelője.
    /// </summary>
    private async void ViewModel_LoadGame(object? sender, EventArgs e)
    {
        if (TopLevel == null)
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Tetris",
                    "A fájlkezelés nem támogatott!",
                    ButtonEnum.Ok, Icon.Error)
                .ShowAsync();
            return;
        }

        bool restartTimer = _model.IsTimerRunning && !_model.IsTimerPaused;

        if (_model.IsTimerRunning && !_model.IsTimerPaused)
        {
            _model.PauseTimer();
        }

        try
        {
            var files = await TopLevel.StorageProvider.OpenFilePickerAsync(new FilePickerOpenOptions
            {
                Title = "Tetris játék betöltése",
                AllowMultiple = false,
                FileTypeFilter = new[]
                {
                    new FilePickerFileType("Tetris mentés")
                    {
                        Patterns = new[] { "*.tet" }
                    }
                }
            });

            if (files.Count > 0)
            {
                try
                {
                    var filePath = files[0].TryGetLocalPath();
                    if (filePath != null)
                    {
                        var gameState = await TetrisPersistence.LoadAsync(filePath);
                        
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

                            _viewModel.UpdateModel(_model);

                            if (_gameCanvas != null && _gameBorder != null)
                            {
                                GameRenderer.UpdateCanvasSize(_gameCanvas, _gameBorder, gameState.Cols, gameState.Rows);
                            }

                            _model.StartTimer();
                            _model.PauseTimer();
                            _model.SetTimerPausedTime(gameState.PausedTime);
                            _timer?.Start();

                            if (_gameCanvas != null)
                            {
                                GameRenderer.DrawGame(_gameCanvas, _model);
                            }

                            // Update ComboBox and button states
                            if (_mainView != null)
                            {
                                var cmbBoardSize = _mainView.FindControl<ComboBox>("cmbBoardSize");
                                if (cmbBoardSize != null)
                                {
                                    cmbBoardSize.SelectedIndex = gameState.Cols switch
                                    {
                                        4 => 0,
                                        8 => 1,
                                        12 => 2,
                                        _ => 1
                                    };
                                }

                                var btnPause = _mainView.FindControl<Button>("btnPause");
                                var btnSave = _mainView.FindControl<Button>("btnSave");
                                
                                if (btnPause != null)
                                {
                                    btnPause.Content = "Folytatás";
                                    btnPause.IsEnabled = true;
                                }
                                if (btnSave != null) btnSave.IsEnabled = true;
                            }
                        }
                    }
                }
                catch (TetrisDataException)
                {
                    await MessageBoxManager.GetMessageBoxStandard(
                            "Tetris",
                            "A fájl betöltése sikertelen!",
                            ButtonEnum.Ok,
                            Icon.Error)
                        .ShowAsync();
                }
            }
        }
        catch
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Tetris",
                    "A fájl betöltése sikertelen!",
                    ButtonEnum.Ok,
                    Icon.Error)
                .ShowAsync();
        }

        if (restartTimer && !_model.IsGameOver)
            _model.ResumeTimer();
    }

    /// <summary>
    /// Játék mentésének eseménykezelője.
    /// </summary>
    private async void ViewModel_SaveGame(object? sender, EventArgs e)
    {
        if (TopLevel == null)
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Tetris",
                    "A fájlkezelés nem támogatott!",
                    ButtonEnum.Ok, Icon.Error)
                .ShowAsync();
            return;
        }

        if (!_model.IsTimerPaused)
            return;

        try
        {
            var file = await TopLevel.StorageProvider.SaveFilePickerAsync(new FilePickerSaveOptions
            {
                Title = "Tetris játék mentése",
                FileTypeChoices = new[]
                {
                    new FilePickerFileType("Tetris mentés")
                    {
                        Patterns = new[] { "*.tet" }
                    }
                },
                DefaultExtension = "tet"
            });

            if (file != null)
            {
                try
                {
                    var filePath = file.TryGetLocalPath();
                    if (filePath != null)
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

                        await TetrisPersistence.SaveAsync(filePath, gameState);
                    }
                }
                catch (TetrisDataException)
                {
                    await MessageBoxManager.GetMessageBoxStandard(
                            "Hiba!",
                            $"Játék mentése sikertelen!{Environment.NewLine}Hibás az elérési út, vagy a könyvtár nem írható.",
                            ButtonEnum.Ok,
                            Icon.Error)
                        .ShowAsync();
                }
            }
        }
        catch
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Tetris",
                    "A fájl mentése sikertelen!",
                    ButtonEnum.Ok,
                    Icon.Error)
                .ShowAsync();
        }
    }

    /// <summary>
    /// Játékból való kilépés eseménykezelője.
    /// </summary>
    private void ViewModel_ExitGame(object? sender, EventArgs e)
    {
        var window = ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop
            ? desktop.MainWindow
            : null;
        
        window?.Close();
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
            
            if (_mainView != null)
            {
                var btnPause = _mainView.FindControl<Button>("btnPause");
                var btnSave = _mainView.FindControl<Button>("btnSave");
                var btnLoad = _mainView.FindControl<Button>("btnLoad");
                
                if (btnPause != null) btnPause.Content = "Szünet";
                if (btnSave != null) btnSave.IsEnabled = false;
                if (btnLoad != null) btnLoad.IsEnabled = false;
            }
        }
        else
        {
            _model.PauseTimer();
            
            if (_mainView != null)
            {
                var btnPause = _mainView.FindControl<Button>("btnPause");
                var btnSave = _mainView.FindControl<Button>("btnSave");
                var btnLoad = _mainView.FindControl<Button>("btnLoad");
                
                if (btnPause != null) btnPause.Content = "Folytatás";
                if (btnSave != null) btnSave.IsEnabled = true;
                if (btnLoad != null) btnLoad.IsEnabled = true;
            }
        }
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

        GC.SuppressFinalize(this);
    }

    #endregion
}
