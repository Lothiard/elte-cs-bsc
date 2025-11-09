using System;
using System.Collections.ObjectModel;
using System.Windows;
using ELTE.ExamGenerator.Model;

namespace ELTE.ExamGenerator.ViewModel
{
    /// <summary>
    /// Tételgenerátor nézetmodell típusa.
    /// </summary>
    public class ExamGeneratorViewModel : ViewModelBase
    {
        private IExamGeneratorModel _model;
        private String _text = "START";
        private Int32 _periodCount;
        private Int32 _questionCount;

        /// <summary>
        /// Felirat lekérdezése.
        /// </summary>
        public String Text
        {
            get { return _text; }
            set
            {
                if (_text != value)
                {
                    _text = value;
                    OnPropertyChanged();
                }
            }
        }

        /// <summary>
        /// Aktuális tétel lekérdezése.
        /// </summary>
        public String QuestionNumber { get { return (_model.QuestionNumber == 0) ? String.Empty : _model.QuestionNumber.ToString(); } }

        /// <summary>
        /// Tételek számának lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 QuestionCount 
        { 
            get { return _questionCount; } 
            set 
            {
                if (_questionCount != value)
                {
                    _questionCount = value;
                    OnPropertyChanged();
                    GenerateHistory();
                }
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
                if (_periodCount != value)
                {
                    _periodCount = value;
                    OnPropertyChanged();
                    GenerateHistory();
                }
            } 
        }

        /// <summary>
        /// Történet lekérdezése.
        /// </summary>
        public ObservableCollection<HistoryItem> History { get; private set; }

        /// <summary>
        /// Indítás/leállítás parancsának lekérdezése.
        /// </summary>
        public DelegateCommand StartStopCommand { get; private set; }

        /// <summary>
        /// Beállítások megnyitási parancsának lekérdezése.
        /// </summary>
        public DelegateCommand OpenSettingsCommand { get; private set; }

        /// <summary>
        /// Beállítások bezárási parancsának lekérdezése.
        /// </summary>
        public DelegateCommand CloseSettingsCommand { get; private set; }

        /// <summary>
        /// Üzenetjelzés eseménye.
        /// </summary>
        public event EventHandler<ApplicationMessageEventArgs>? ApplicationMessaged;

        /// <summary>
        /// Beállítások megnyitásának eseménye.
        /// </summary>
        public event EventHandler? OpenSettingsExecuted;

        /// <summary>
        /// Beállítások bezárásának eseménye.
        /// </summary>
        public event EventHandler? CloseSettingsExecuted;

        public ExamGeneratorViewModel(IExamGeneratorModel model)
        {
            _model = model; // modell átadása
            _model.NumberGenerated += new EventHandler(Model_NumberGenerated);
               // kezeljük a modell eseményét

            Text = "START";
            _questionCount = _model.QuestionCount;
            _periodCount = _model.PeriodCount;
            History = new ObservableCollection<HistoryItem>();
            GenerateHistory();

            // parancsok létrehozása
            StartStopCommand = new DelegateCommand(param => StartStop());
            OpenSettingsCommand = new DelegateCommand(param => 
            { 
                OpenSettings();
                OnOpenSettingsExecuted(); // az értékbeállítások mellett eseményt is kiváltunk
            });
            CloseSettingsCommand = new DelegateCommand(param =>
            {
                if (Boolean.Parse(param?.ToString() ?? Boolean.FalseString)) 
                    SaveSettings(); // mentés végrehajtása
                OnCloseSettingsExecuted();
            });
        }

        /// <summary>
        /// Indítás/leállítás.
        /// </summary>
        private void StartStop()
        {
            if (!_model.IsGenerating) // ha még nem fut a generálás
            {
                _model.Generate();
                Text = "STOP";
            }
            else // ha fut az időzítő
            {
                _model.Take();
                GenerateHistory();
                Text = "START";
            }
        }

        /// <summary>
        /// Beállítások megnyitása.
        /// </summary>
        private void OpenSettings()
        {
            QuestionCount = _model.QuestionCount; // beállítjuk az értékeket
            PeriodCount = _model.PeriodCount;
        }

        /// <summary>
        /// Beállítások mentése.
        /// </summary>
        private void SaveSettings()
        {
            try // megpróbáljuk elmenteni az értékeket
            {
                _model.QuestionCount = _questionCount;
            }
            catch
            {
                OnApplicationMessaged("A télek száma nem megfelelő, korrigálva lesz.", MessageType.Error);
                return;
            }

            try
            {
                _model.PeriodCount = _periodCount;
            }
            catch
            {
                OnApplicationMessaged("A periódushossz nem megfelelő, korrigálva lesz.", MessageType.Error);
                return;
            }

            foreach (HistoryItem item in History)
            {
                // minden olyan elemnél, ami vissza lett helyezve
                if (item.IsChecked)
                    _model.Return(item.Number);
            }
        }

        /// <summary>
        /// Történeti lista generálása.
        /// </summary>
        private void GenerateHistory()
        {
            History.Clear();
            for (Int32 i = 1; i <= _questionCount; i++)
            { 
                History.Add(new HistoryItem(i, i > _model.QuestionCount || _model.Takeable(i))); 
                // létrehozzuk a lista elemeit
            }
        }

        /// <summary>
        /// Szám generálásának eseménykezelője.
        /// </summary>s
        private void Model_NumberGenerated(object? sender, EventArgs e)
        {
            Application.Current.Dispatcher.BeginInvoke(new Action(() => OnPropertyChanged(nameof(QuestionNumber))));
                // szinkronizált végrehajtás
        }

        /// <summary>
        /// Alkalmazás üzenet eseménykiváltása.
        /// </summary>
        /// <param name="message">Üzenet szövege.</param>
        /// <param name="type">Üzenet típusa.</param>
        private void OnApplicationMessaged(String message, MessageType type)
        {
            if (ApplicationMessaged != null)
                ApplicationMessaged(this, new ApplicationMessageEventArgs { Message = message, Type = type });
        }

        /// <summary>
        /// Beállítások megnyitásának eseménykiváltása.
        /// </summary>
        private void OnOpenSettingsExecuted()
        {
            if (OpenSettingsExecuted != null)
                OpenSettingsExecuted(this, EventArgs.Empty);
        }

        /// <summary>
        /// Beállítások bezárásának eseménykiváltása.
        /// </summary>
        private void OnCloseSettingsExecuted()
        {
            if (CloseSettingsExecuted != null)
                CloseSettingsExecuted(this, EventArgs.Empty);
        }
    }
}
