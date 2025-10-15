using ELTE.DocuStat.Model;
using ELTE.DocuStat.Persistence;
using Moq;
using System;
using Xunit;

namespace ELTE.DocuStat.XTest
{
    public class DocumentStatisticsTest
    {
        #region Fields

        private readonly Mock<IFileManager> _mock;
        private readonly DocumentStatistics _docStats;

        #endregion

        #region Constructor and Utility

        public DocumentStatisticsTest()
        {
            _mock = new Mock<IFileManager>();
            _docStats = new DocumentStatistics(_mock.Object);
        }

        private void MockAndLoadText(string text)
        {
            _mock.Setup(fileManager => fileManager.Load()).Returns(text);
            _docStats.Load();
        }

        #endregion

        #region File Loading

        [Fact]
        public void TestFileLoading()
        {
            bool fileContentReadyRaised = false;
            bool textStatisticsReadyRaised = false;
            _docStats.FileContentReady += (sender, args) => fileContentReadyRaised = true;
            _docStats.TextStatisticsReady += (sender, args) => textStatisticsReadyRaised = true;

            MockAndLoadText("Hello World");

            Assert.Equal("Hello World", _docStats.FileContent);
            Assert.NotEqual(0, _docStats.DistinctWordCount.Count);
            Assert.True(fileContentReadyRaised);
            Assert.True(textStatisticsReadyRaised);
        }

        [Fact]
        public void TestFileLoadingWithException()
        {
            _mock.Setup(fileManager => fileManager.Load()).Returns(() => throw new Exception());
            Assert.Throws<Exception>(() => _docStats.Load());
        }

        #endregion

        #region DistinctWordCount

        [Fact]
        public void TestDistinctWordCountForEmptyText()
        {
            MockAndLoadText("");
            Assert.Equal(0, _docStats.DistinctWordCount.Count);
        }

        [Fact]
        public void TestDistinctWordCountForSpecialCharacterText()
        {
            MockAndLoadText(" *?.!  ");
            Assert.Equal(0, _docStats.DistinctWordCount.Count);
        }

        [Fact]
        public void TestDistinctWordCountSameWordRepeating()
        {
            MockAndLoadText("hello hello hello");
            Assert.Equal(1, _docStats.DistinctWordCount.Count);
            Assert.Equal(3, _docStats.DistinctWordCount["hello"]);
        }

        [Fact]
        public void TestDistinctWordCountSameWordRepeatingWithSpecialChars()
        {
            MockAndLoadText("**hello hello1123 35345hello345345 hello");
            Assert.Equal(1, _docStats.DistinctWordCount.Count);
            Assert.Equal(4, _docStats.DistinctWordCount["hello"]);
        }

        [Fact]
        public void TestDistinctWordCountSameWordWithSpecialCharsInTheMiddle()
        {
            MockAndLoadText("hello hell'o");
            Assert.Equal(2, _docStats.DistinctWordCount.Count);
            Assert.Equal(1, _docStats.DistinctWordCount["hello"]);
            Assert.Equal(1, _docStats.DistinctWordCount["hell'o"]);
        }

        [Fact]
        public void TestDistinctWordCountMultipleWords()
        {
            MockAndLoadText("hello world! hello world!");
            Assert.Equal(2, _docStats.DistinctWordCount.Count);
            Assert.Equal(2, _docStats.DistinctWordCount["hello"]);
            Assert.Equal(2, _docStats.DistinctWordCount["world"]);
        }

        #endregion

        #region CharacterCount

        [Fact]
        public void TestCharacterCount()
        {
            MockAndLoadText("test character count");
            Assert.Equal(20, _docStats.CharacterCount);
        }

        [Fact]
        public void TestCharacterCountForEmptyFile()
        {
            MockAndLoadText("");
            Assert.Equal(0, _docStats.CharacterCount);
        }

        #endregion

        #region NonWhiteSpaceCharacterCount

        [Fact]
        public void TestNonWhitespaceCount()
        {
            MockAndLoadText("test character count");
            Assert.Equal(18, _docStats.NonWhiteSpaceCharacterCount);
        }

        [Fact]
        public void TestNonWhitespaceCountOnlyWhitespace()
        {
            MockAndLoadText("           ");
            Assert.Equal(0, _docStats.NonWhiteSpaceCharacterCount);
        }

        #endregion

        #region SentenceCount

        [Fact]
        public void TestSentenceCount()
        {
            MockAndLoadText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.Equal(2, _docStats.SentenceCount);
        }

        [Fact]
        public void TestSentenceCountZeroSentences()
        {
            MockAndLoadText("");
            Assert.Equal(0, _docStats.SentenceCount);
        }

        #endregion

        #region ProperNounCount

        [Fact]
        public void TestProperNounCount()
        {
            MockAndLoadText("thunderbolts and lightning, very, very frightening me Galileo, Galileo");
            Assert.Equal(2, _docStats.ProperNounCount);
        }

        [Fact]
        public void TestProperNounCountMultipleSentences()
        {
            MockAndLoadText("Lorem Ipsum dolor sit amet, Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.Equal(2, _docStats.ProperNounCount);
        }

        #endregion

        #region ColemanLieuIndex

        [Fact]
        public void TestColemanLieuIndex()
        {
            MockAndLoadText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.Equal(15.14, _docStats.ColemanLieuIndex, 2);
        }

        [Fact]
        public void TestColemanLieuIndexOneSentence()
        {
            MockAndLoadText("Oh hi Mark");
            Assert.Equal(-0.12, _docStats.ColemanLieuIndex, 2);
        }

        #endregion

        #region FleschReadingEase

        [Fact]
        public void TestFleschReadingEase()
        {
            MockAndLoadText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.Equal(4.99, _docStats.FleschReadingEase, 2);
        }

        [Fact]
        public void TestFleschReadingEaseNoSyllables()
        {
            MockAndLoadText("sdfsdf dfgdfg fghfgh");
            Assert.Equal(19.48, _docStats.ColemanLieuIndex);
        }

        #endregion
    }
}