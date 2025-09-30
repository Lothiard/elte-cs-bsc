using ELTE.TicTacToeGame.Persistence;
using ELTE.TicTacToeGame.Model;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace ELTE.TicTacToeGame.Test
{
    [TestClass]
    public class TicTacToeModelTest // egységteszt osztály
    {
        private TicTacToeModel _model = null!;

        [TestInitialize]
        public void Initialize() // teszt inicializálása
        {
            _model = new TicTacToeModel(new TextFilePersistence()); // példányosítjuk a modellt
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
            _model.GameWon += delegate(object? sender, GameWonEventArgs e)
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
    }
}
