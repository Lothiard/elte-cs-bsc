using System.Windows;
using ELTE.ColorGrid.View;
using ELTE.ColorGrid.ViewModel;

namespace ELTE.ColorGrid
{
    public partial class App : Application
    {
        public App()
        {
            Startup += new StartupEventHandler(App_Startup);
        }

        private void App_Startup(object sender, StartupEventArgs e)
        {
            MainWindow window = new MainWindow();

            ColorGridViewModel viewModel = new ColorGridViewModel();
            window.DataContext = viewModel;

            window.Show();
        }
    }
}
