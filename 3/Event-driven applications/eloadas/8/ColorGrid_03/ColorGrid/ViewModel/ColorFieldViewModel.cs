using System;
using System.Windows.Media;

namespace ELTE.ColorGrid.ViewModel
{
    /// <summary>
    /// Színmező típusa.
    /// </summary>
    public class ColorFieldViewModel : ViewModelBase
    {
        private Color _color;

        /// <summary>
        /// Sor lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 Row { get; set; }

        /// <summary>
        /// Oszlop lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 Column { get; set; }

        /// <summary>
        /// Szín lekérdezése, vagy beállítása.
        /// </summary>
        public Color Color 
        { 
            get { return _color; }
            set
            {
                if (_color != value)
                {
                    _color = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Mezőváltoztató parancs lekérdezése, vagy beállítása.
        /// </summary>
        public DelegateCommand? FieldChangeCommand { get; set; }
    }
}
