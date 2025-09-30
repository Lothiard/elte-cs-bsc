using System;
using System.Linq;
using ELTE.TicTacToeGame.Model;
using ELTE.TicTacToeGame.Persistence;
using Moq;
using Xunit;

namespace ELTE.TicTacToeGame.Test.xUnit
{
    public class TicTacToeModelTest
    {
        private Mock<IPersistence> _mock = null!; // az adatelérés mock-ja
        private TicTacToeModel _model = null!;
        
        public TicTacToeModelTest() // teszt inicializálása
        {
            _mock = new Mock<IPersistence>();
            _mock.Setup(mock => mock.Load(It.IsAny<String>())).Returns(() => Enumerable.Repeat(Player.NoPlayer, 9).ToArray());
            // a mock a Load mûveletben bármilyen paraméterre egy üres táblának a tömbjét fogja visszaadni
            // a Save mûveletet nem kell konfigurálnunk

            _model = new TicTacToeModel(_mock.Object); // példányosítjuk a modellt a mock objektummal
        }

        [Fact]
        public void TicTacToeConstructorTest() // egységteszt mûvelet
        {
            _model.NewGame();
            Assert.Equal(3, _model.TableSize);
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                    Assert.Equal(Player.NoPlayer, _model[i, j]); // valamennyi mezõ üres
        }

        [Fact]
        public void TicTacToeStepGameTest()
        {
            _model.NewGame();
            _model.StepGame(1, 1);

            Assert.Equal(Player.PlayerX, _model[1, 1]); // átváltott-e az érték X-re

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    if (i != 1 || j != 1)
                        Assert.Equal(Player.NoPlayer, _model[i, j]); // valamennyi további mezõ üres
                }

            _model.StepGame(0, 1);

            Assert.Equal(Player.PlayerO, _model[0, 1]); // átváltott-e az érték O-ra

            Assert.Throws<InvalidOperationException>(() =>
            {
                _model.StepGame(0, 1);
            }); // xUnitban nincs Assert.Fail()

            Assert.Equal(Player.PlayerO, _model[0, 1]); // továbbá nem szabad, hogy az érték megváltozzon
        }

        [Fact]
        public void TicTacToeStepNumberTest()
        {
            _model.NewGame();
            Assert.Equal(0, _model.StepNumber);

            Int32 k = 0;
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 2; j++)
                {
                    _model.StepGame(i, j);
                    k++;
                    Assert.Equal(k, _model.StepNumber); // lépésszám megfelelõ-e
                }
        }

        [Theory]
        [InlineData(0, 0)]
        [InlineData(0, 1)]
        [InlineData(1, 1)]
        [InlineData(2, 0)]
        [InlineData(2, 2)]
        public void TicTacToeIndexerValidTest(int x, int y)
        {
            _model.NewGame();
            Assert.Equal(Player.NoPlayer, _model[x, y]);
            _model.StepGame(x, y);
            Assert.Equal(Player.PlayerX, _model[x, y]);
        }

        [Theory]
        [InlineData(-1, 0)]
        [InlineData(3, 1)]
        [InlineData(1, -1)]
        [InlineData(2, 3)]
        public void TicTacToeIndexerInvalidTest(int x, int y)
        {
            _model.NewGame();

            Assert.Throws<ArgumentException>(() =>
            {
                Player value = _model[x, y];
            });
        }

        [Fact]
        public void TicTacToeGameWonTest()
        {
            bool eventRaised = false;
            _model.GameWon += delegate (object? sender, GameWonEventArgs e)
            {
                eventRaised = true;
                Assert.True(e.Player == Player.PlayerX); // a megfelelõ játékos gyõzött-e
            };

            _model.NewGame();
            _model.StepGame(0, 0);
            _model.StepGame(0, 1);
            _model.StepGame(1, 0);
            _model.StepGame(1, 1);
            _model.StepGame(2, 0); // hagyjuk az X játékost nyerni

            Assert.True(eventRaised); // kiváltottuk-e az eseményt
        }

        [Fact]
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
                    Assert.Equal(Player.NoPlayer, _model[i, j]); // ellenõrizzük, valamennyi mezõ üres
                    stepNumber += (_model[i, j] != Player.NoPlayer) ? 1 : 0;
                }

            // ellenõrizzük a lépésszámot, és a következ õ játékost
            Assert.Equal(stepNumber, _model.StepNumber);
            Assert.Equal(stepNumber % 2 == 0 ? Player.PlayerX : Player.PlayerO, _model.CurrentPlayer);

            // ellenõrizzük, hogy meghívták-e a Load mûveletet a megadott paraméterrel
            _mock.Verify(dataAccess => dataAccess.Load(String.Empty), Times.Once());
        }

        [Fact]
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
            Assert.Equal(currentPlayer, _model.CurrentPlayer);
            Assert.Equal(stepNumber, _model.StepNumber);

            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    Assert.Equal(values[i * 3 + j], _model[i, j]);
                }

            // ellenõrizzük, hogy meghívták-e a Save mûveletet
            _mock.Verify(mock => mock.Save(String.Empty, It.IsAny<Player[]>()), Times.Once());
        }
    }
}
