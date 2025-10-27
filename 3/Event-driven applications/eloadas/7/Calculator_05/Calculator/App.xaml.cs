using System.Windows;
using ELTE.Calculator.View;
using ELTE.Calculator.ViewModel;
using System.Windows.Controls;

namespace ELTE.Calculator
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            CalculatorWindow window = new CalculatorWindow(); // nézet létrehozása

            CalculatorViewModel viewModel = new CalculatorViewModel(); // nézetmodell létrehozása

            window.DataContext = viewModel; // nézetmodell és modell társítása

            window.Show();
        }
    }
}
