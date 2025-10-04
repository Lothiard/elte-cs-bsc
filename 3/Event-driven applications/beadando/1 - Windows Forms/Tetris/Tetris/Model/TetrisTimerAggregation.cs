using System;

namespace Tetris.Model
{
    public class TetrisTimerAggregation
    {
        #region Fields

        private DateTime _startTime;
        private TimeSpan _pausedTime;
        private bool _isRunning;
        private bool _isPaused;

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

        #endregion

        #region Constructor

        public TetrisTimerAggregation()
        {
            _isRunning = false;
            _isPaused = false;
            _pausedTime = TimeSpan.Zero;
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
            }
        }
        public void Stop()
        {
            _isRunning = false;
            _isPaused = false;
            _pausedTime = TimeSpan.Zero;
        }
        public void Pause()
        {
            if (_isRunning && !_isPaused)
            {
                _isPaused = true;
                _pausedTime += DateTime.Now - _startTime;
            }
        }

        public void Resume()
        {
            if (_isRunning && _isPaused)
            {
                _isPaused = false;
                _startTime = DateTime.Now;
            }
        }
        public void SetPausedTime(TimeSpan time)
        {
            _pausedTime = time;
        }

        #endregion
    }
}