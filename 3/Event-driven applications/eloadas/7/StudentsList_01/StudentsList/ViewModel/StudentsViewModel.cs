using System.Linq;
using System.Collections.ObjectModel;

namespace ELTE.StudentsList.ViewModel
{
    /// <summary>
    /// Hallgatók megjelenítő típusa.
    /// </summary>
    public class StudentsViewModel
    {
        /// <summary>
        /// Hallgatók gyűjteményének lekérdezése.
        /// </summary>
        public ObservableCollection<Student> Students { get; set; }

        public StudentsViewModel()
        {
            Students = new ObservableCollection<Student>();

            Students.Add(new Student { Id = 1, LastName = "Kis", FirstName = "János", StudentCode = "KIJSAAI" });
            Students.Add(new Student { Id = 2, LastName = "Nagy", FirstName = "Ferenc", StudentCode = "NAFSAAI" });
            Students.Add(new Student { Id = 3, LastName = "Huba", FirstName = "Hugó", StudentCode = "HUHSAAI" });
            Students.Add(new Student { Id = 4, LastName = "Gem", FirstName = "Géza", StudentCode = "GEGSAAI" });
            // a tulajdonságokat objektuminicializálás segítségével hozzuk létre
        }
    }
}
