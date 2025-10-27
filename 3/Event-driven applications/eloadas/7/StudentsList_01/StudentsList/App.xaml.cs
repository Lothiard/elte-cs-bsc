using System.Windows;
using ELTE.StudentsList.ViewModel;
using ELTE.StudentsList.View;

namespace ELTE.StudentsList
{
    public partial class App : Application
    {
        public App()
        {
            Startup += new StartupEventHandler(App_Startup);
        }

        private void App_Startup(object sender, StartupEventArgs e)
        {
            MainWindow window = new MainWindow(); // nézet létrehozása

            StudentsViewModel viewModel = new StudentsViewModel(); // nézetmodell létrehozása

            window.DataContext = viewModel; // nézetmodell és modell társítása

            window.Show();
        }
    }
}
