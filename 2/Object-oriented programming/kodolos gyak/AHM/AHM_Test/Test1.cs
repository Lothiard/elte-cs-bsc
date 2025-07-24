using AHM;

namespace AHM_Test {
    [TestClass]
    public sealed class Test1 {
        [TestMethod]
        public void InitTest () {
            AHM.AHM ahm = new(3);
            ahm[1, 1] = 1;
            ahm[2, 1] = 2; ahm[2, 2] = 3;
            ahm[3, 1] = 4; ahm[3, 2] = 5; ahm[3, 3] = 6;

            Assert.AreEqual(2, ahm[2, 1]);
            Assert.AreEqual(5, ahm[3, 2]);

            Assert.ThrowsException<ArgumentOutOfRangeException>(() => {
                AHM.AHM a = new AHM.AHM(-1);
            });
        }

        [TestMethod]
        public void AddTest () {
            AHM.AHM a = new(3);
            a[1, 1] = 1;
            a[2, 1] = 2; a[2, 2] = 3;
            a[3, 1] = 4; a[3, 2] = 5; a[3, 3] = 6;

            AHM.AHM b = new(3);
            b[1, 1] = 1;
            b[2, 1] = 2; b[2, 2] = 3;
            b[3, 1] = 4; b[3, 2] = 5; b[3, 3] = 6;

            AHM.AHM c = a + b;

            Assert.AreEqual(2, c[1, 1]);
            Assert.AreEqual(4, c[2, 1]);
            Assert.AreEqual(6, c[2, 2]);
            Assert.AreEqual(8, c[3, 1]);
            Assert.AreEqual(10, c[3, 2]);
            Assert.AreEqual(12, c[3, 3]);
        }

        [TestMethod]
        public void MulTest() {
            AHM.AHM a = new(3);
            a[1, 1] = 1;
            a[2, 1] = 2; a[2, 2] = 3;
            a[3, 1] = 4; a[3, 2] = 5; a[3, 3] = 6;

            AHM.AHM b = new(3);
            b[1, 1] = 1;
            b[2, 1] = 0; b[2, 2] = 1;
            b[3, 1] = 0; b[3, 2] = 0; b[3, 3] = 1;

            AHM.AHM c = a + b;

            Assert.AreEqual(1, c[1, 1]);
            Assert.AreEqual(2, c[2, 1]);
            Assert.AreEqual(3, c[2, 2]);
            Assert.AreEqual(4, c[3, 1]);
            Assert.AreEqual(5, c[3, 2]);
            Assert.AreEqual(6, c[3, 3]);

            AHM.AHM d = b * a;
            Assert.AreEqual(1, d[1, 1]);
            Assert.AreEqual(2, d[2, 1]);
            Assert.AreEqual(3, d[2, 2]);
            Assert.AreEqual(4, d[3, 1]);
            Assert.AreEqual(5, d[3, 2]);
            Assert.AreEqual(6, d[3, 3]);
        }
    }
}
