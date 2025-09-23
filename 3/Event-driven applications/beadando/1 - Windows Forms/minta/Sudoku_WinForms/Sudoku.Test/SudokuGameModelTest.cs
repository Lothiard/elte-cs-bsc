using System;
using System.Threading.Tasks;
using ELTE.Sudoku.Model;
using ELTE.Sudoku.Persistence;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace ELTE.Sudoku.Test
{
    [TestClass]
    public class SudokuGameModelTest
    {
        private SudokuGameModel _model = null!; // a tesztelendő modell
        private SudokuTable _mockedTable = null!; // mockolt játéktábla
        private Mock<ISudokuDataAccess> _mock = null!; // az adatelérés mock-ja
        private MockTimer _mockedTimer = new MockTimer(); // az időzítő mock-ja

        [TestInitialize]
        public void Initialize()
        {
            _mockedTable = new SudokuTable();
            _mockedTable.SetValue(1, 2, 3, false);
            _mockedTable.SetValue(4, 5, 6, true);
            _mockedTable.SetValue(7, 8, 9, false);
            // előre definiálunk egy játéktáblát a perzisztencia mockolt teszteléséhez

            _mock = new Mock<ISudokuDataAccess>();
            _mock.Setup(mock => mock.LoadAsync(It.IsAny<String>()))
                .Returns(() => Task.FromResult(_mockedTable));
            // a mock a LoadAsync műveletben bármilyen paraméterre az előre beállított játéktáblát fogja visszaadni

            _model = new SudokuGameModel(_mock.Object, _mockedTimer);
            // példányosítjuk a modellt a mock objektummal

            _model.GameAdvanced += new EventHandler<SudokuEventArgs>(Model_GameAdvanced);
            _model.GameOver += new EventHandler<SudokuEventArgs>(Model_GameOver);
        }


        [TestMethod]
        public void SudokuGameModelNewGameMediumTest()
        {
            _model.NewGame();

            Assert.AreEqual(0, _model.GameStepCount); // még nem léptünk
            Assert.AreEqual(GameDifficulty.Medium, _model.GameDifficulty); // a nehézség beállítódott
            Assert.AreEqual(1200, _model.GameTime); // alapból ennyi időnk van

            Int32 emptyFields = 0;
            for (Int32 i = 0; i < 9; i++)
            for (Int32 j = 0; j < 9; j++)
                if (_model.IsEmpty(i, j))
                    emptyFields++;

            Assert.AreEqual(69, emptyFields); // szabad mezők száma is megfelelő
        }

        [TestMethod]
        public void SudokuGameModelNewGameEasyTest()
        {
            _model.GameDifficulty = GameDifficulty.Easy;
            _model.NewGame();

            Assert.AreEqual(0, _model.GameStepCount); // még nem léptünk
            Assert.AreEqual(GameDifficulty.Easy, _model.GameDifficulty); // a nehézség beállítódott
            Assert.AreEqual(3600, _model.GameTime); // alapból ennyi időnk van

            Int32 emptyFields = 0;
            for (Int32 i = 0; i < 9; i++)
            for (Int32 j = 0; j < 9; j++)
                if (_model.IsEmpty(i, j))
                    emptyFields++;

            Assert.AreEqual(75, emptyFields); // szabad mezők száma is megfelelő
        }

        [TestMethod]
        public void SudokuGameModelNewGameHardTest()
        {
            _model.GameDifficulty = GameDifficulty.Hard;
            _model.NewGame();

            Assert.AreEqual(0, _model.GameStepCount); // még nem léptünk
            Assert.AreEqual(GameDifficulty.Hard, _model.GameDifficulty); // a nehézség beállítódott
            Assert.AreEqual(600, _model.GameTime); // alapból ennyi időnk van

            Int32 emptyFields = 0;
            for (Int32 i = 0; i < 9; i++)
            for (Int32 j = 0; j < 9; j++)
                if (_model.IsEmpty(i, j))
                    emptyFields++;

            Assert.AreEqual(63, emptyFields); // szabad mezők száma is megfelelő
        }

        [TestMethod]
        public void SudokuGameModelStepTest()
        {
            Assert.AreEqual(0, _model.GameStepCount); // még nem léptünk

            _model.Step(0, 0);

            Assert.AreEqual(0, _model.GameStepCount); // mivel a játék áll, nem szabad, hogy lépjünk

            _model.NewGame();

            Random random = new Random();
            Int32 x = 0, y = 0;
            do
            {
                x = random.Next(0, 9);
                y = random.Next(0, 9);
            } while (!_model.IsEmpty(x, y));

            _model.Step(x, y);

            Assert.AreEqual(1, _model.GameStepCount); // most már léptünk
            Assert.AreNotEqual(0, _model[x, y]); // kitöltöttnek kell lennie
            Assert.AreEqual(1200, _model.GameTime); // az idő viszont nem változott

            Int32 currentValue = 1;
            for (Int32 i = 2; i < 1E6; i++) // egymillió lépés végrehajtása
            {
                _model.Step(x, y);
                Assert.IsTrue(currentValue < _model[x, y] || _model[x, y] == 0);
                // az értékeknek ciklikusan kell váltakozniuk
                Assert.AreEqual(i, _model.GameStepCount); // akárhányszor léphetünk a mezőre

                currentValue = _model[x, y];
            }
        }

        [TestMethod]
        public void SudokuGameModelAdvanceTimeTest()
        {
            _model.NewGame();

            Int32 time = _model.GameTime;
            while (!_model.IsGameOver)
            {
                _mockedTimer.RaiseElapsed();

                time--;

                Assert.AreEqual(time, _model.GameTime); // az idő csökkent
                Assert.AreEqual(0, _model.GameStepCount); // de a lépésszám nem változott
            }

            Assert.AreEqual(0, _model.GameTime); // a játék végére elfogyott a játékidő
        }

        [TestMethod]
        public async Task SudokuGameModelLoadTest()
        {
            // kezdünk egy új játékot
            _model.NewGame();

            // majd betöltünk egy játékot
            await _model.LoadGameAsync(String.Empty);

            for (Int32 i = 0; i < 3; i++)
            for (Int32 j = 0; j < 3; j++)
            {
                Assert.AreEqual(_mockedTable.GetValue(i, j), _model.GetValue(i, j));
                // ellenőrizzük, valamennyi mező értéke megfelelő-e
                Assert.AreEqual(_mockedTable.IsLocked(i, j), _model.IsLocked(i, j));
                // ellenőrizzük, valamennyi mező zároltsága megfelelő-e
            }

            // a lépésszám 0-ra áll vissza
            Assert.AreEqual(0, _model.GameStepCount);

            // ellenőrizzük, hogy meghívták-e a Load műveletet a megadott paraméterrel
            _mock.Verify(dataAccess => dataAccess.LoadAsync(String.Empty), Times.Once());
        }

        private void Model_GameAdvanced(Object? sender, SudokuEventArgs e)
        {
            Assert.IsTrue(_model.GameTime >= 0); // a játékidő nem lehet negatív
            Assert.AreEqual(_model.GameTime == 0, _model.IsGameOver);
            // a tesztben a játéknak csak akkor lehet vége, ha lejárt az idő

            Assert.AreEqual(e.GameStepCount, _model.GameStepCount); // a két értéknek egyeznie kell
            Assert.AreEqual(e.GameTime, _model.GameTime); // a két értéknek egyeznie kell
            Assert.IsFalse(e.IsWon); // még nem nyerték meg a játékot
        }

        private void Model_GameOver(Object? sender, SudokuEventArgs e)
        {
            Assert.IsTrue(_model.IsGameOver); // biztosan vége van a játéknak
            Assert.AreEqual(0, e.GameTime); // a tesztben csak akkor váltódhat ki, ha elfogy az idő
            Assert.IsFalse(e.IsWon);
        }
    }
}
