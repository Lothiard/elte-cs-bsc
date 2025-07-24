using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace StopwatchWindowsForms
{
    public partial class Stopwatch : Form
    {
        enum State { stopped, operate };

        State currentState;
        DateTime seconds = new DateTime(0);

        public Stopwatch()
        {
            InitializeComponent();

            currentState = State.stopped;
            display();
            timer.Start();
        }
        private void display()
        {
            lcd.Text = string.Format("{0}:{1}",
                seconds.Minute.ToString().PadLeft(2, '0'),
            seconds.Second.ToString().PadLeft(2, '0'));
        }

        private void MainForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            timer.Stop();
        }
        private void clickButton_Click(object sender, EventArgs e)
        {
            switch (currentState)
            {
                case State.operate:
                    currentState = State.stopped;
                    break;
                case State.stopped:
                    currentState = State.operate;
                    break;
            }
        }
        private void zeroButton_Click(object sender, EventArgs e)
        {
            switch (currentState)
            {
                case State.operate:
                    currentState = State.stopped;
                    break;
                case State.stopped:
                    break;
            }
            seconds = new DateTime(0);
            display();
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            switch (currentState)
            {
                case State.operate:
                    seconds = seconds.AddSeconds(1);
                    display();
                    break;
                case State.stopped: break;
            }
        }


    }
}
