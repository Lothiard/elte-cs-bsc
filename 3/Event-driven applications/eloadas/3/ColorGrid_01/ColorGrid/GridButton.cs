using System;
using System.Windows.Forms;

namespace ELTE.ColorGrid
{
    /// <summary>
    /// Rácsgomb típusa.
    /// </summary>
    class GridButton : Button
    {
        private Int32 _x;
        private Int32 _y;

        /// <summary>
        /// Vízszintes rácskoordináta.
        /// </summary>
        public Int32 GridX { get { return _x; } }
        /// <summary>
        /// Függőleges rácskoordináta.
        /// </summary>
        public Int32 GridY { get { return _y; } }

        /// <summary>
        /// Rácsgomb példányosítása.
        /// </summary>
        /// <param name="x">Vízszintes rácskoordináta.</param>
        /// <param name="y">Függőleges rácskoordináta.</param>
        public GridButton(Int32 x, Int32 y) { _x = x; _y = y; }
    }
}
