//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Test cases of height of the highest depression

using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using Depression;

namespace TestDepression
{
    [TestClass]
    public class CondMaxSearchTests
    {
        [TestMethod]
        public void Test_NullLengthEnumerator()
        {
            List<double> x = new ();
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, false);

            x.Add(1.0); x.Add(2.0);
            l = Program.MaxSearch(in x, out max, out ind);
            Assert.AreEqual(l, false);
        }

        [TestMethod]
        public void Test_OneLengthEnumerator()
        {
            List<double> x = new () { 2.1, 1.0, 2.4 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 1.0);
            Assert.AreEqual(ind, 1);
        }

        [TestMethod]
        public void Test_SeveralLengthEnumerator()
        {
            List<double> x = new () { 1.0, 2.0, 1.5, 4.0, 2.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 1.5);
            Assert.AreEqual(ind, 2);
        }

        [TestMethod]
        public void Test_First()
        {
            List<double> x = new () { 3.0, 2.5, 3.0, 2.0, 3.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.5);
            Assert.AreEqual(ind, 1);
        }

        [TestMethod]
        public void Test_Last()
        {
            List<double> x = new () { 3.0, 2.0, 3.0, 2.5, 3.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.5);
            Assert.AreEqual(ind, 3);
        }

        [TestMethod]
        public void Test_NoDepression()
        {
            List<double> x = new () { 1.0, 2.0, 3.0, 4.0, 5.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, false);
        }

        [TestMethod]
        public void Test_HasDepression()
        {
            List<double> x = new () { 1.0, 2.0, 1.0, 4.0, 2.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 1.0);
            Assert.AreEqual(ind, 2);
        }

        [TestMethod]
        public void Test_OneMax()
        {
            List<double> x = new () { 3.0, 1.5, 3.0, 2.5, 3.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.5);
            Assert.AreEqual(ind, 3);
        }

        [TestMethod]
        public void Test_SeveralMaxs()
        {
            List<double> x = new () { 3.0, 2.0, 3.0, 2.0, 3.0 };
            bool l = Program.MaxSearch(in x, out double max, out int ind);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.0);
            Assert.IsTrue(ind == 1 || ind==3);
        }
    }
}
