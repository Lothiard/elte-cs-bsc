using System;
using System.Windows.Forms;
using ELTE.FibonacciNumberGenerator.Model;

namespace ELTE.FibonacciNumberGenerator.View
{
    public partial class MainForm : Form
    {
        private FibonacciGenerator _generator; // Fibonacci generátor

        public MainForm()
        {
            InitializeComponent();

            _generator = new FibonacciGenerator();
        }

        private async void ButtonGenerate_Click(object sender, EventArgs e)
        {
            // aszinkron lesz az eseménykezelő

            _button.Text = "Generating... Please wait."; // feltűntetjük a tevékenység kezdetét
            _button.Enabled = false;
            _numericNumber.Enabled = false;

            _listBox.Items.Insert(0, await _generator.GenerateAsync(Convert.ToInt32(_numericNumber.Value)));
            // mnegvárjuk a generálás eredményét

            _numericNumber.Value++; // mindig növeljük a generált számot

            _button.Text = "Generate"; // feltűntetjük a tevékenység végét
            _button.Enabled = true;
            _numericNumber.Enabled = true;
        }
    }
}
