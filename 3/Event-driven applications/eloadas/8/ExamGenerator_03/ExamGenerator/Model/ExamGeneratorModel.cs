using System;
using System.Collections.Generic;
using System.Timers;

namespace ELTE.ExamGenerator.Model
{
    /// <summary>
    /// Tételgenerátor modell típusa.
    /// </summary>
    public class ExamGeneratorModel : IExamGeneratorModel, IDisposable
    {
        private Int32 _questionCount; // tételek száma
        private Int32 _periodCount; // periódushossz
        private Int32 _questionNumber; // tétel száma
        private List<Int32> _historyList; // kihúzott tételek listája
        private Random _questionGenerator; // véletlenszám generátor
        private Timer _timer; // időzítő

        /// <summary>
        /// Aktuális kérdés számának lekérdezése.
        /// </summary>
        public Int32 QuestionNumber { get { return _questionNumber; } }

        /// <summary>
        /// Generálás folyamatának lekérdezése.
        /// </summary>
        public Boolean IsGenerating { get { return _timer.Enabled; } }

        /// <summary>
        /// Tételek számának lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 QuestionCount
        {
            get { return _questionCount; }
            set
            {
                if (value <= 0)
                    throw new InvalidOperationException("Thesis count must be a positive value.");
                _questionCount = value;
                if (_periodCount >= value) // ellenőrizzük a periódushosszt
                {
                    _periodCount = value - 1;
                    while (_historyList.Count > _periodCount) // a történeti lista hosszát 
                        _historyList.RemoveAt(_historyList.Count - 1);
                }
                for (Int32 i = _historyList.Count - 1; i >= 0; i--) // ellenőrizzük a történeti elemeket is
                    if (_historyList[i] > _questionCount)
                        _historyList.RemoveAt(i);
            }
        }

        /// <summary>
        /// Periódushossz lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 PeriodCount
        {
            get { return _periodCount; }
            set
            {
                if (value >= _questionCount)
                    throw new InvalidOperationException("Period count must be smaller than the thesis count.");
                if (value < 0)
                    throw new InvalidOperationException("Period count cannot be negative.");

                _periodCount = value;
                while (_historyList.Count > _periodCount) // ellenőrizzük a történeti lista hosszát 
                    _historyList.RemoveAt(0);
            }
        }

        /// <summary>
        /// Számgenerálás eseménye.
        /// </summary>
        public event EventHandler? NumberGenerated;

        /// <summary>
        /// Tételgenerátor modell példányosítása.
        /// </summary>
        /// <param name="questionCount">Tételek száma.</param>
        /// <param name="periodCount">Periódushossz.</param>
        public ExamGeneratorModel(Int32 questionCount, Int32 periodCount)
        {
            if (questionCount <= 0)
                throw new ArgumentException("Thesis count must be a positive value.", "thesisCount");
            if (periodCount >= questionCount)
                throw new ArgumentException("Period count must be smaller than the thesis count.", "periodCount");
            if (periodCount < 0)
                throw new ArgumentException("Period count cannot be negative.", "periodCount");

            _questionCount = questionCount;
            _periodCount = periodCount;

            _historyList = new List<Int32>();

            _questionGenerator = new Random();

            _timer = new Timer(20);
            _timer.Elapsed += new ElapsedEventHandler(Timer_Elapsed);
        }

        /// <summary>
        /// Menedzselt erőforrások felszabadítása.
        /// </summary>
        public void Dispose()
        {
            _timer.Dispose();
        }

        /// <summary>
        /// Új tételszám generálása.
        /// </summary>
        /// <returns>A generált tételszám.</returns>
        public void Generate()
        {
            if (_timer.Enabled) // ha már fut a generálás nem csinálunk semmit
                return;

            _timer.Start();
        }

        /// <summary>
        /// Húzható-e a tétel.
        /// </summary>
        /// <param name="number">A tétel száma.</param>
        /// <returns>Igaz, ha tétel húzható, egyébként hamis.</returns>
        public Boolean Takeable(Int32 number)
        {
            if (number <= 0 || number > _questionCount)
                throw new ArgumentException("The argument is not a question number.", "number");

            return !_historyList.Contains(number);
        }

        /// <summary>
        /// Tétel elfogadása.
        /// </summary>
        public void Take()
        {
            _timer.Stop();

            _historyList.Add(_questionNumber); // felvesszük a számok közé
            if (_historyList.Count > _periodCount) // ha túlcsordulás történt, töröljük a legrégebbi tételt
                _historyList.RemoveAt(0);
        }

        /// <summary>
        /// Tétel visszahelyezése.
        /// </summary>
        /// <param name="number">A tétel sorszáma.</param>
        public void Return(Int32 number)
        {
            if (number <= 0 || number > _questionCount)
                throw new ArgumentException("The argument is not a question number.", "number");

            _historyList.Remove(number);
        }

        /// <summary>
        /// Számgenerálás eseményének kiváltása.
        /// </summary>
        private void OnNumberGenerated()
        {
            if (NumberGenerated != null) // ha van eseménytársítás
                NumberGenerated(this, EventArgs.Empty); // akkor váltsuk ki az eseményt
        }

        /// <summary>
        /// Időzítő eseménykezelője.
        /// </summary>
        private void Timer_Elapsed(object? sender, ElapsedEventArgs e)
        {
            _questionNumber = _questionGenerator.Next(1, _questionCount + 1); // új szám generálása 1 és a tételszám között
            while (_historyList.Contains(_questionNumber)) // ha a szám szerepel a korábbiak között
                _questionNumber = _questionGenerator.Next(1, _questionCount + 1); // akkor új generálása

            OnNumberGenerated();
        }
    }
}
