using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace ELTE.Calculator.View
{
    /// <summary>
    /// Állandóan kijelölt szövegdoboz típusa.
    /// </summary>
    public class SelectedTextBox : TextBox
    {
        /// <summary>
        /// Állandóan kijelölt szövegdoboz példányosítása.
        /// </summary>
        public SelectedTextBox() 
        {
            KeyUp += new KeyEventHandler(SelectedTextBox_KeyUp);
        }

        /// <summary>
        /// Billentyű felengedésének eseménykezelője.
        /// </summary>
        private void SelectedTextBox_KeyUp(object sender, KeyEventArgs e)
        {
            switch (e.Key)
            { 
                case Key.Add: // az aktióbillentyűkre
                case Key.Subtract:
                case Key.Enter:
                case Key.Multiply:
                case Key.Divide:
                    SelectAll(); // minden szöveget kijelölünk
                    break;
            }
        }
    }
}
