using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace ELTE.DigiClock
{
    public partial class Clock : UserControl
    {
        private Timer timer;
        private int timeZone;

        [Category("Appearance")]
        [Description("The name of the city.")]
        public string City
        {
            get => cityLabel.Text;
            set => cityLabel.Text = value;
        }

        [Category("Appearance")]
        [Description("The hour offset of the timezone.")]
        public int TimeZone
        {
            get { return timeZone; }
            set
            {
                timeZone = value;
                RefreshTime(this, EventArgs.Empty);
            }
        }

        public Clock()
        {
            InitializeComponent();

            timer = new Timer();
            timer.Interval = 1000;
            timer.Tick += RefreshTime;
            timer.Start();
        }

        private void RefreshTime(object? sender, EventArgs e)
        {
            DateTime time = DateTime.Now;
            timeLabel.Text = time
                .AddHours(TimeZone)
                .ToString(time.Second % 2 == 0 ? "HH:mm" : "HH mm");
        }
    }
}
