using System;
using System.Windows.Input;

namespace ELTE.StudentsList.ViewModel
{
    /// <summary>
    /// Hallgató felvételi utasítás típusa.
    /// </summary>
    public class StudentAddCommand : ICommand
    {
        private StudentsViewModel _viewModel;

        /// <summary>
        /// Hallgató felvételi utasítás példányosítása.
        /// </summary>
        /// <param name="viewModel">A hallgatói nézetmodell.</param>
        public StudentAddCommand(StudentsViewModel viewModel)
        {
            _viewModel = viewModel;
        }

        /// <summary>
        /// Végrehajtható-e az utasítás.
        /// </summary>
        /// <param name="parameter">Paraméter.</param>
        /// <returns></returns>
        public Boolean CanExecute(Object? parameter)
        {
            return true; // mindig végrehajtható
        }

        /// <summary>
        /// Parancs végrehajthatóságának megváltozását jelző esemény.
        /// </summary>
        public event EventHandler? CanExecuteChanged;

        /// <summary>
        /// Parancs végrehajtása.
        /// </summary>
        /// <param name="parameter">Paraméter.</param>
        public void Execute(Object? parameter)
        {
            _viewModel.AddNewStudent();
        }
    }
}
