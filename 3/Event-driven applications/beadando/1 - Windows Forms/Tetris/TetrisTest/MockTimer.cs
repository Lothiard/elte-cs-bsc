using System;
using Tetris.Model;

namespace Tetris.Test
{
    public class MockTimer : Tetris.Model.ITimer
    {
        private bool _disposed = false;

        #region ITimer Properties

        public bool Enabled { get; set; }

        public double Interval { get; set; }

        public bool IsRunning { get; private set; }

        public bool IsPaused { get; private set; }

        public TimeSpan ElapsedTime { get; private set; }

        #endregion

        #region Events

        public event EventHandler? Elapsed;

        #endregion

        #region Constructors

        public MockTimer()
        {
            Interval = 1000;
            ElapsedTime = TimeSpan.Zero;
        }

        #endregion

        #region ITimer Methods

        public void Start()
        {
            IsRunning = true;
            IsPaused = false;
            Enabled = true;
            ElapsedTime = TimeSpan.Zero;
        }

        public void Stop()
        {
            IsRunning = false;
            IsPaused = false;
            Enabled = false;
            ElapsedTime = TimeSpan.Zero;
        }

        #endregion
    }
}