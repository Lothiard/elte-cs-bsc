using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace ELTE.StudentsList.ViewModel
{
    /// <summary>
    /// Hallgató típusa.
    /// </summary>
    public class Student : INotifyPropertyChanged
    {
        /// <summary>
        /// Azonosító lekérdezése vagy beállítása.
        /// </summary>
        public Int32 Id { get; set; }

        private String _firstName = String.Empty;
        private String _lastName = String.Empty;
        private String _studentCode = String.Empty;

        /// <summary>
        /// Keresztnév lekérdezése, vagy beállítása.
        /// </summary>
        public String FirstName
        {
            get { return _firstName; }
            set
            {
                if (_firstName != value)
                {
                    _firstName = value;
                    OnPropertyChanged(); // váltáskor kiváltjuk az eseményt
                    OnPropertyChanged(nameof(FullName));
                }
            }
        }

        /// <summary>
        /// Vezetéknév lekérdezése, vagy beállítása.
        /// </summary>
        public String LastName
        {
            get { return _lastName; }
            set
            {
                if (_lastName != value)
                {
                    _lastName = value;
                    OnPropertyChanged();
                    OnPropertyChanged(nameof(FullName));
                }
            }
        }

        /// <summary>
        /// Hallgatói kód lekérdezése, vagy beállítása.
        /// </summary>
        public String StudentCode
        {
            get { return _studentCode; }
            set
            {
                if (_studentCode != value)
                {
                    _studentCode = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Teljes név lekérdezése.
        /// </summary>
        public String FullName
        {
            get { return _firstName + " " + _lastName; }
        }

        /// <summary>
        /// Tulajdonságváltozás eseménye.
        /// </summary>
        public event PropertyChangedEventHandler? PropertyChanged;

        /// <summary>
        /// Tulajdonságváltozás eseménykliváltása.
        /// </summary>
        /// <param name="property">A tulajdonság neve.</param>
        private void OnPropertyChanged([CallerMemberName] String? property = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(property));
        }
    }
}
