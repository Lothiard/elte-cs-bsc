using System;
using System.Windows.Forms;
using ELTE.ExamGenerator.Model;

namespace ELTE.ExamGenerator.View
{
    /// <summary>
    /// Beállítások kezelőablakának típusa.
    /// </summary>
    public partial class SettingsForm : Form
    {
        private ExamGeneratorModel _model;

        /// <summary>
        /// Beállítások kezelőablakának példányosítása.
        /// </summary>
        public SettingsForm(ExamGeneratorModel model)
        {
            InitializeComponent();

            _model = model;
            _numericQuestionCount.Value = _model.QuestionCount;
            _numericPeriodLength.Value = _model.PeriodCount;            
            _numericPeriodLength.Maximum = _numericQuestionCount.Value - 1;

            // számok betöltése a listába
            for (Int32 i = 1; i <= _numericQuestionCount.Value; i++)
            {
                _checkedListBox.Items.Add(i, _model.Takeable(i));
                // ha szerepel a korábban kíhúzottak között, akkor bejelöljük
            }

            _numericQuestionCount.ValueChanged += new EventHandler(NumericQuestionCount_ValueChanged);
        }

        /// <summary>
        /// Ok gomb eseménykezelője.
        /// </summary>
        private void ButtonOk_Click(object? sender, EventArgs e)
        {
            foreach (Int32 value in _checkedListBox.CheckedItems)
            {
                // minden olyan elemnél, ami vissza lett helyezve
                _model.Return(value);
            }

            _model.QuestionCount = Convert.ToInt32(_numericQuestionCount.Value);
            _model.PeriodCount = Convert.ToInt32(_numericPeriodLength.Value);

            DialogResult = DialogResult.OK; // jelezzük, hogy OK-val zárták le az ablakot
            Close();
        }

        /// <summary>
        /// Mégse gomb eseménykezelője.
        /// </summary>
        private void ButtonCancel_Click(object? sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel; // jelezzük, hogy Mégse-vel zárták le az ablakot
            Close();
        }

        /// <summary>
        /// Tétel számának eseménykezelője.
        /// </summary>
        private void NumericQuestionCount_ValueChanged(object? sender, EventArgs e)
        {
            if (_numericPeriodLength.Value > _numericQuestionCount.Value - 1)
                _numericPeriodLength.Value = _numericQuestionCount.Value - 1;
            _numericPeriodLength.Maximum = _numericQuestionCount.Value - 1;
            // a periódus értéke nem lehet nagyobb a maximális értéknél

            // ha kisebbre állítottuk az értéket, akkor csökkentjük a kijelölő listát
            for (Int32 i = _checkedListBox.Items.Count - 1; i >= _numericQuestionCount.Value; i--)
            {
                _checkedListBox.Items.Remove(_checkedListBox.Items[i]);
            }

            // ha nagyobbra állítottuk, növeljük a listát
            for (Int32 i = _checkedListBox.Items.Count + 1; i <= _numericQuestionCount.Value; i++)
            {
                _checkedListBox.Items.Add(i, _model.Takeable(i));
                // ha szerepel a korábban kíhúzottak között, akkor bejelöljük
            }
        }
    }
}
