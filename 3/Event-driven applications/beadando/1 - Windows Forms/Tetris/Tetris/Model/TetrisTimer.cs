using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Tetris.Model
{
    public class TetrisTimer : ITimer, IDisposable
    {
        #region Fields

        private DateTime _startTime;
        private TimeSpan _pausedTime;
        private bool _isRunning;
        private bool _isPaused;
        private double _interval;
        private System.Windows.Forms.Timer? _timer;
        private bool _disposed = false;

        #endregion

        #region Properties

        public TimeSpan ElapsedTime
        {
            get
            {
                if (!_isRunning)
                    return TimeSpan.Zero;

                if (_isPaused)
                    return _pausedTime;

                return _pausedTime + (DateTime.Now - _startTime);
            }
        }

        public bool IsRunning => _isRunning;
        public bool IsPaused => _isPaused;

        public bool Enabled
        {
            get => _isRunning && !_isPaused;
            set
            {
                if (value)
                {
                    if (!_isRunning)
                        Start();
                    else if (_isPaused)
                        Resume();
                }
                else
                {
                    if (_isRunning && !_isPaused)
                        Pause();
                }
            }
        }

        public double Interval
        {
            get => _interval;
            set
            {
                _interval = value;
                if (_timer != null)
                {
                    _timer.Interval = (int)_interval;
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

        public TetrisTimer(double interval) : this()
        {
            _interval = interval;
        }

        #endregion

        #region Public Methods

        public void Start()
        {
            if (!_isRunning)
            {
                _isRunning = true;
                _isPaused = false;
                _startTime = DateTime.Now;
                _pausedTime = TimeSpan.Zero;
                
                CreateTimer();
            }
        }

        public void Stop()
        {
            if (_isRunning)
            {
                _isRunning = false;
                _isPaused = false;
                _pausedTime = TimeSpan.Zero;
                
                if (_timer != null)
                {
                    _timer.Stop();
                    _timer.Dispose();
                    _timer = null;
                }
            }
        }

        public void Pause()
        {
            if (_isRunning && !_isPaused)
            {
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
            if (_isRunning && _isPaused)
            {
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
            _pausedTime = time;
        }

        #endregion

        #region Private Methods

        private void CreateTimer()
        {
            if (_timer != null)
            {
                _timer.Stop();
                _timer.Dispose();
                _timer = null;
            }
            
            _timer = new System.Windows.Forms.Timer();
            _timer.Interval = (int)_interval;
            _timer.Tick += TimerTick;
            _timer.Start();
        }

        private void TimerTick(object? sender, EventArgs e)
        {
            Elapsed?.Invoke(this, EventArgs.Empty);
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
                    if (_timer != null)
                    {
                        _timer.Stop();
                        _timer.Tick -= TimerTick;
                        _timer.Dispose();
                        _timer = null;
                    }
                }

                _disposed = true;
            }
        }

        #endregion
    }
}
