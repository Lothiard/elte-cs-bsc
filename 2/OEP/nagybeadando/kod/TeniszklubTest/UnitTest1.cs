using Microsoft.VisualStudio.TestTools.UnitTesting;
using Nagybead;
using System.Linq;

namespace TeniszklubTest {
    [TestClass]
    public class UnitTest1 {
        private Teniszklub? klub;

        [TestInitialize]
        public void Setup() {
            klub = Program.InitTestClub();
        }

        [TestMethod]
        public void Test_UjPalya() {
            Assert.AreEqual(4, klub!.Palyak.Count);
            foreach(Palya p in klub!.Palyak) {
                Assert.IsTrue(p.Sorszam > 0);
                Assert.IsTrue(p.PalyaTipus is Fuves or Salak or Muanyag);
            }
        }

        [TestMethod]
        public void Test_UjKlubtag() {
            Assert.AreEqual(3, klub!.Klubtagok.Count);
            Assert.AreEqual("Anna", klub!.Klubtagok[0].Nev);
        }

        [TestMethod]
        public void Test_KlubtagFoglalas() {
            Klubtag? anna = null;
            foreach (Klubtag tag in klub!.Klubtagok) {
                if (tag.Nev == "Anna") {
                    anna = tag;
                    break;
                }
            } 
            Assert.AreEqual(1, anna!.Foglalasok.Count);
            Assert.AreEqual(20240520, anna!.Foglalasok[0].Datum);
        }

        [TestMethod]
        public void Test_PalyaElerheto() {
            Palya palya = klub!.Palyak[0];
            Assert.IsFalse(palya.Elerheto(20240520, 10)); // mar lefoglalta anna 
            Assert.IsTrue(palya.Elerheto(20240520, 11)); // ezt nem 
        }

        [TestMethod]
        public void Test_SzabadPalyaKereses() {
            List<Palya> szabad = klub!.KeressSzabadPalyakat(20240520, 10, Fuves.Instance);
            Assert.AreEqual(1, szabad.Count); 
        }

        [TestMethod]
        public void Test_SzamolDij() {
            Klubtag anna = klub!.Klubtagok[0]; // felnott
            Klubtag bela = klub!.Klubtagok[1]; // diak
            Palya palya = klub!.Palyak[0]; // fuves

            int teljesAr = palya.PalyaTipus.PalyaAr();
            int annaAr = palya.SzamolDij(anna); // 5000
            int belaAr = palya.SzamolDij(bela); // 5000 * 0.8 = 4000

            Assert.AreEqual(5000, annaAr);
            Assert.AreEqual(4000, belaAr);
        }

        [TestMethod]
        public void Test_NapiKoltseg() {
            Klubtag bela = klub!.Klubtagok[1];
            int ar = klub!.NapiKoltseg(bela, 20240520);
            Assert.AreEqual(2880, ar); // 3000 * 1.2 (fedett) * 0.8 (diak)
        }

        [TestMethod]
        public void Test_BevetelIdoszakra() {
            int bevetel = klub!.BevetelIdoszakra(20240519, 20240521);
            Assert.AreEqual(9480, bevetel); 
            // 5000 (Anna) + 2880 (Bela) + 1600 (Cecil)
            // anna: 5000 * 1 * 1 = 5000
            // bela: 3000 * 0.8 * 1.2 = 2880
            // cecil: 2000 * 0.8 * 1 = 1600
        }

        [TestMethod]
        public void Test_FoglalasLekerdezes() {
            Klubtag anna = klub!.Klubtagok[0];
            List<(int, int)> result = klub!.FoglalasLekerdezes(anna, 20240520);
            Assert.AreEqual(1, result.Count);
        }

        [TestMethod]
        public void Test_Visszavon() {
            Klubtag anna = klub!.Klubtagok[0];
            Foglalas foglalas = anna.Foglalasok[0];
            Palya palya = foglalas.Palya;

            anna.Visszavon(foglalas);

            Assert.IsFalse(anna.Foglalasok.Contains(foglalas));
            Assert.IsFalse(palya.Foglalasok.Contains(foglalas));
        }

        [TestMethod]
        [ExpectedException(typeof(Exception))]
        public void Test_Visszavon_Exception() {
            Klubtag anna = klub!.Klubtagok[0];
            Palya palya = klub!.Palyak[0];
            Foglalas f = new Foglalas(anna, palya, 20250101, 12);

            anna.Visszavon(f);
        }

        [TestMethod]
        public void Test_TorolPalya() {
            int sorszam = 3;
            int beforeCount = klub!.Palyak.Count;

            klub!.TorolPalya(sorszam);

            Assert.AreEqual(beforeCount - 1, klub.Palyak.Count);
            Assert.IsFalse(klub.Palyak.Any(p => p.Sorszam == sorszam));
        }

        [TestMethod]
        [ExpectedException(typeof(Exception))]
        public void Test_TorolPalya_Exception() {
            int sorszam = 999; // nem letezo

            klub!.TorolPalya(sorszam);
        }
    }
}
