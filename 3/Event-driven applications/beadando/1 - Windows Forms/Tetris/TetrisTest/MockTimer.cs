using System;

namespace Tetris.Test
{
    public class MockTimer : ELTE.Sudoku.Model.ITimer
    {
        #region ITimer Properties

        public bool Enabled { get; set; }

        public double Interval { get; set; }

        #endregion

        #region Events

        public event EventHandler? Elapsed;

        #endregion

        #region Additional Test Properties

        public bool IsRunning { get; private set; }

        public bool IsPaused { get; private set; }

        public TimeSpan ElapsedTime { get; private set; }

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

        #region Test Helper Methods

        /// <summary>
        /// Manually trigger the Elapsed event for testing purposes.
        /// </summary>
        public void Tick()
        {
            Elapsed?.Invoke(this, EventArgs.Empty);
        }

        #endregion
    }
}
