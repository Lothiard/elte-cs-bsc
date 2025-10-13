using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tetris.Model
{
    public class TetrisTimer : IDisposable
    {
        #region Fields

        private DateTime _startTime;
        private TimeSpan _pausedTime;
        private bool _isRunning;
        private bool _isPaused;
        private readonly double _interval;
        private System.Timers.Timer? _timer;
        private bool _disposed = false;
        private readonly object _lockObject = new object();

        #endregion

        #region Properties

        public TimeSpan ElapsedTime
        {
            get
            {
                lock (_lockObject)
                {
                    if (!_isRunning)
                        return TimeSpan.Zero;

                    if (_isPaused)
                        return _pausedTime;

                    return _pausedTime + (DateTime.Now - _startTime);
                }
            }
        }

        public bool IsRunning 
        { 
            get
            {
                lock (_lockObject)
                {
                    return _isRunning;
                }
            }
        }
        
        public bool IsPaused 
        { 
            get
            {
                lock (_lockObject)
                {
                    return _isPaused;
                }
            }
        }

        #endregion

        #region Events

        public event EventHandler? Elapsed;

        #endregion

        #region Constructor

        public TetrisTimer()
        {
            _isRunning = false;
            _isPaused = false;
            _pausedTime = TimeSpan.Zero;
            _interval = 1000;
        }

        #endregion

        #region Public Methods

        public void Start()
        {
            lock (_lockObject)
            {
                if (_isRunning) return;
                
                _isRunning = true;
                _isPaused = false;
                _startTime = DateTime.Now;
                _pausedTime = TimeSpan.Zero;
                
                CreateTimer();
            }
        }

        public void Stop()
        {
            lock (_lockObject)
            {
                if (!_isRunning) return;
                
                _isRunning = false;
                _isPaused = false;
                _pausedTime = TimeSpan.Zero;
                
                DisposeTimer();
            }
        }

        public void Pause()
        {
            lock (_lockObject)
            {
                if (!_isRunning || _isPaused) return;
                
                _isPaused = true;
                _pausedTime += DateTime.Now - _startTime;
                
                if (_timer != null)
                {
                    _timer.Stop();
                }
            }
        }

        public void Resume()
        {
            lock (_lockObject)
            {
                if (!_isRunning || !_isPaused) return;
                
                _isPaused = false;
                _startTime = DateTime.Now;
                
                if (_timer != null)
                {
                    _timer.Start();
                }
                else
                {
                    CreateTimer();
                }
            }
        }

        public void SetPausedTime(TimeSpan time)
        {
            lock (_lockObject)
            {
                _pausedTime = time;
            }
        }

        #endregion

        #region Private Methods

        private void CreateTimer()
        {
            DisposeTimer();
            
            _timer = new System.Timers.Timer(_interval);
            _timer.Elapsed += TimerElapsed;
            _timer.AutoReset = true;
            _timer.Start();
        }

        private void DisposeTimer()
        {
            if (_timer != null)
            {
                _timer.Stop();
                _timer.Elapsed -= TimerElapsed;
                _timer.Dispose();
                _timer = null;
            }
        }

        private void TimerElapsed(object? sender, System.Timers.ElapsedEventArgs e)
        {
            bool shouldRaiseEvent = false;
            
            lock (_lockObject)
            {
                shouldRaiseEvent = _isRunning && !_isPaused;
            }
            
            if (shouldRaiseEvent)
            {
                // Raise the event in a thread-safe way
                EventHandler? handler = Elapsed;
                handler?.Invoke(this, EventArgs.Empty);
            }
        }

        #endregion

        #region IDisposable Implementation

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    lock (_lockObject)
                    {
                        DisposeTimer();
                    }
                }

                _disposed = true;
            }
        }

        #endregion
    }
}
