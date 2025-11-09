using System;

namespace ELTE.ExamGenerator.Model
{
    /// <summary>
    /// Tételgenerátor modell interfésze.
    /// </summary>
    public interface IExamGeneratorModel
    {
        /// <summary>
        /// Aktuális kérdés számának lekérdezése.
        /// </summary>
        Int32 QuestionNumber { get; }

        /// <summary>
        /// Generálás folyamatának lekérdezése.
        /// </summary>
        Boolean IsGenerating { get; }

        /// <summary>
        /// Tételek számának lekérdezése, vagy beállítása.
        /// </summary>
        Int32 QuestionCount { get; set; }

        /// <summary>
        /// Periódushossz lekérdezése, vagy beállítása.
        /// </summary>
        Int32 PeriodCount { get; set; }

        /// <summary>
        /// Számgenerálás eseménye.
        /// </summary>
        event EventHandler NumberGenerated;

        /// <summary>
        /// Új tételszám generálása.
        /// </summary>
        /// <returns>A generált tételszám.</returns>
        void Generate();

        /// <summary>
        /// Húzható-e a tétel.
        /// </summary>
        /// <param name="number">A tétel száma.</param>
        /// <returns>Igaz, ha tétel húzható, egyébként hamis.</returns>
        Boolean Takeable(Int32 number);

        /// <summary>
        /// Tétel elfogadása.
        /// </summary>
        void Take();

        /// <summary>
        /// Tétel visszahelyezése.
        /// </summary>
        /// <param name="number">A tétel sorszáma.</param>
        void Return(Int32 number);
    }
}
