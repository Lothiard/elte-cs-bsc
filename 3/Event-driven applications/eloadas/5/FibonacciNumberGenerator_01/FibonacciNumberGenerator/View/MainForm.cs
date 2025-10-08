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

        private void ButtonGenerate_Click(object sender, EventArgs e)
        {
            _listBox.Items.Insert(0, _generator.Generate(Convert.ToInt32(_numericNumber.Value)));
            _numericNumber.Value++; // mindig növeljük a generált számot
        }
    }
}
