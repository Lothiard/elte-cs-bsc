using System;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ELTE.Sudoku.Model
{
    /// <summary>
    /// Absztrakt (mockolható) időzítő.
    /// </summary>
    public interface ITimer
    {
        /// <summary>
        /// Aktív-e (fut-e) az időzítő.
        /// </summary>
        /// 
        bool Enabled { get; set; }
        /// <summary>
        /// Időzítő intervalluma.
        /// </summary>
        double Interval { get; set; }

        /// <summary>
        /// Időzítő eseménye.
        /// </summary>
        event EventHandler? Elapsed;

        /// <summary>
        /// Időzítő elindítása.
        /// </summary>
        /// 
        void Start();
        /// <summary>
        /// Időzítő leállítása.
        /// </summary>
        void Stop();
    }
}
