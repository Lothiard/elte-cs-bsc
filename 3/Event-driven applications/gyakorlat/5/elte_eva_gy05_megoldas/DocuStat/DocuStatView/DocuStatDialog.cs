using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using ELTE.DocuStat.Model;
using ELTE.DocuStat.Persistence;

namespace ELTE.DocuStat.View
{
    public partial class DocuStatDialog : Form
    {
        private IDocumentStatistics? _documentStatistics;

        private readonly string _prefixCharacters;
        private readonly string _prefixNonWhitespaceCharacters;
        private readonly string _prefixSentences;
        private readonly string _prefixProperNouns;
        private readonly string _prefixColemanLieuIndex;
        private readonly string _prefixFleschReadingEase;

        public DocuStatDialog()
        {
            InitializeComponent();

            openFileDialogMenuItem.Click += OpenDialog;
            countWordsMenuItem.Click += CountWords;

            _prefixCharacters = labelCharacters.Text;
            _prefixNonWhitespaceCharacters = labelNonWhitespaceCharacters.Text;
            _prefixSentences = labelSentences.Text;
            _prefixProperNouns = labelProperNouns.Text;
            _prefixColemanLieuIndex = labelColemanLieuIndex.Text;
            _prefixFleschReadingEase = labelFleschReadingEase.Text;
        }

        private void OpenDialog(object? sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "C:\\";
                openFileDialog.Filter = "Text files (*.txt)|*.txt|PDF files (*.pdf)|*.pdf";
                openFileDialog.RestoreDirectory = true;

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    IFileManager? fileManager = FileManagerFactory.CreateForPath(openFileDialog.FileName);

                    if (fileManager == null)
                    {
                        MessageBox.Show("File reading is unsuccessful!\nUnsupported file format.",
                        "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                    
                    try
                    {
                        _documentStatistics = new DocumentStatistics(fileManager);
                        _documentStatistics.FileContentReady += UpdateFileContent;
                        _documentStatistics.TextStatisticsReady += UpdateTextStatistics;
                        _documentStatistics.Load();
                    }
                    catch (FileManagerException ex)
                    {
                        MessageBox.Show("File reading is unsuccessful!\n" + ex.Message,
                        "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
            }
        }

        private void CountWords(object? sender, EventArgs e)
        {
            if (_documentStatistics == null || String.IsNullOrEmpty(_documentStatistics.FileContent))
            {
                MessageBox.Show("No file is loaded!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            int minLength = Convert.ToInt32(spinBoxMinLength.Value);
            int minOccurrence = Convert.ToInt32(spinBoxMinOccurrence.Value);

            var ignoredWords = textBoxIgnoredWords.Text.Split(',')
                .Select(w => w.Trim().ToLower())
                .ToList() ?? new List<string>();

            var pairs = _documentStatistics.DistinctWordCount
                .Where(p => p.Value >= minOccurrence)
                .Where(p => p.Key.Length >= minLength)
                .Where(p => !ignoredWords.Contains(p.Key))
                .OrderByDescending(p => p.Value);

            listBoxCounter.Items.Clear(); // újbóli statisztika készítésekor töröljük a már listán szereplõ elemeket
            listBoxCounter.BeginUpdate();
            foreach (var pair in pairs)
            {
                listBoxCounter.Items.Add(pair.Key + ": " + pair.Value);
            }
            listBoxCounter.EndUpdate();
        }

        private void UpdateFileContent(object? sender, EventArgs e)
        {
            if (_documentStatistics?.FileContent == textBox.Text)
                return; // nem változott a tartalom

            textBox.Text = _documentStatistics?.FileContent;
            listBoxCounter.Items.Clear();
        }

        private void UpdateTextStatistics(object? sender, EventArgs e)
        {
            labelCharacters.Text = $"{_prefixCharacters} {_documentStatistics!.CharacterCount}";
            labelNonWhitespaceCharacters.Text = $"{_prefixNonWhitespaceCharacters} {_documentStatistics.NonWhiteSpaceCharacterCount}";
            labelSentences.Text = $"{_prefixSentences} {_documentStatistics.SentenceCount}";
            labelProperNouns.Text = $"{_prefixProperNouns} {_documentStatistics.ProperNounCount}";
            labelColemanLieuIndex.Text = $"{_prefixColemanLieuIndex} {_documentStatistics.ColemanLieuIndex:F2}";
            labelFleschReadingEase.Text = $"{_prefixFleschReadingEase} {_documentStatistics.FleschReadingEase:F2}";
        }
    }
}