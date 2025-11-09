using System;
using System.Windows;
using ELTE.ExamGenerator.Model;
using ELTE.ExamGenerator.View;
using ELTE.ExamGenerator.ViewModel;

namespace ELTE.ExamGenerator
{
    /// <summary>
    /// Alkalmazás típusa.
    /// </summary>
    public partial class App : Application
    {
        private IExamGeneratorModel _model = null!;
        private ExamGeneratorViewModel _viewModel = null!;
        private MainWindow _mainWindow = null!;
        private SettingsWindow _settingsWindow = null!;

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
            // a vezérlést az alkalmazás végzi

            _model = new ExamGeneratorModel(10, 0);
            // a modellt alapértelmezett értékekkel hozzuk létre

            _viewModel = new ExamGeneratorViewModel(_model);
            // a nézetmodell két nézetet is kiszolgál
            _viewModel.ApplicationMessaged += new EventHandler<ApplicationMessageEventArgs>(ViewModel_ApplicationMessaged);
            _viewModel.OpenSettingsExecuted += new EventHandler(ViewModel_OpenSettings);
            _viewModel.CloseSettingsExecuted += new EventHandler(ViewModel_CloseSettingsExecuted);
            // feldolgozzuk a nézetmodell eseményeit
            
            _mainWindow = new MainWindow();
            _mainWindow.DataContext = _viewModel;

            _mainWindow.Closed += new EventHandler(MainWindow_Closed);
            _mainWindow.Show();
        }

        private void ViewModel_ApplicationMessaged(object? sender, ApplicationMessageEventArgs e)
        {
            switch (e.Type) // üzenet megjelenítése a típus függvényében
            {
                case MessageType.Information:
                    MessageBox.Show(e.Message, "Tétel generátor", MessageBoxButton.OK, MessageBoxImage.Information);
                    break;
                case MessageType.Error:
                    MessageBox.Show(e.Message, "Tétel generátor", MessageBoxButton.OK, MessageBoxImage.Error);
                    break;
            }
        }

        private void ViewModel_OpenSettings(object? sender, EventArgs e)
        {
            if (_settingsWindow == null) // ha már egyszer létrehoztuk az ablakot, nem kell újra
            {
                _settingsWindow = new SettingsWindow();
                _settingsWindow.DataContext = _viewModel; // a beállításoknak is átadjuk a nézetmodellt
            }
            _settingsWindow.ShowDialog(); // megjelenítjük dialógusként
        }

        private void ViewModel_CloseSettingsExecuted(object? sender, EventArgs e)
        {
            _settingsWindow.Hide(); // beállítások ablak elrejtése (így később újra megnyitható lesz)
        }

        private void MainWindow_Closed(object? sender, EventArgs e)
        {
            
            Shutdown(); // ha a főablakot bezárják, akkor leállítjuk az alkalmazást
        }

    }
}
