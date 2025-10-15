using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using ELTE.Calculator.Model;

namespace ELTE.Calculator.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class CalculatorWindow : Window
    {
        private CalculatorModel _model; // számológép modell

        public CalculatorWindow()
        {
            InitializeComponent();

            _model = new CalculatorModel();
            _model.CalculationPerformed += new EventHandler<CalculatorEventArgs>(Model_CalculationPerformed); // modell eseményének társítása
            _textNumber.Text = _model.Result.ToString();

        }

        /// <summary>
        /// Számítás végrehajtásának eseménykezelője.
        /// </summary>
        private void Model_CalculationPerformed(object? sender, CalculatorEventArgs e)
        {
            // az eseményargumentokat használjuk fel
            _textNumber.Text = e.Result.ToString();

            if (e.CalculationString != String.Empty)
                _listHistory.Items.Add(e.CalculationString);
        }

        /// <summary>
        /// Ablak betöltésének eseménykezelője.
        /// </summary>
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            _textNumber.Focus();
            _textNumber.SelectAll();
        }
        /// <summary>
        /// Gomb kattintásának eseménykezelője.
        /// </summary>
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button)
            {
                switch (button.Content as String)
                // megvizsgáljuk, milyen az eseményt kiváltó gomb felirata, így eldönthetjük, melyik gombot nyomták le
                {
                    case "+":
                        PerformCalculation(Operation.Add);
                        break;
                    case "-":
                        PerformCalculation(Operation.Subtract);
                        break;
                    case "*":
                        PerformCalculation(Operation.Multiply);
                        break;
                    case "/":
                        PerformCalculation(Operation.Divide);
                        break;
                    default:
                        PerformCalculation(Operation.None);
                        break;
                }
            }
        }
        /// <summary>
        /// Billentyű lenyomásának eseménykezelője.
        /// </summary>
        private void Window_KeyDown(object sender, KeyEventArgs e)
        {
            switch (e.Key) // megkapjuk a billentyűt
            {
                case Key.Add:
                    PerformCalculation(Operation.Add);
                    e.Handled = true; // az eseményt nem adjuk tovább a vezérlőnek
                    break;
                case Key.Subtract:
                    PerformCalculation(Operation.Subtract);
                    e.Handled = true;
                    break;
                case Key.Multiply:
                    PerformCalculation(Operation.Multiply);
                    e.Handled = true;
                    break;
                case Key.Divide:
                    PerformCalculation(Operation.Divide);
                    e.Handled = true;
                    break;
                case Key.Enter:
                    PerformCalculation(Operation.None);
                    e.Handled = true;
                    break;
            }
        }

        /// <summary>
        /// Számítás végrehajtása
        /// </summary>
        /// <param name="operation"></param>
        private void PerformCalculation(Operation operation)
        {
            try
            {
                _model.Calculate(Double.Parse(_textNumber.Text), operation); // művelet végrehajtása
            }
            catch (OverflowException)
            {
                MessageBox.Show("Your input has to many digits!", "Calculation Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            catch (FormatException)
            {
                MessageBox.Show("Your input is not a real number!\nPlease correct!", "Calculation Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            catch (NullReferenceException)
            {
                MessageBox.Show("No number in input!\nPlease correct!", "Calculation Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                _textNumber.Focus(); // visszaadjuk a vezérlést a szövegdoboznak
                _textNumber.SelectAll(); // összes szöveg kijelölése
            }
        }
    }
}
