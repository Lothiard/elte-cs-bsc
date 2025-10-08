using System;
using System.Windows.Forms;
using ELTE.ExamGenerator.Model;

namespace ELTE.ExamGenerator.View
{
    /// <summary>
    /// Főablak típusa.
    /// </summary>
    public partial class MainForm : Form
    {
        private ExamGeneratorModel _model; // modell

        /// <summary>
        /// Főablak példányosítása.
        /// </summary>
        public MainForm()
        {
            InitializeComponent();

            _model = new ExamGeneratorModel(10, 0);
            _model.NumberGenerated += new EventHandler(Model_NumberGenerated); // modell eseménye
        }

        /// <summary>
        /// Szám generálásának eseménykezelője.
        /// </summary>
        private void Model_NumberGenerated(object? sender, EventArgs e)
        {
            BeginInvoke(new Action(() => { _textNumber.Text = _model.QuestionNumber.ToString(); }));
               // szinkronizált végrehajtás
        }

        /// <summary>
        /// Start gomb eseménykezelője.
        /// </summary>
        private void ButtonStart_Click(object? sender, EventArgs e)
        {
            if (!_model.IsGenerating) // ha még nem fut a generálás
            {
                _model.Generate();
                _buttonStart.Text = "STOP";
            }
            else // ha fut az időzítő
            {
                _model.Take();
                _buttonStart.Text = "START";
            }
        }

        /// <summary>
        /// Beállítások gomb eseménykezelője.
        /// </summary>
        private void ButtonSet_Click(object? sender, EventArgs e)
        {
            SettingsForm f = new SettingsForm(_model);
            f.ShowDialog(); // dialógusablak megjelenítése
        }
    }
}
