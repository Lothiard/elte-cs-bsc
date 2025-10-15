using System;
using System.Windows;

namespace ELTE.SimpleWindowByCode
{
    class SimpleApplication : Application
    {
        [STAThread]
        public static void Main() 
        {
            SimpleApplication application = new SimpleApplication(); // alkalmazás létrehozása
            application.Startup += new StartupEventHandler(Application_Startup); // indítási esemény
            application.Exit += new ExitEventHandler(Application_Exit); // kilépési esemény
            application.Run(); // futtatás
        }

        static void Application_Exit(object sender, ExitEventArgs e)
        {
            
        }

        static void Application_Startup(object sender, StartupEventArgs e)
        {
            MainWindow window = new MainWindow(); // megjelenítjük az ablakot
            window.Show();
        }
    }
}
