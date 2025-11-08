using System;
using System.Collections.Generic;
using System.Timers;

namespace ELTE.Sudoku.Model
{
    /// <summary>
    /// Időzítő a <see cref="System.Timers.Timer"/> aggregálásával, az <see cref="ITimer"/> interfészt megvalósítva.
    /// </summary>
    public class SudokuTimerAggregation : ITimer, IDisposable
    {
        // Aggregálunk egy System.Timers.Timer példányt.
        private readonly System.Timers.Timer _timer;

        public bool Enabled
        {
            get => _timer.Enabled;
            set => _timer.Enabled = value;
        }

        public double Interval
        {
            get => _timer.Interval;
            set => _timer.Interval = value;
        }

        public event EventHandler? Elapsed;

        public SudokuTimerAggregation()
        {
            _timer = new System.Timers.Timer();
            _timer.Elapsed += (sender, e) =>
            {
                Elapsed?.Invoke(sender, e);
            };
        }

        public void Start()
        {
            _timer.Start();
        }

        public void Stop()
        {
            _timer.Stop();
        }

        public void Dispose()
        {
            // Mivel IDisposable adattagot aggregáltunk, a <see cref="SudokuTimerAggregation"/> típusnak is disposable-nek kell lennie.
            _timer.Dispose();
        }
    }
}