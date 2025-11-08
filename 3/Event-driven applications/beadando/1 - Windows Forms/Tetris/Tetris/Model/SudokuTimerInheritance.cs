using System;
using System.Collections.Generic;
using System.Timers;

namespace ELTE.Sudoku.Model
{
    /// <summary>
    /// Időzítő a <see cref="System.Timers.Timer"/> leszármaztatásával, az <see cref="ITimer"/> interfészt megvalósítva.
    /// </summary>
    public class SudokuTimerInheritance : System.Timers.Timer, ITimer
    {
        private readonly Dictionary<EventHandler, ElapsedEventHandler> _delegateMapper = new();

        // Definiálunk egy Elapsed eseményt és elfedjük vele a System.Timers.Timer-től örökölt azonos nevű eseményt
        public new event EventHandler? Elapsed
        {
            // amikor feliratkoznak az eseményre ...
            add
            {
                if (value != null)
                {
                    var handler = new ElapsedEventHandler(value.Invoke);
                    // egy ElapsedEventHandler-be csomagoljuk az EventHandler-t
                    // (típusbiztos az eseményargumentum típusának kontravarianciája miatt)
                    _delegateMapper.Add(value, handler);
                    // eltároljuk az (EventHandler, ElapsedEventHandler) párost,
                    // erre az eseményről leiratkozás támogatásához van szükség
                    base.Elapsed += handler;
                }
            }
            // amikor leiratkoznak az eseményről ...
            remove
            {
                // előkeressük az EventHandler-hez tartozó ElapsedEventHandler-t
                if (value != null && _delegateMapper.TryGetValue(value, out var handler))
                {
                    _delegateMapper.Remove(value);
                    base.Elapsed -= handler;
                    // leiratkozunk vele
                }
            }
        }

        // Implement ITimer members explicitly if needed to avoid conflicts
        bool ITimer.Enabled
        {
            get => base.Enabled;
            set => base.Enabled = value;
        }

        double ITimer.Interval
        {
            get => base.Interval;
            set => base.Interval = value;
        }

        void ITimer.Start()
        {
            base.Start();
        }

        void ITimer.Stop()
        {
            base.Stop();
        }
    }
}