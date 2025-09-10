using System;
using System.Windows.Forms;

namespace ELTE.Calculator
{
    /// <summary>
    /// Műveletek felsorolási típusa. 
    /// </summary>
    public enum Operation { None, Add, Substract, Multiply, Divide }

    /// <summary>
    /// Számológép ablak típusa.
    /// </summary>
    public partial class CalculatorForm : Form
    {
        private Double _result; // eltároljuk az eredményt
        private Operation _operation; // eltároljuk a legutoljára használt műveletet

        /// <summary>
        /// Számológép ablak példányosítása.
        /// </summary>
        public CalculatorForm()
        {
            InitializeComponent();
            _operation = Operation.None; // kezdetben nincs művelet
            _result = 0;
            _textNumber.Text = "0";
        }

        /// <summary>
        /// Gomb eseménykezelője.
        /// </summary>
        private void Button_Click(object sender, EventArgs e) // egy közös eseménykezelő minden gombra
        {
            try
            {
                if (_operation != Operation.None) // ha már volt művelet
                {
                    Double value = Double.Parse(_textNumber.Text); // beolvassuk a második operandust
                    switch (_operation) // végrehajtjuk a korábbi műveletet a két operandussal
                    {
                        case Operation.Add:
                            _listHistory.Items.Add(_result + "+" + value + "=" + (_result + value)); // művelet kiírása a listába
                            _result = _result + value; // művelet végrehajtása
                            break;
                        case Operation.Substract:
                            _listHistory.Items.Add(_result + "-" + value + "=" + (_result - value));
                            _result = _result - value;
                            break;
                        case Operation.Multiply:
                            _listHistory.Items.Add(_result + "*" + value + "=" + (_result * value));
                            _result = _result * value;
                            break;
                        case Operation.Divide:
                            _listHistory.Items.Add(_result + "/" + value + "=" + (_result / value));
                            _result = _result / value;
                            break;
                    }
                    _textNumber.Text = _result.ToString(); // eredmény kiírása a felső sávba
                }
                else
                { 
                    // különben csak el kell tárolnunk a számot
                    _result = Double.Parse(_textNumber.Text);
                }

                if (sender is Button button) // típusellenőrzés és új lokális változó definiálása, ha igaz
                {
                    switch (button.Text)
                    // megvizsgáljuk, milyen az eseményt kiváltó gomb felirata, így eldönthetjük, melyik gombot nyomták le
                    {
                        case "+": _operation = Operation.Add; break;
                        case "-": _operation = Operation.Substract; break;
                        case "*": _operation = Operation.Multiply; break;
                        case "/": _operation = Operation.Divide; break;
                        case "=": _operation = Operation.None; break; // beállítjuk a megfelelő műveletet
                    }
                }
            }
            catch (OverflowException)
            {
                // üzenet megjelenítése előugró ablakban
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
