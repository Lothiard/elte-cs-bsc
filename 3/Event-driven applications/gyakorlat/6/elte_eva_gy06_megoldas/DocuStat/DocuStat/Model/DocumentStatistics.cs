using ELTE.DocuStat.Persistence;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ELTE.DocuStat.Model
{
    public class DocumentStatistics : IDocumentStatistics
    {
        #region Fields

        private readonly IFileManager _fileManager;

        #endregion

        #region Properties

        public string FileContent { get; private set; }

        public IDictionary<string, int> DistinctWordCount { get; private set; }

        public int CharacterCount => FileContent.Length;
        public int NonWhiteSpaceCharacterCount { get; private set; }
        public int SentenceCount { get; private set; }
        public int ProperNounCount { get; private set; }
        public double ColemanLieuIndex { get; private set; }
        public double FleschReadingEase { get; private set; }

        #endregion

        #region Events

        public event EventHandler? FileContentReady;
        public event EventHandler? TextStatisticsReady;

        #endregion

        #region Constructors

        public DocumentStatistics(IFileManager fileManager)
        {
            _fileManager = fileManager;
            FileContent = string.Empty;
            DistinctWordCount = new Dictionary<string, int>();
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Loads and processes the file.
        /// </summary>
        public async Task LoadAsync()
        {
            FileContent = await _fileManager.LoadAsync();
            OnFileContentReady();

            await Task.Run(() =>
            {
                NonWhiteSpaceCharacterCount = FileContent.Count(c => !char.IsWhiteSpace(c));

                ComputeDistinctWords();
                SentenceCount = ComputeSentenceCount();
                ProperNounCount = ComputeProperNounCount();
                ColemanLieuIndex = ComputeColemanLieuIndex();
                FleschReadingEase = ComputeFleschReadingEase();
                OnTextStatisticsReady();
            });
        }

        #endregion

        #region Private methods

        private void ComputeDistinctWords()
        {
            DistinctWordCount.Clear();
            string[] words = FileContent
                .Split()
                .Where(s => s.Length > 0)
                .ToArray();

            for (int i = 0; i < words.Length; ++i)
            {
                // Remove leading and trailing non letter characters
                words[i] = string.Concat(
                    words[i]
                        .SkipWhile(c => !char.IsLetter(c))
                        .Reverse()
                        .SkipWhile(c => !char.IsLetter(c))
                        .Reverse()
                );

                // Removing all characters from an all non-letter word results in an empty string.
                if (string.IsNullOrEmpty(words[i]))
                {
                    continue;
                }

                words[i] = words[i].ToLower();

                // Add word to dictionary or increment its value.
                if (DistinctWordCount.ContainsKey(words[i]))
                {
                    ++DistinctWordCount[words[i]];
                }
                else
                {
                    DistinctWordCount.Add(words[i], 1);
                }
            }
        }

        /// <summary>
        /// Counts the number of sentences.
        /// </summary>
        /// <remarks>
        /// Counts the number of sentences based on the punctuation marks.
        /// </remarks>
        private int ComputeSentenceCount()
        {
            int sentenceCount = 0;
            var marks = new char[] { '.', '!', '?' };

            for (int i = 1; i < FileContent.Length; ++i)
            {
                if (marks.Contains(FileContent[i]) && !marks.Contains(FileContent[i - 1]))
                {
                    sentenceCount++;
                }
            }

            return sentenceCount;
        }

        /// <summary>
        /// Counts the proper nouns.
        /// </summary>
        /// <remarks>
        /// Counts the proper nouns by summarizing the count of capital letters,
        /// which are not placed after a punctuation mark.
        /// </remarks>
        private int ComputeProperNounCount()
        {
            string whitespacelessContent = string.Concat(FileContent.Where(c => !char.IsWhiteSpace(c)));
            char[] marks = { '.', '!', '?' };

            int pNounCount = 0;
            for (int i = 1; i < whitespacelessContent.Length; i++)
            {
                if (char.IsUpper(whitespacelessContent[i]) && !marks.Contains(whitespacelessContent[i - 1]))
                {
                    pNounCount++;
                }
            }

            return pNounCount;
        }

        /// <summary>
        /// Calculates the Coleman-Lieu readability index of the file content.
        /// </summary>
        /// <remarks>
        /// The formula: (0.0588 * L) - (0.296 * S) - 15.8
        /// L = avarage number of characters per 100 words
        /// S = avarage number of sentences per 100 words
        /// </remarks>
        /// <see cref="https://readable.com/readability/coleman-liau-readability-index/"/>
        private double ComputeColemanLieuIndex()
        {
            double ratio = (double)DistinctWordCount.Sum(w => w.Value) / 100;

            double L = NonWhiteSpaceCharacterCount / ratio;
            double S = SentenceCount / ratio;

            return 0.0588 * L - 0.296 * S - 15.8;
        }

        /// <summary>
        /// Calculates Flesch Readding Ease score of the file content.
        /// </summary>
        /// <remarks>
        /// The formula:
        /// 206.835 - 1.015 * (total words / total sentences) - 84.6 * (total syllable / total words)
        /// </remarks>
        /// <see cref="https://readable.com/readability/flesch-reading-ease-flesch-kincaid-grade-level/"/>
        private double ComputeFleschReadingEase()
        {
            int totalwordCount = DistinctWordCount.Sum(w => w.Value);

            int totalSyllables = 0;
            foreach (var item in DistinctWordCount)
            {
                totalSyllables += CountSyllables(item.Key) * item.Value;
            }

            return 206.835 - 1.015 * ((double)totalwordCount / SentenceCount) - 84.6 * ((double)totalSyllables / totalwordCount);
        }

        /// <summary>
        /// Counts the syllables of a given word. Assumes that the word is cleared by non-letter characters.
        /// </summary>
        /// <remarks>
        /// Based on counting the vowels in the word.
        /// </remarks>
        private int CountSyllables(string word)
        {
            bool lastWasVowel = false;
            var vowels = new[] { 'a', 'e', 'i', 'o', 'u', 'y' };
            int count = 0;

            // a string is an IEnumerable<char>; convenient.
            foreach (var c in word)
            {
                if (vowels.Contains(c))
                {
                    if (!lastWasVowel)
                        count++;
                    lastWasVowel = true;
                }
                else
                {
                    lastWasVowel = false;
                }
            }

            if ((word.EndsWith("es") || word.EndsWith("ed")) && !word.EndsWith("le"))
            {
                count--;
            }

            return count;
        }
        #endregion

        #region Private event methods

        private void OnFileContentReady()
        {
            FileContentReady?.Invoke(this, EventArgs.Empty);
        }

        private void OnTextStatisticsReady()
        {
            TextStatisticsReady?.Invoke(this, EventArgs.Empty);
        }

        #endregion
    }
}
