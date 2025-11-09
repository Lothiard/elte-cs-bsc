using System;

namespace ELTE.ExamGenerator.ViewModel
{
    /// <summary>
    /// Történeti elem típusa.
    /// </summary>
    public class HistoryItem
    {
        /// <summary>
        /// Sorszám lekérdezése.
        /// </summary>
        public Int32 Number { get; private set; }

        /// <summary>
        /// Kijelölés lekérdezése, vagy beállítása.
        /// </summary>
        public Boolean IsChecked { get; set; }

        /// <summary>
        /// Történeti elem példányosítása.
        /// </summary>
        /// <param name="number">Sorszám.</param>
        /// <param name="isChecked">Kijelölés.</param>
        public HistoryItem(Int32 number, Boolean isChecked)
        {
            Number = number;
            IsChecked = isChecked;
        }
    }
}
