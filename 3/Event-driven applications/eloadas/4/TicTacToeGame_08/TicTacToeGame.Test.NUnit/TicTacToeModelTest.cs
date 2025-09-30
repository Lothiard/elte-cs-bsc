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
        private Mock<IPersistence> _mock = null!; // az adatelérés mock-ja
        private TicTacToeModel _model = null!;

        [SetUp]
        public void Initialize() // teszt inicializálása
        {
            _mock = new Mock<IPersistence>();
            _mock.Setup(mock => mock.Load(It.IsAny<String>())).Returns(() => Enumerable.Repeat(Player.NoPlayer, 9).ToArray());
            // a mock a Load mûveletben bármilyen paraméterre egy üres táblának a tömbjét fogja visszaadni
            // a Save mûveletet nem kell konfigurálnunk

            _model = new TicTacToeModel(_mock.Object); // példányosítjuk a modellt a mock objektummal
        }

        [Test]
        public void TicTacToeConstructorTest() // egységteszt mûvelet
        {
            _model.NewGame();
            Assert.AreEqual(3, _model.TableSize);
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                    Assert.AreEqual(Player.NoPlayer, _model[i, j]); // valamennyi mezõ üres
        }

        [Test]
        public void TicTacToeStepGameTest()
        {
            _model.NewGame();
            _model.StepGame(1, 1);

            Assert.AreEqual(Player.PlayerX, _model[1, 1]); // átváltott-e az érték X-re

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    if (i != 1 || j != 1)
                        Assert.AreEqual(Player.NoPlayer, _model[i, j]); // valamennyi további mezõ üres
                }

            _model.StepGame(0, 1);

            Assert.AreEqual(Player.PlayerO, _model[0, 1]); // átváltott-e az érték O-ra

            try
            {
                _model.StepGame(0, 1); // ha ugyanoda lépünk, kivételnek kell kiváltódnia
                Assert.Fail(); // ha nem váltódik ki kivétel, akkor hibás a mûködés
            }
            catch (InvalidOperationException) { }

            Assert.AreEqual(Player.PlayerO, _model[0, 1]); // továbbá nem szabad, hogy az érték megváltozzon
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
                    Assert.AreEqual(k, _model.StepNumber); // lépésszám megfelelõ-e
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
                Assert.AreEqual(Player.PlayerX, e.Player); // a megfelelõ játékos gyõzött-e
            };

            _model.NewGame();
            _model.StepGame(0, 0);
            _model.StepGame(0, 1);
            _model.StepGame(1, 0);
            _model.StepGame(1, 1);
            _model.StepGame(2, 0); // hagyjuk az X játékost nyerni

            Assert.IsTrue(eventRaised); // kiváltottuk-e az eseményt
        }

        [Test]
        public void TicTacToeGameLoadTest()
        {
            // kezdünk egy új játékot és végrehajtunk pár lépést
            _model.NewGame();
            _model.StepGame(0, 0);
            _model.StepGame(0, 1);
            _model.StepGame(1, 0);
            _model.StepGame(1, 1);

            // majd betöltünk egy játékot
            _model.LoadGame(String.Empty);

            Int32 stepNumber = 0;
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    Assert.AreEqual(Player.NoPlayer, _model[i, j]); // ellenõrizzük, valamennyi mezõ üres
                    stepNumber += (_model[i, j] != Player.NoPlayer) ? 1 : 0;
                }

            // ellenõrizzük a lépésszámot, és a következ õ játékost
            Assert.AreEqual(stepNumber, _model.StepNumber);
            Assert.AreEqual(stepNumber % 2 == 0 ? Player.PlayerX : Player.PlayerO, _model.CurrentPlayer);

            // ellenõrizzük, hogy meghívták-e a Load mûveletet a megadott paraméterrel
            _mock.Verify(dataAccess => dataAccess.Load(String.Empty), Times.Once());
        }

        [Test]
        public void TicTacToeGameSaveTest()
        {
            // kimentjük a játékállapotot
            Player currentPlayer = _model.CurrentPlayer;
            Int32 stepNumber = _model.StepNumber;
            Player[] values = new Player[9];

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    values[i * 3 + j] = _model[i, j];
                }

            // végrehajtjuk a mentést
            _model.SaveGame(String.Empty);

            // ellenõrizzük, hogy a mentés után nem változott a játékállapot
            Assert.AreEqual(currentPlayer, _model.CurrentPlayer);
            Assert.AreEqual(stepNumber, _model.StepNumber);

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    Assert.AreEqual(values[i * 3 + j], _model[i, j]);
                }

            // ellenõrizzük, hogy meghívták-e a Save mûveletet
            _mock.Verify(mock => mock.Save(String.Empty, It.IsAny<Player[]>()), Times.Once());
        }
    }
}