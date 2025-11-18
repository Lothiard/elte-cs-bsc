using System;
using System.Windows.Media;

namespace Tetris.ViewModel
{
    /// <summary>
    /// Tetris játékmező típusa.
    /// </summary>
    public class TetrisField : ViewModelBase
    {
        private Boolean _isLocked;
        private String _text = String.Empty;
        private Brush _background = Brushes.White;

        /// <summary>
        /// Zároltság lekérdezése, vagy beállítása.
        /// </summary>
        public Boolean IsLocked 
        {
            get { return _isLocked; }
            set 
            {
                if (_isLocked != value)
                {
                    _isLocked = value;
                    OnPropertyChanged();
                }
            } 
        }

        /// <summary>
        /// Felirat lekérdezése, vagy beállítása.
        /// </summary>
        public String Text 
        {
            get { return _text; }
            set
            {
                if (_text != value)
                {
                    _text = value; 
                    OnPropertyChanged();
                }
            } 
        }

        /// <summary>
        /// Háttérszín lekérdezése, vagy beállítása.
        /// </summary>
        public Brush Background
        {
            get { return _background; }
            set
            {
                if (_background != value)
                {
                    _background = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Vízszintes koordináta lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 X { get; set; }

        /// <summary>
        /// Függőleges koordináta lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 Y { get; set; }
    }
}
