using System;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace ELTE.StudentsList.ViewModel
{
    /// <summary>
    /// Hallgatók megjelenítő típusa.
    /// </summary>
    public class StudentsViewModel : INotifyPropertyChanged
    {
        /// <summary>
        /// Hallgatók gyűjteményének lekérdezése.
        /// </summary>
        public ObservableCollection<Student> Students { get; private set; }

        /// <summary>
        /// Új hallgató lekérdezése.
        /// </summary>
        public Student NewStudent { get; private set; }

        /// <summary>
        /// Új hallgató felvétel parancsának lekérdezése.
        /// </summary>
        public StudentAddCommand AddCommand { get; private set; }

        /// <summary>
        /// Tulajdonságváltozás eseménye.
        /// </summary>
        public event PropertyChangedEventHandler? PropertyChanged;

        public StudentsViewModel()
        {
            Students = new ObservableCollection<Student>();
            NewStudent = new Student();
            AddCommand = new StudentAddCommand(this); // parancs létrehozása

            Students.Add(new Student { Id = 1, LastName = "Kis", FirstName = "János", StudentCode = "KIJSAAI" });
            Students.Add(new Student { Id = 2, LastName = "Nagy", FirstName = "Ferenc", StudentCode = "NAFSAAI" });
            Students.Add(new Student { Id = 3, LastName = "Huba", FirstName = "Hugó", StudentCode = "HUHSAAI" });
            Students.Add(new Student { Id = 4, LastName = "Gem", FirstName = "Géza", StudentCode = "GEGSAAI" });
            // a tulajdonságokat objektuminicializálás segítségével hozzuk létre
        }

        /// <summary>
        /// Új hallgató felvétele.
        /// </summary>
        public void AddNewStudent()
        {
            Students.Add(NewStudent);
            NewStudent = new Student();
            OnPropertyChanged(nameof(NewStudent));
        }

        /// <summary>
        /// Tulajdonságváltozás eseménykliváltása.
        /// </summary>
        /// <param name="property">A tulajdonság neve.</param>
        private void OnPropertyChanged(String property)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(property));
        }
    }
}
