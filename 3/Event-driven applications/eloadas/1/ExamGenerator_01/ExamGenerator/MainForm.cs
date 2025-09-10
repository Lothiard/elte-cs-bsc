using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace ELTE.ExamGenerator
{
    /// <summary>
    /// Főablak típusa.
    /// </summary>
    public partial class MainForm : Form
    {
        private Timer _timer; // időzítő a véletlengeneráláshoz
        private Random _questionGenerator; // véletlenszám generátor
        private Int32 _questionCount; // a tételek száma
        private Int32 _periodLength; // periódus hossza
        private List<Int32> _historyList; // a korábban húzott számok listája

        /// <summary>
        /// Főablak példányosítása.
        /// </summary>
        public MainForm()
        {
            InitializeComponent();

            _historyList = new List<Int32>();
            _questionCount = 10;
            _periodLength = 0;
            _questionGenerator = new Random(); // időfüggő véletlenszám generálás (mindig más számok lesznek)

            _timer = new Timer();
            _timer.Interval = 20; // 0.02 másodpercenként történő futtatás
            _timer.Tick += new EventHandler(Timer_Tick); // időzített esemény társítása
        }

        /// <summary>
        /// Időzítő eseménykezelése.
        /// </summary>
        private void Timer_Tick(object? sender, EventArgs e)
        {
            Int32 number = _questionGenerator.Next(1, _questionCount + 1); // új szám generálása 1 és a tételszám között
            while (_historyList.Contains(number)) // ha a szám szerepel a korábbiak között
                number = _questionGenerator.Next(1, _questionCount + 1); // akkor új generálása

            _textNumber.Text = number.ToString();
        }

        /// <summary>
        /// Start gomb eseménykezelője.
        /// </summary>
        private void ButtonStart_Click(object? sender, EventArgs e)
        {
            if (!_timer.Enabled) // ha még nem fut az időzítő
            {
                _timer.Start(); // elindítjuk
                _buttonStart.Text = "STOP";
            }
            else // ha fut az időzítő
            {
                _historyList.Insert(0, Int32.Parse(_textNumber.Text)); // elmentjük az új tételt

                if (_historyList.Count > _periodLength) // ha elértük a perióduskorlátot
                    _historyList.RemoveAt(_historyList.Count - 1); // töröljük a legrégebbi elemet
                
                _timer.Stop(); // leállítjuk az időzítőt
                _buttonStart.Text = "START";
            }
        }

        /// <summary>
        /// Beállítások gomb eseménykezelője.
        /// </summary>
        private void ButtonSet_Click(object? sender, EventArgs e)
        {
            SettingsForm settingsForm = new SettingsForm(_questionCount, _periodLength, _historyList); // dialógusablak létrehozása paraméterekkel

            if (settingsForm.ShowDialog() == DialogResult.OK) // dialógusablak megjelenítése
            {
                _questionCount = settingsForm.QuestionCount; // elmentjük az új értékeket
                _periodLength = settingsForm.PeriodLength;
            }
        }
    }
}
