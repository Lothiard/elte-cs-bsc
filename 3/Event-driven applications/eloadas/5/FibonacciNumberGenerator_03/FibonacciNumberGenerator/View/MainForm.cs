using System;
using System.Numerics;
using System.Windows.Forms;
using ELTE.FibonacciNumberGenerator.Model;

namespace ELTE.FibonacciNumberGenerator.View
{
    public partial class MainForm : Form
    {
        private FibonacciGenerator _generator;
        private Boolean isRunning = false;

        public MainForm()
        {
            InitializeComponent();

            _generator = new FibonacciGenerator();
            _generator.NewResult += GotNewResult;
            _generator.Ready += Ready;
        }

        private void StartStop(object? sender, EventArgs e)
        {
            if (!isRunning)
            {
                _lbxResults.Items.Clear();
                _btnCalculate.Text = "Leállít";
                isRunning = true;

                _generator.Run(Convert.ToInt32(_nupN.Value));
            }
            else
                _generator.Cancel();
        }

        private void GotNewResult(object? sender, ResultEventArgs e)
        {
            if (_lbxResults.InvokeRequired)
            {
                BeginInvoke(new EventHandler<ResultEventArgs>(GotNewResult), sender, e);
                return;
            }
            _lbxResults.Items.Insert(0, e.N + ": " + e.Result);
        }

        private void Ready(object? sender, EventArgs e)
        {
            if (_btnCalculate.InvokeRequired)
            {
                BeginInvoke(new EventHandler(Ready), sender, e);
                return;
            }
            _btnCalculate.Text = "Számol";
            isRunning = false;
        }
    }
}
