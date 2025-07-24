using FishingContest;
using System.Globalization;
using static FishingContest.Program;

namespace FishingContestTest {
    [TestClass]
    public sealed class SearchTests {
        [TestMethod] // ures bemeneti file
        public void FileEmpty () {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            Infile f = new Infile("input2.txt");
            RunSearch(f, out bool l, out string? name);

            Assert.IsFalse(l);
        }

        [TestMethod] // nincs talalat
        public void NoSearchResult () {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            Infile f = new Infile("input3.txt");
            RunSearch(f, out bool l, out string? name);

            Assert.IsFalse(l);
        }

        [TestMethod] // van talalat
        public void CorrectSearchResult () {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            Infile f = new Infile("input2.txt");
            RunSearch(f, out bool l, out string? name);

            Assert.IsTrue(l);
            Assert.AreEqual("János", name);
        }
    }
}
