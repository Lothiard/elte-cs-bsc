using System.Windows;
using System.Windows.Controls;

namespace ELTE.SimpleWindowByCode
{
    class MainWindow : Window // a Window osztály leszármazottja
    {
        private Button _ExitButton;

        public MainWindow()
        {
            this.Width = 300; // ablak tulajdonságainak beállítása
            this.Height = 200;
            this.Title = "Egyszerű ablak";
            this.WindowStartupLocation = System.Windows.WindowStartupLocation.CenterScreen;

            _ExitButton = new Button(); // gomb létrehozása és konfigurálása
            _ExitButton.Content = "Kilépés";
            _ExitButton.Width = 100;
            _ExitButton.Height = 25;
            _ExitButton.HorizontalAlignment = System.Windows.HorizontalAlignment.Center;
            _ExitButton.VerticalAlignment = System.Windows.VerticalAlignment.Center;
            _ExitButton.Click += new RoutedEventHandler(ExitButton_Click); // eseménykezelő társítás

            this.AddChild(_ExitButton); // gomb felvétele az ablakra
        }

        private void ExitButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
