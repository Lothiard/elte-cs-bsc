using System;
using System.Linq;
using ELTE.TicTacToeGame.Model;
using ELTE.TicTacToeGame.Persistence;
using Moq;
using NUnit.Framework;

namespace ELTE.TicTacToeGame.Test.NUnit
{
    [TestFixture]
    public class TicTacToeModelTest
    {
        private Mock<IPersistence> _mock = null!; // az adatel�r�s mock-ja
        private TicTacToeModel _model = null!;

        [SetUp]
        public void Initialize() // teszt inicializ�l�sa
        {
            _mock = new Mock<IPersistence>();
            _mock.Setup(mock => mock.Load(It.IsAny<String>())).Returns(() => Enumerable.Repeat(Player.NoPlayer, 9).ToArray());
            // a mock a Load m�veletben b�rmilyen param�terre egy �res t�bl�nak a t�mbj�t fogja visszaadni
            // a Save m�veletet nem kell konfigur�lnunk

            _model = new TicTacToeModel(_mock.Object); // p�ld�nyos�tjuk a modellt a mock objektummal
        }

        [Test]
        public void TicTacToeConstructorTest() // egys�gteszt m�velet
        {
            _model.NewGame();
            Assert.AreEqual(3, _model.TableSize);
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                    Assert.AreEqual(Player.NoPlayer, _model[i, j]); // valamennyi mez� �res
        }

        [Test]
        public void TicTacToeStepGameTest()
        {
            _model.NewGame();
            _model.StepGame(1, 1);

            Assert.AreEqual(Player.PlayerX, _model[1, 1]); // �tv�ltott-e az �rt�k X-re

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    if (i != 1 || j != 1)
                        Assert.AreEqual(Player.NoPlayer, _model[i, j]); // valamennyi tov�bbi mez� �res
                }

            _model.StepGame(0, 1);

            Assert.AreEqual(Player.PlayerO, _model[0, 1]); // �tv�ltott-e az �rt�k O-ra

            try
            {
                _model.StepGame(0, 1); // ha ugyanoda l�p�nk, kiv�telnek kell kiv�lt�dnia
                Assert.Fail(); // ha nem v�lt�dik ki kiv�tel, akkor hib�s a m�k�d�s
            }
            catch (InvalidOperationException) { }

            Assert.AreEqual(Player.PlayerO, _model[0, 1]); // tov�bb� nem szabad, hogy az �rt�k megv�ltozzon
        }

        [Test]
        public void TicTacToeStepNumberTest()
        {
            _model.NewGame();
            Assert.AreEqual(0, _model.StepNumber);

            Int32 k = 0;
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 2; j++)
                {
                    _model.StepGame(i, j);
                    k++;
                    Assert.AreEqual(k, _model.StepNumber); // l�p�ssz�m megfelel�-e
                }
        }

        [Test]
        [TestCase(0, 0)]
        [TestCase(0, 1)]
        [TestCase(1, 1)]
        [TestCase(2, 0)]
        [TestCase(2, 2)]
        public void TicTacToeIndexerValidTest(int x, int y)
        {
            _model.NewGame();
            Assert.AreEqual(Player.NoPlayer, _model[x, y]);
            _model.StepGame(x, y);
            Assert.AreEqual(Player.PlayerX, _model[x, y]);
        }

        [Test]
        [TestCase(-1, 0)]
        [TestCase(3, 1)]
        [TestCase(1, -1)]
        [TestCase(2, 3)]
        public void TicTacToeIndexerInvalidTest(int x, int y)
        {
            _model.NewGame();

            Assert.Throws<ArgumentException>(() =>
            {
                Player value = _model[x, y];
            });
        }

        [Test]
        public void TicTacToeGameWonTest()
        {
            bool eventRaised = false;
            _model.GameWon += delegate (object? sender, GameWonEventArgs e)
            {
                eventRaised = true;
                Assert.AreEqual(Player.PlayerX, e.Player); // a megfelel� j�t�kos gy�z�tt-e
            };

            _model.NewGame();
            _model.StepGame(0, 0);
            _model.StepGame(0, 1);
            _model.StepGame(1, 0);
            _model.StepGame(1, 1);
            _model.StepGame(2, 0); // hagyjuk az X j�t�kost nyerni

            Assert.IsTrue(eventRaised); // kiv�ltottuk-e az esem�nyt
        }

        [Test]
        public void TicTacToeGameLoadTest()
        {
            // kezd�nk egy �j j�t�kot �s v�grehajtunk p�r l�p�st
            _model.NewGame();
            _model.StepGame(0, 0);
            _model.StepGame(0, 1);
            _model.StepGame(1, 0);
            _model.StepGame(1, 1);

            // majd bet�lt�nk egy j�t�kot
            _model.LoadGame(String.Empty);

            Int32 stepNumber = 0;
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    Assert.AreEqual(Player.NoPlayer, _model[i, j]); // ellen�rizz�k, valamennyi mez� �res
                    stepNumber += (_model[i, j] != Player.NoPlayer) ? 1 : 0;
                }

            // ellen�rizz�k a l�p�ssz�mot, �s a k�vetkez � j�t�kost
            Assert.AreEqual(stepNumber, _model.StepNumber);
            Assert.AreEqual(stepNumber % 2 == 0 ? Player.PlayerX : Player.PlayerO, _model.CurrentPlayer);

            // ellen�rizz�k, hogy megh�vt�k-e a Load m�veletet a megadott param�terrel
            _mock.Verify(dataAccess => dataAccess.Load(String.Empty), Times.Once());
        }

        [Test]
        public void TicTacToeGameSaveTest()
        {
            // kimentj�k a j�t�k�llapotot
            Player currentPlayer = _model.CurrentPlayer;
            Int32 stepNumber = _model.StepNumber;
            Player[] values = new Player[9];

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    values[i * 3 + j] = _model[i, j];
                }

            // v�grehajtjuk a ment�st
            _model.SaveGame(String.Empty);

            // ellen�rizz�k, hogy a ment�s ut�n nem v�ltozott a j�t�k�llapot
            Assert.AreEqual(currentPlayer, _model.CurrentPlayer);
            Assert.AreEqual(stepNumber, _model.StepNumber);

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    Assert.AreEqual(values[i * 3 + j], _model[i, j]);
                }

            // ellen�rizz�k, hogy megh�vt�k-e a Save m�veletet
            _mock.Verify(mock => mock.Save(String.Empty, It.IsAny<Player[]>()), Times.Once());
        }
    }
}