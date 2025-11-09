using System;

namespace ELTE.TicTacToeGame.ViewModel
{
    /// <summary>
    /// Mező típusa.
    /// </summary>
    public class TicTacToeField : ViewModelBase
    {
        private String _player = String.Empty;

        /// <summary>
        /// Játékos lekérdezése, vagy beállítása.
        /// </summary>
        public String Player 
        { 
            get { return _player; }
            set
            {
                if (_player != value)
                {
                    _player = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Oszlop lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 X { get; set; }

        /// <summary>
        /// Sor lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 Y { get; set; }

        /// <summary>
        /// Mezőváltoztató parancs lekérdezése, vagy beállítása.
        /// </summary>
        public DelegateCommand? FieldChangeCommand { get; set; }
    }
}
