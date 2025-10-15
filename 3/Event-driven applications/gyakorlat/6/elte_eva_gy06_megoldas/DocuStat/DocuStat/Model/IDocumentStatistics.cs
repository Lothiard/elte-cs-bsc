using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ELTE.DocuStat.Model
{
    public interface IDocumentStatistics
    {
        string FileContent { get; }
        IDictionary<string, int> DistinctWordCount { get; }
        int CharacterCount { get; }
        int NonWhiteSpaceCharacterCount { get; }
        int SentenceCount { get; }
        int ProperNounCount { get; }
        double ColemanLieuIndex { get; }
        double FleschReadingEase { get; }

        event EventHandler? FileContentReady;
        event EventHandler? TextStatisticsReady;

        Task LoadAsync();
    }
}