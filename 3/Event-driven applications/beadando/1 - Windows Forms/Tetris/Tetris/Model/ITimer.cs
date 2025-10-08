using System;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tetris.Model
{
    public interface ITimer
    {
        bool Enabled { get; set; }
        double Interval { get; set; }

        event EventHandler? Elapsed;

        void Start();
        void Stop();
    }
}
