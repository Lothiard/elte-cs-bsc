using System;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Data.Core.Plugins;
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

        // nézemodell létrehozása
        _viewModel = new TetrisViewModel(_model);
        _viewModel.NewGame += ViewModel_NewGame;
        _viewModel.LoadGame += ViewModel_LoadGame;
        _viewModel.SaveGame += ViewModel_SaveGame;
        _viewModel.ExitGame += ViewModel_ExitGame;
        _viewModel.PauseGame += ViewModel_PauseGame;

        _timer = new DispatcherTimer();
        _timer.Interval = TimeSpan.FromMilliseconds(100);
        _timer.Tick += Timer_Tick;

        // nézet létrehozása
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            // asztali környezethez
            desktop.MainWindow = new MainWindow
            {
                DataContext = _viewModel
            };

            desktop.MainWindow.Opened += (s, e) =>
            {
                InitialRender();
                desktop.MainWindow.Focus();
            };
        }
        else if (ApplicationLifetime is ISingleViewApplicationLifetime singleViewPlatform)
        {
            // mobil környezethez
            singleViewPlatform.MainView = new MainView
            {
                DataContext = _viewModel
            };

            if (singleViewPlatform.MainView is Control control)
            {
                control.AttachedToVisualTree += (s, e) =>
                {
                    InitialRender();
                    control.Focus();
                };
            }
        }

        base.OnFrameworkInitializationCompleted();
    }

    /// <summary>
    /// Kezdeti renderelés.
    /// </summary>
    private void InitialRender()
    {
        var (canvas, border) = GetCanvasReferences();
        if (canvas != null && border != null)
        {
            GameRenderer.UpdateCanvasSize(canvas, border, 8, 16);
        }
    }

    /// <summary>
    /// Canvas referenciák lekérése.
    /// </summary>
    private (Canvas? canvas, Control? border) GetCanvasReferences()
    {
        Control? rootControl = ApplicationLifetime switch
        {
            IClassicDesktopStyleApplicationLifetime desktop => desktop.MainWindow?.Content as Control,
            ISingleViewApplicationLifetime singleViewPlatform => singleViewPlatform.MainView as Control,
            _ => null
        };

        if (rootControl != null)
        {
            var canvas = rootControl.FindControl<Canvas>("GameCanvas");
            var border = rootControl.FindControl<Control>("GameBorder");
            return (canvas, border);
        }

        return (null, null);
    }

    #endregion

    #region Model event handlers

    /// <summary>
    /// Játékmodell állapot megváltozásának eseménykezelője.
    /// </summary>
    private void Model_GameStateChanged(object? sender, EventArgs e)
    {
        Dispatcher.UIThread.InvokeAsync(() =>
        {
            var (canvas, _) = GetCanvasReferences();
            if (canvas != null)
            {
                GameRenderer.DrawGame(canvas, _model);
            }
        });
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
        int cols = _viewModel.SelectedBoardSize switch
        {
            0 => 4,
            1 => 8,
            2 => 12,
            _ => 8
        };

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

        var (canvas, border) = GetCanvasReferences();
        if (canvas != null && border != null)
        {
            GameRenderer.UpdateCanvasSize(canvas, border, cols, 16);
            GameRenderer.DrawGame(canvas, _model);
        }

        _viewModel.SetNewGameState();
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

                            var (canvas, border) = GetCanvasReferences();
                            if (canvas != null && border != null)
                            {
                                GameRenderer.UpdateCanvasSize(canvas, border, gameState.Cols, gameState.Rows);
                                GameRenderer.DrawGame(canvas, _model);
                            }

                            _model.StartTimer();
                            _model.PauseTimer();
                            _model.SetTimerPausedTime(gameState.PausedTime);
                            _timer?.Start();

                            _viewModel.SelectedBoardSize = gameState.Cols switch
                            {
                                4 => 0,
                                8 => 1,
                                12 => 2,
                                _ => 1
                            };

                            _viewModel.SetPausedState();
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
            _viewModel.SetResumedState();
        }
        else
        {
            _model.PauseTimer();
            _viewModel.SetPausedState();
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
