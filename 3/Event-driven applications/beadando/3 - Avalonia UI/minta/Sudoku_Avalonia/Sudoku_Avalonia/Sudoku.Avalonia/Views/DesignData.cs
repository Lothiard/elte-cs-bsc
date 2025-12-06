using ELTE.Sudoku.Model;
using ELTE.Sudoku.Persistence;
using ELTE.Sudoku.Avalonia.ViewModels;
using System;

namespace ELTE.Sudoku.Avalonia.Views
{
    public static class DesignData
    {
        public static SudokuViewModel ViewModel
        {
            get
            {
                var model = new SudokuGameModel(new SudokuFileDataAccess(), new SudokuTimerInheritance());
                model.NewGame();
                model.PauseGame();
                // egy elindított játékot rakunk be a nézetmodellbe, így a tervezőfelületen sem csak üres cellák lesznek
                return new SudokuViewModel(model);
            }
        }
    }
}
