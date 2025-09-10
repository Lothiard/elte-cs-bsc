using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace ELTE.ExamGenerator
{
    /// <summary>
    /// Beállítások kezelőablakának típusa.
    /// </summary>
    public partial class SettingsForm : Form
    {
        private List<Int32> _historyList; // a korábban húzott tételeket tartalmazó lista

        /// <summary>
        /// Tételek számának lekérdezése.
        /// </summary>
        public Int32 QuestionCount
        {
            get { return Convert.ToInt32(_numericQuestionCount.Value); }
        }

        /// <summary>
        /// Periódus hosszának lekérdezése.
        /// </summary>
        public Int32 PeriodLength
        {
            get { return Convert.ToInt32(_numericPeriodLength.Value); }
        }

        /// <summary>
        /// Beállítások kezelőablakának példányosítása.
        /// </summary>
        /// <param name="questionCount">Tételek száma.</param>
        /// <param name="periodCount">Periódushossz.</param>
        /// <param name="historyList">Korábbi tételek listája.</param>
        public SettingsForm(Int32 questionCount, Int32 periodCount, List<Int32> historyList)
        {
            InitializeComponent();

            _numericQuestionCount.Value = questionCount;
            _numericPeriodLength.Value = periodCount;
            _numericPeriodLength.Maximum = _numericQuestionCount.Value - 1;
            _historyList = historyList; 

            // számok betöltése a listába
            for (Int32 i = 1; i <= _numericQuestionCount.Value; i++)
            {
                _checkedListBox.Items.Add(i, !_historyList.Contains(i));
                // ha szerepel a korábban kíhúzottak között, akkor bejelöljük
            }

            _numericQuestionCount.ValueChanged += new EventHandler(NumericQuestionCount_ValueChanged);
        }

        /// <summary>
        /// Ok gomb eseménykezelője.
        /// </summary>
        private void ButtonOk_Click(object? sender, EventArgs e)
        {
            for (Int32 i = _historyList.Count - 1; i >= 0; i--)
            {
                // törlünk minden elemet a korábbi tételekből, ami már nem aktuális
                if (_historyList[i] >= _numericQuestionCount.Value || _checkedListBox.CheckedItems.Contains(_historyList[i]))
                    _historyList.RemoveAt(i);
            }
            // ha túl nagy a lista, akkor is töröljük a legrégebbi tételeket
            while (_historyList.Count > _numericPeriodLength.Value)
                _historyList.RemoveAt(_historyList.Count - 1);

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
                _checkedListBox.Items.Add(i, !_historyList.Contains(i));
                // ha szerepel a korábban kíhúzottak között, akkor bejelöljük
            }
        }
    }
}
