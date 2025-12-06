using System;
using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Data.Core.Plugins;
using Avalonia.Markup.Xaml;
using ELTE.Sudoku.Model;
using ELTE.Sudoku.Persistence;
using ELTE.Sudoku.Avalonia.ViewModels;
using ELTE.Sudoku.Avalonia.Views;
using MsBox.Avalonia;
using MsBox.Avalonia.Enums;
using System.ComponentModel;
using System.IO;
using Avalonia.Controls;
using Avalonia.Platform.Storage;
using Avalonia.Platform;
using Avalonia.Threading;

namespace ELTE.Sudoku.Avalonia;

public partial class App : Application
{
    #region Fields

    private SudokuGameModel _model = null!;
    private SudokuViewModel _viewModel = null!;

    #endregion

    #region Properites

    private TopLevel? TopLevel
    {
        get
        {
            return ApplicationLifetime switch
            {
                IClassicDesktopStyleApplicationLifetime desktop => TopLevel.GetTopLevel(desktop.MainWindow),
                ISingleViewApplicationLifetime singleViewPlatform => TopLevel.GetTopLevel(singleViewPlatform.MainView),
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
        _model = new SudokuGameModel(new SudokuFileDataAccess(), new SudokuTimerInheritance());
        _model.GameOver += new EventHandler<SudokuEventArgs>(Model_GameOver);
        _model.NewGame();

        // nézemodell létrehozása
        _viewModel = new SudokuViewModel(_model);
        _viewModel.NewGame += new EventHandler(ViewModel_NewGame);
        _viewModel.LoadGame += new EventHandler(ViewModel_LoadGame);
        _viewModel.SaveGame += new EventHandler(ViewModel_SaveGame);

        // nézet létrehozása
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            // asztali környezethez
            desktop.MainWindow = new MainWindow
            {
                DataContext = _viewModel
            };

            desktop.Startup += async (s, e) =>
            {
                _model.NewGame(); // indításkor új játékot kezdünk

                // betöltjük a felfüggesztett játékot, amennyiben van
                try
                {
                    await _model.LoadGameAsync(
                        Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), "SudokuSuspendedGame"));
                }
                catch { }
            };

            desktop.Exit += async (s, e) =>
            {
                // elmentjük a jelenleg folyó játékot
                try
                {
                    await _model.SaveGameAsync(
                        Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), "SudokuSuspendedGame"));
                    // mentés a felhasználó Documents könyvtárába, oda minden bizonnyal van jogunk írni
                }
                catch { }
            };
        }
        else if (ApplicationLifetime is ISingleViewApplicationLifetime singleViewPlatform)
        {
            // mobil környezethez
            singleViewPlatform.MainView = new MainView
            {
                DataContext = _viewModel
            };

            if (Application.Current?.TryGetFeature<IActivatableLifetime>() is { } activatableLifetime)
            {
                activatableLifetime.Activated += async (sender, args) =>
                {
                    if (args.Kind == ActivationKind.Background)
                    {
                        // betöltjük a felfüggesztett játékot, amennyiben van
                        try
                        {
                            await _model.LoadGameAsync(
                                Path.Combine(AppContext.BaseDirectory, "SuspendedGame"));
                        }
                        catch
                        {
                        }
                    }
                };
                activatableLifetime.Deactivated += async (sender, args) =>
                {
                    if (args.Kind == ActivationKind.Background)
                    {

                        // elmentjük a jelenleg folyó játékot
                        try
                        {
                            await _model.SaveGameAsync(
                                Path.Combine(AppContext.BaseDirectory, "SuspendedGame"));
                            // Androidon az AppContext.BaseDirectory az alkalmazás adat könyvtára, ahova
                            // akár külön jogosultság nélkül is lehetne írni
                        }
                        catch
                        {
                        }
                    }
                };
            }
        }

        base.OnFrameworkInitializationCompleted();
    }

    #endregion

    #region ViewModel event handlers

    /// <summary>
    /// Új játék indításának eseménykezelője.
    /// </summary>
    private void ViewModel_NewGame(object? sender, EventArgs e)
    {
        _model.NewGame();
    }

    /// <summary>
    /// Játék betöltésének eseménykezelője.
    /// </summary>
    private async void ViewModel_LoadGame(object? sender, System.EventArgs e)
    {
        if (TopLevel == null)
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Sudoku játék",
                    "A fájlkezelés nem támogatott!",
                    ButtonEnum.Ok, Icon.Error)
                .ShowAsync();
            return;
        }

        Boolean restartTimer = !_model.IsGameOver;
        _model.PauseGame();

        try
        {
            var files = await TopLevel.StorageProvider.OpenFilePickerAsync(new FilePickerOpenOptions
            {
                Title = "Sudoku tábla betöltése",
                AllowMultiple = false,
                FileTypeFilter = new[]
                {
                    new FilePickerFileType("Sudoku tábla")
                    {
                        Patterns = new[] { "*.stl" }
                    }
                }
            });

            if (files.Count > 0)
            {
                // játék betöltése
                using (var stream = await files[0].OpenReadAsync())
                {
                    await _model.LoadGameAsync(stream);
                }
            }
        }
        catch (SudokuDataException)
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Sudoku játék",
                    "A fájl betöltése sikertelen!",
                    ButtonEnum.Ok, Icon.Error)
                .ShowAsync();
        }

        if (restartTimer) // ha szükséges, elindítjuk az időzítőt
            _model.ResumeGame();
    }

    /// <summary>
    /// Játék mentésének eseménykezelője.
    /// </summary>
    private async void ViewModel_SaveGame(object? sender, EventArgs e)
    {
        if (TopLevel == null)
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Sudoku játék",
                    "A fájlkezelés nem támogatott!",
                    ButtonEnum.Ok, Icon.Error)
                .ShowAsync();
            return;
        }

        Boolean restartTimer = !_model.IsGameOver;
        _model.PauseGame();

        try
        {
            var file = await TopLevel.StorageProvider.SaveFilePickerAsync(new FilePickerSaveOptions()
            {
                Title = "Sudoku tábla mentése",
                FileTypeChoices = new[]
                {
                    new FilePickerFileType("Sudoku tábla")
                    {
                        Patterns = new[] { "*.stl" }
                    }
                }
            });

            if (file != null)
            {
                // játék mentése
                using (var stream = await file.OpenWriteAsync())
                {
                    await _model.SaveGameAsync(stream);
                }
            }
        }
        catch(Exception ex)
        {
            await MessageBoxManager.GetMessageBoxStandard(
                    "Sudoku játék",
                    "A fájl mentése sikertelen!" + ex.Message,
                    ButtonEnum.Ok, Icon.Error)
                .ShowAsync();
        }

        if (restartTimer) // ha szükséges, elindítjuk az időzítőt
            _model.ResumeGame();
    }

    #endregion

    #region Model event handlers

    /// <summary>
    /// Játék végének eseménykezelője.
    /// </summary>
    private async void Model_GameOver(object? sender, SudokuEventArgs e)
    {
        await Dispatcher.UIThread.InvokeAsync(async () =>
        {
            if (e.IsWon) // győzelemtől függő üzenet megjelenítése
            {
                await MessageBoxManager.GetMessageBoxStandard(
                        "Sudoku játék",
                        "Gratulálok, győztél!" + Environment.NewLine +
                        "Összesen " + e.GameStepCount + " lépést tettél meg és " +
                        TimeSpan.FromSeconds(e.GameTime).ToString("g") + " ideig játszottál.",
                        ButtonEnum.Ok, Icon.Info)
                    .ShowAsync();
            }
            else
            {
                await MessageBoxManager.GetMessageBoxStandard(
                        "Sudoku játék",
                        "Sajnálom, vesztettél, lejárt az idő!",
                        ButtonEnum.Ok, Icon.Info)
                    .ShowAsync();
            }
        });
    }

    #endregion
}
