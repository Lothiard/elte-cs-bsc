//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Unit test of class Bag

using Microsoft.VisualStudio.TestTools.UnitTesting;
using Frequency;
using System.Collections.Generic;

namespace BagTest
{

    public class TransparentBag : Bag
    {
        public TransparentBag(int m) : base(m) { }

        public int[] Vec
        {
            get { return vec; }
        }
    }

    [TestClass]
    public class BagTest
    {
        [TestMethod]
        public void TestPutIn_PutInNewElement()
        {
            Bag b = new(2);
            b.PutIn(1);
            Assert.AreEqual(b.MostFrequent(), 1);
        }

        [TestMethod]
        public void TestPutIn_ExistingElement()
        {
            TransparentBag bag = new(2);
            Assert.AreEqual(bag.Vec[0], 0);
            bag.PutIn(1);
            Assert.AreEqual(bag.Vec[1], 1);
            bag.PutIn(2);
            Assert.AreEqual(bag.Vec[2], 1);
            bag.PutIn(2);
            Assert.AreEqual(bag.Vec[2], 2);
        }

        [TestMethod]
        public void TestPutIn_IllegalElement()
        {
            Bag bag = new(2);
            Assert.ThrowsException<Bag.IllegalElementException>(() => bag.PutIn(3));
        }

        [TestMethod]
        public void TestMostFrequent_EmptyBag()
        {
            Bag bag = new(2);
            Assert.ThrowsException<Bag.EmptyBagException>( () => bag.MostFrequent() );
        }

        [TestMethod]
        public void TestBag_NegativeParam()
        {
            Assert.ThrowsException<Bag.NegativeSizeException>( () => new Bag(-2) );
        }
    }
}


