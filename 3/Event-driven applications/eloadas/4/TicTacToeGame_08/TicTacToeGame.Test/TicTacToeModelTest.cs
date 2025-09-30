using ELTE.TicTacToeGame.Persistence;
using ELTE.TicTacToeGame.Model;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System;
using System.Linq;

namespace ELTE.TicTacToeGame.Test
{
    [TestClass]
    public class TicTacToeModelTest // egységteszt osztály
    {
        private Mock<IPersistence> _mock = null!; // az adatelérés mock-ja
        private TicTacToeModel _model = null!;

        [TestInitialize]
        public void Initialize() // teszt inicializálása
        {
            _mock = new Mock<IPersistence>();
            _mock.Setup(mock => mock.Load(It.IsAny<String>())).Returns(() => Enumerable.Repeat(Player.NoPlayer, 9).ToArray());
            // a mock a Load műveletben bármilyen paraméterre egy üres táblának a tömbjét fogja visszaadni
            // a Save műveletet nem kell konfigurálnunk

            _model = new TicTacToeModel(_mock.Object); // példányosítjuk a modellt a mock objektummal
        }

        [TestMethod]
        public void TicTacToeConstructorTest() // egységteszt művelet
        {
            _model.NewGame();
            Assert.AreEqual(3, _model.TableSize);
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                    Assert.AreEqual(Player.NoPlayer, _model[i, j]); // valamennyi mező üres
        }

        [TestMethod]
        public void TicTacToeStepGameTest()
        {
            _model.NewGame();
            _model.StepGame(1, 1);

            Assert.AreEqual(Player.PlayerX, _model[1, 1]); // átváltott-e az érték X-re

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    if (i != 1 || j != 1)
                        Assert.AreEqual(Player.NoPlayer, _model[i, j]); // valamennyi további mező üres
                }

            _model.StepGame(0, 1);

            Assert.AreEqual(Player.PlayerO, _model[0, 1]); // átváltott-e az érték O-ra

            try
            {
                _model.StepGame(0, 1); // ha ugyanoda lépünk, kivételnek kell kiváltódnia
                Assert.Fail(); // ha nem váltódik ki kivétel, akkor hibás a működés
            }
            catch (InvalidOperationException) { }

            Assert.AreEqual(Player.PlayerO, _model[0, 1]); // továbbá nem szabad, hogy az érték megváltozzon
        }

        [TestMethod]
        public void TicTacToeStepNumberTest()
        {
            _model.NewGame();
            Assert.AreEqual(_model.StepNumber, 0);

            Int32 k = 0;
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 2; j++)
                {
                    _model.StepGame(i, j);
                    k++;
                    Assert.AreEqual(k, _model.StepNumber); // lépésszám megfelelő-e
                }
        }
        
        [TestMethod]
        [DataRow(0, 0)]
        [DataRow(0, 1)]
        [DataRow(1, 1)]
        [DataRow(2, 0)]
        [DataRow(2, 2)]
        public void TicTacToeIndexerValidTest(int x, int y)
        {
            _model.NewGame();
            Assert.AreEqual(Player.NoPlayer, _model[x, y]);
            _model.StepGame(x, y);
            Assert.AreEqual(Player.PlayerX, _model[x, y]);
        }

        [TestMethod]
        [DataRow(-1, 0)]
        [DataRow(3, 1)]
        [DataRow(1, -1)]
        [DataRow(2, 3)]
        [ExpectedException(typeof(ArgumentException), "Invalid position.")]
        public void TicTacToeIndexerInvalidTest(int x, int y)
        {
            _model.NewGame();
            Player value = _model[x, y];
        }

        [TestMethod]
        public void TicTacToeGameWonTest()
        {
			bool eventRaised = false;
	        _model.GameWon += delegate (object? sender, GameWonEventArgs e)
	        {
		        eventRaised = true;
		        Assert.IsTrue(e.Player == Player.PlayerX); // a megfelelő játékos győzött-e
	        };

	        _model.NewGame();
	        _model.StepGame(0, 0);
	        _model.StepGame(0, 1);
	        _model.StepGame(1, 0);
	        _model.StepGame(1, 1);
	        _model.StepGame(2, 0); // hagyjuk az X játékost nyerni

	        Assert.IsTrue(eventRaised); // kiváltottuk-e az eseményt
		}

        [TestMethod]
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
                    Assert.AreEqual(Player.NoPlayer, _model[i, j]); // ellenőrizzük, valamennyi mező üres
                    stepNumber += (_model[i, j] != Player.NoPlayer) ? 1 : 0;
                }

            // ellenőrizzük a lépésszámot, és a következ ő játékost
            Assert.AreEqual(stepNumber, _model.StepNumber);
            Assert.AreEqual(stepNumber % 2 == 0 ? Player.PlayerX : Player.PlayerO, _model.CurrentPlayer);

            // ellenőrizzük, hogy meghívták-e a Load műveletet a megadott paraméterrel
            _mock.Verify(dataAccess => dataAccess.Load(String.Empty), Times.Once());
        }

        [TestMethod]
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

            // ellenőrizzük, hogy a mentés után nem változott a játékállapot
            Assert.AreEqual(currentPlayer, _model.CurrentPlayer);
            Assert.AreEqual(stepNumber, _model.StepNumber);

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    Assert.AreEqual(values[i * 3 + j], _model[i, j]);
                }

            // ellenőrizzük, hogy meghívták-e a Save műveletet
            _mock.Verify(mock => mock.Save(String.Empty, It.IsAny<Player[]>()), Times.Once());
        }
    }
}
