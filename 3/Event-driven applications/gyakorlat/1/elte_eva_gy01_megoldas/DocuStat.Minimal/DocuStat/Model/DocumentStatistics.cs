using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace ELTE.DocuStat.Model
{
    public class DocumentStatistics : IDocumentStatistics
    {
        #region Fields

        private readonly string _filePath;

        #endregion

        #region Properties

        public string FileContent { get; private set; }

        public IDictionary<string, int> DistinctWordCount { get; private set; }

        #endregion

        #region Constructors

        public DocumentStatistics(string filePath)
        {
            _filePath = filePath;
            FileContent = string.Empty;
            DistinctWordCount = new Dictionary<string, int>();
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Loads and processes the file.
        /// </summary>
        public void Load()
        {
            FileContent = File.ReadAllText(_filePath);

            ComputeDistinctWords();
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

        #endregion
    }
}
