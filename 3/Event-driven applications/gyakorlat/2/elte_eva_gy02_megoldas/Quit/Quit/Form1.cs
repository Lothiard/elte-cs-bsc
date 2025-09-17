using System;
using System.Windows.Forms;

namespace ELTE.Quit
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void ButtonClicked(object? sender, EventArgs e)
        {
            this.Close();
        }
    }
}
