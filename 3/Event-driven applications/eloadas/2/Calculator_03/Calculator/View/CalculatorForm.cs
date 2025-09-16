using System;
using System.Windows.Forms;
using ELTE.Calculator.Model;

namespace ELTE.Calculator.View
{
    /// <summary>
    /// Számológép ablak típusa.
    /// </summary>
    public partial class CalculatorForm : Form
    {
        private CalculatorModel _model; // számológép modell

        /// <summary>
        /// Számológép ablak példányosítása.
        /// </summary>
        public CalculatorForm()
        {
            InitializeComponent();

            _model = new CalculatorModel();
            _model.CalculationPerformed += new EventHandler<CalculatorEventArgs>(Model_CalculationPerformed); // modell eseményének társítása
            _textNumber.Text = _model.Result.ToString();

            KeyPreview = true; // billentyűesemények kelezése
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
        /// Gomb eseménykezelője.
        /// </summary>
        private void Button_Click(object? sender, EventArgs e) // egy közös eseménykezelő minden gombra
        {
            if (sender is Button button)
            {
                switch (button.Text)
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
        /// Billentyű eseménykezelője.
        /// </summary>
        private void CalculatorForm_KeyDown(object? sender, KeyEventArgs e)
        {
            switch (e.KeyCode) // megkapjuk a billentyűt
            {
                case Keys.Add:
                    PerformCalculation(Operation.Add);
                    e.SuppressKeyPress = true; // az eseményt nem adjuk tovább a vezérlőnek
                    break;
                case Keys.Subtract:
                    PerformCalculation(Operation.Subtract);
                    e.SuppressKeyPress = true;
                    break;
                case Keys.Multiply:
                    PerformCalculation(Operation.Multiply);
                    e.SuppressKeyPress = true;
                    break;
                case Keys.Divide:
                    PerformCalculation(Operation.Divide);
                    e.SuppressKeyPress = true;
                    break;
                case Keys.Enter:
                    PerformCalculation(Operation.None);
                    e.SuppressKeyPress = true;
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
                MessageBox.Show("Your input has to many digits!", "Calculation Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (FormatException)
            {
                MessageBox.Show("Your input is not a real number!\nPlease correct!", "Calculation Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            catch (NullReferenceException)
            {
                MessageBox.Show("No number in input!\nPlease correct!", "Calculation Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                _textNumber.Focus(); // visszaadjuk a vezérlést a szövegdoboznak
                _textNumber.SelectAll(); // összes szöveg kijelölése
            }
        }
    }
}
