using System;

namespace ELTE.ColorGrid.ViewModel
{
    /// <summary>
    /// Színmező típusa.
    /// </summary>
    public class ColorFieldViewModel : ViewModelBase
    {
        private Int32 _colorNumber; // most már nem a konkrét színt tároljuk

        /// <summary>
        /// Sor lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 Row { get; set; }

        /// <summary>
        /// Oszlop lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 Column { get; set; }

        /// <summary>
        /// Színérték lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 ColorNumber
        {
            get { return _colorNumber; }
            set 
            {
                if (_colorNumber != value)
                {
                    _colorNumber = value; 
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
