using ELTE.DocuStat.Model;
using ELTE.DocuStat.Persistence;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System;

namespace ELTE.DocuStat.Test
{
    [TestClass]
    public class DocumentStatisticsTest
    {
        #region Fields

        private Mock<IFileManager> _mock = null!;
        private DocumentStatistics _docStats = null!;

        #endregion

        #region Init and Utility methods

        [TestInitialize]
        public void InitDocumentStatisticsTest()
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

        [TestMethod]
        public void TestFileLoading()
        {
            bool fileContentReadyRaised = false;
            bool textStatisticsReadyRaised = false;
            _docStats.FileContentReady += (sender, args) => fileContentReadyRaised = true;
            _docStats.TextStatisticsReady += (sender, args) => textStatisticsReadyRaised = true;

            MockAndLoadText("Hello World");

            Assert.AreEqual("Hello World", _docStats.FileContent);
            Assert.AreNotEqual(0, _docStats.DistinctWordCount.Count);
            Assert.IsTrue(fileContentReadyRaised);
            Assert.IsTrue(textStatisticsReadyRaised);
        }

        [TestMethod]
        [ExpectedException(typeof(Exception))]
        public void TestFileLoadingWithException()
        {
            _mock.Setup(fileManager => fileManager.Load()).Returns(() => throw new Exception());
            _docStats.Load();
        }

        #endregion

        #region DistinctWordCount

        [TestMethod]
        public void TestDistinctWordCountForEmptyText()
        {
            MockAndLoadText("");
            Assert.AreEqual(0, _docStats.DistinctWordCount.Count);
        }

        [TestMethod]
        public void TestDistinctWordCountForSpecialCharacterText()
        {
            MockAndLoadText(" *?.!  ");
            Assert.AreEqual(0, _docStats.DistinctWordCount.Count);
        }

        [TestMethod]
        public void TestDistinctWordCountSameWordRepeating()
        {
            MockAndLoadText("hello hello hello");
            Assert.AreEqual(1, _docStats.DistinctWordCount.Count);
            Assert.AreEqual(3, _docStats.DistinctWordCount["hello"]);
        }

        [TestMethod]
        public void TestDistinctWordCountSameWordRepeatingWithSpecialChars()
        {
            MockAndLoadText("**hello hello1123 35345hello345345 hello");
            Assert.AreEqual(1, _docStats.DistinctWordCount.Count);
            Assert.AreEqual(4, _docStats.DistinctWordCount["hello"]);
        }

        [TestMethod]
        public void TestDistinctWordCountSameWordWithSpecialCharsInTheMiddle()
        {
            MockAndLoadText("hello hell'o");
            Assert.AreEqual(2, _docStats.DistinctWordCount.Count);
            Assert.AreEqual(1, _docStats.DistinctWordCount["hello"]);
            Assert.AreEqual(1, _docStats.DistinctWordCount["hell'o"]);
        }

        [TestMethod]
        public void TestDistinctWordCountMultipleWords()
        {
            MockAndLoadText("hello world! hello world!");
            Assert.AreEqual(2, _docStats.DistinctWordCount.Count);
            Assert.AreEqual(2, _docStats.DistinctWordCount["hello"]);
            Assert.AreEqual(2, _docStats.DistinctWordCount["world"]);
        }

        #endregion

        #region CharacterCount

        [TestMethod]
        public void TestCharacterCount()
        {
            MockAndLoadText("test character count");
            Assert.AreEqual(20, _docStats.CharacterCount);
        }

        [TestMethod]
        public void TestCharacterCountForEmptyFile()
        {
            MockAndLoadText("");
            Assert.AreEqual(0, _docStats.CharacterCount);
        }

        #endregion

        #region NonWhiteSpaceCharacterCount

        [TestMethod]
        public void TestNonWhitespaceCount()
        {
            MockAndLoadText("test character count");
            Assert.AreEqual(18, _docStats.NonWhiteSpaceCharacterCount);
        }

        [TestMethod]
        public void TestNonWhitespaceCountOnlyWhitespace()
        {
            MockAndLoadText("           ");
            Assert.AreEqual(0, _docStats.NonWhiteSpaceCharacterCount);
        }

        #endregion

        #region SentenceCount

        [TestMethod]
        public void TestSentenceCount()
        {
            MockAndLoadText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.AreEqual(2, _docStats.SentenceCount);
        }

        [TestMethod]
        public void TestSentenceCountZeroSentences()
        {
            MockAndLoadText("");
            Assert.AreEqual(0, _docStats.SentenceCount);
        }

        #endregion

        #region ProperNounCount

        [TestMethod]
        public void TestProperNounCount()
        {
            MockAndLoadText("thunderbolts and lightning, very, very frightening me Galileo, Galileo");
            Assert.AreEqual(2, _docStats.ProperNounCount);
        }

        [TestMethod]
        public void TestProperNounCountMultipleSentences()
        {
            MockAndLoadText(
                "Lorem Ipsum dolor sit amet, Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.AreEqual(2, _docStats.ProperNounCount);
        }

        #endregion

        #region ColemanLieuIndex

        [TestMethod]
        public void TestColemanLieuIndex()
        {
            MockAndLoadText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.AreEqual(15.14, _docStats.ColemanLieuIndex, 0.01);
        }

        [TestMethod]
        public void TestColemanLieuIndexOneSentence()
        {
            MockAndLoadText("Oh hi Mark");
            Assert.AreEqual(-0.12, _docStats.ColemanLieuIndex, 0.01);
        }

        #endregion

        #region FleschReadingEase

        [TestMethod]
        public void TestFleschReadingEase()
        {
            MockAndLoadText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            Assert.AreEqual(4.99, _docStats.FleschReadingEase, 0.01);
        }

        [TestMethod]
        public void TestFleschReadingEaseNoSyllables()
        {
            MockAndLoadText("sdfsdf dfgdfg fghfgh");
            Assert.AreEqual(19.48, _docStats.ColemanLieuIndex);
        }

        #endregion
    }
}