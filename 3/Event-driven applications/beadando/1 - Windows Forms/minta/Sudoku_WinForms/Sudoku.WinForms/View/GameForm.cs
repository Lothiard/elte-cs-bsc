using System;
using System.Drawing;
using System.Windows.Forms;
using ELTE.Sudoku.Model;
using ELTE.Sudoku.Persistence;

namespace ELTE.Sudoku.View
{
    /// <summary>
    /// Játékablak típusa.
    /// </summary>
    public partial class GameForm : Form
    {
        #region Fields

        private SudokuGameModel _model; // játékmodell
        private Button[,] _buttonGrid = null!; // gombrács

        #endregion

        #region Constructors

        /// <summary>
        /// Játékablak példányosítása.
        /// </summary>
        public GameForm()
        {
            InitializeComponent();

            // adatelérés példányosítása
            ISudokuDataAccess _dataAccess = new SudokuFileDataAccess();

            // modell létrehozása és az eseménykezelők társítása
            _model = new SudokuGameModel(_dataAccess, new SudokuTimerInheritance());
            _model.FieldChanged += new EventHandler<SudokuFieldEventArgs>(Game_FieldChanged);
            _model.GameAdvanced += new EventHandler<SudokuEventArgs>(Game_GameAdvanced);
            _model.GameOver += new EventHandler<SudokuEventArgs>(Game_GameOver);

            // játéktábla és menük inicializálása
            GenerateTable();
            SetupMenus();

            // új játék indítása
            _model.NewGame();
            SetupTable();
        }

        #endregion

        #region Game event handlers

        /// <summary>
        /// Játékmodell mező megváltozásának eseménykezelője.
        /// </summary>
        private void Game_FieldChanged(object? sender, SudokuFieldEventArgs e)
        {
            // mező frissítése
            if (_model.IsEmpty(e.X, e.Y))
                _buttonGrid[e.X, e.Y].Text = String.Empty;
            else
                _buttonGrid[e.X, e.Y].Text = _model[e.X, e.Y].ToString();
        }

        /// <summary>
        /// Játék előrehaladásának eseménykezelője.
        /// </summary>
        private void Game_GameAdvanced(Object? sender, SudokuEventArgs e)
        {
            if (InvokeRequired)
            {
                BeginInvoke(() => Game_GameAdvanced(sender, e));
                return;
            }

            _toolLabelGameTime.Text = TimeSpan.FromSeconds(e.GameTime).ToString("g");
            _toolLabelGameSteps.Text = e.GameStepCount.ToString();
            // játékidő frissítése
        }

        /// <summary>
        /// Játék végének eseménykezelője.
        /// </summary>
        private void Game_GameOver(Object? sender, SudokuEventArgs e)
        {
            foreach (Button button in _buttonGrid) // kikapcsoljuk a gombokat
                button.Enabled = false;

            _menuFileSaveGame.Enabled = false;

            if (e.IsWon) // győzelemtől függő üzenet megjelenítése
            {
                MessageBox.Show("Gratulálok, győztél!" + Environment.NewLine +
                                "Összesen " + e.GameStepCount + " lépést tettél meg és " +
                                TimeSpan.FromSeconds(e.GameTime).ToString("g") + " ideig játszottál.",
                    "Sudoku játék",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("Sajnálom, vesztettél, lejárt az idő!",
                    "Sudoku játék",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Asterisk);
            }
        }

        #endregion

        #region Grid event handlers

        /// <summary>
        /// Gombrács eseménykezelője.
        /// </summary>
        private void ButtonGrid_MouseClick(Object? sender, MouseEventArgs e)
        {
            if (sender is Button button)
            {

                // a TabIndex-ből megkapjuk a sort és oszlopot
                Int32 x = (button.TabIndex - 100) / _model.TableSize;
                Int32 y = (button.TabIndex - 100) % _model.TableSize;

                _model.Step(x, y); // lépés a játékban
            }
        }

        #endregion

        #region Menu event handlers

        /// <summary>
        /// Új játék eseménykezelője.
        /// </summary>
        private void MenuFileNewGame_Click(Object sender, EventArgs e)
        {
            _menuFileSaveGame.Enabled = true;

            _model.NewGame();
            SetupTable();
            SetupMenus();
        }

        /// <summary>
        /// Játék betöltésének eseménykezelője.
        /// </summary>
        private async void MenuFileLoadGame_Click(Object sender, EventArgs e)
        {
            Boolean restartTimer = !_model.IsGameOver;
            _model.PauseGame();

            if (_openFileDialog.ShowDialog() == DialogResult.OK) // ha kiválasztottunk egy fájlt
            {
                try
                {
                    // játék betöltése
                    await _model.LoadGameAsync(_openFileDialog.FileName);
                    _menuFileSaveGame.Enabled = true;
                }
                catch (SudokuDataException)
                {
                    MessageBox.Show(
                        "Játék betöltése sikertelen!" + Environment.NewLine +
                        "Hibás az elérési út, vagy a fájlformátum.", "Hiba!", MessageBoxButtons.OK,
                        MessageBoxIcon.Error);

                    _model.NewGame();
                    _menuFileSaveGame.Enabled = true;
                }

                SetupTable();
            }

            if (restartTimer)
                _model.ResumeGame();
        }

        /// <summary>
        /// Játék mentésének eseménykezelője.
        /// </summary>
        private async void MenuFileSaveGame_Click(Object sender, EventArgs e)
        {
            Boolean restartTimer = !_model.IsGameOver;
            _model.PauseGame();

            if (_saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    // játé mentése
                    await _model.SaveGameAsync(_saveFileDialog.FileName);
                }
                catch (SudokuDataException)
                {
                    MessageBox.Show(
                        "Játék mentése sikertelen!" + Environment.NewLine +
                        "Hibás az elérési út, vagy a könyvtár nem írható.", "Hiba!", MessageBoxButtons.OK,
                        MessageBoxIcon.Error);
                }
            }

            if (restartTimer)
                _model.ResumeGame();
        }

        /// <summary>
        /// Kilépés eseménykezelője.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MenuFileExit_Click(Object sender, EventArgs e)
        {
            Boolean restartTimer = !_model.IsGameOver;
            _model.PauseGame();

            // megkérdezzük, hogy biztos ki szeretne-e lépni
            if (MessageBox.Show("Biztosan ki szeretne lépni?", "Sudoku játék", MessageBoxButtons.YesNo,
                    MessageBoxIcon.Question) == DialogResult.Yes)
            {
                // ha igennel válaszol
                Close();
            }
            else
            {
                if (restartTimer)
                    _model.ResumeGame();
            }
        }

        private void MenuGameEasy_Click(Object sender, EventArgs e)
        {
            _model.GameDifficulty = GameDifficulty.Easy;
        }

        private void MenuGameMedium_Click(Object sender, EventArgs e)
        {
            _model.GameDifficulty = GameDifficulty.Medium;
        }

        private void MenuGameHard_Click(Object sender, EventArgs e)
        {
            _model.GameDifficulty = GameDifficulty.Hard;
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Új tábla létrehozása.
        /// </summary>
        private void GenerateTable()
        {
            _buttonGrid = new Button[_model.TableSize, _model.TableSize];
            for (Int32 i = 0; i < _model.TableSize; i++)
            for (Int32 j = 0; j < _model.TableSize; j++)
            {
                _buttonGrid[i, j] = new Button();
                _buttonGrid[i, j].Location = new Point(5 + 50 * j, 35 + 50 * i); // elhelyezkedés
                _buttonGrid[i, j].Size = new Size(50, 50); // méret
                _buttonGrid[i, j].Font = new Font(FontFamily.GenericSansSerif, 25, FontStyle.Bold); // betűtípus
                _buttonGrid[i, j].Enabled = false; // kikapcsolt állapot
                _buttonGrid[i, j].TabIndex = 100 + i * _model.TableSize + j; // a gomb számát a TabIndex-ben tároljuk
                _buttonGrid[i, j].FlatStyle = FlatStyle.Flat; // lapított stípus
                _buttonGrid[i, j].MouseClick += new MouseEventHandler(ButtonGrid_MouseClick);
                // közös eseménykezelő hozzárendelése minden gombhoz

                Controls.Add(_buttonGrid[i, j]);
                // felvesszük az ablakra a gombot
            }
        }

        /// <summary>
        /// Tábla beállítása.
        /// </summary>
        private void SetupTable()
        {
            for (Int32 i = 0; i < _buttonGrid.GetLength(0); i++)
            {
                for (Int32 j = 0; j < _buttonGrid.GetLength(1); j++)
                {
                    if (!_model.IsLocked(i, j)) // ha nincs zárolva a mező
                    {
                        _buttonGrid[i, j].Text = _model.IsEmpty(i, j)
                            ? String.Empty
                            : _model[i, j].ToString();
                        _buttonGrid[i, j].Enabled = true;
                        _buttonGrid[i, j].BackColor = Color.White;
                    }
                    else // ha zárolva van
                    {
                        _buttonGrid[i, j].Text = _model[i, j].ToString();
                        _buttonGrid[i, j].Enabled = false; // gomb kikapcsolása
                        _buttonGrid[i, j].BackColor = Color.Yellow;
                        // háttérszín sárga, ha zárolni kell a mezőt, különben fehér
                    }
                }
            }

            _toolLabelGameSteps.Text = _model.GameStepCount.ToString();
            _toolLabelGameTime.Text = TimeSpan.FromSeconds(_model.GameTime).ToString("g");
        }

        /// <summary>
        /// Menük beállítása.
        /// </summary>
        private void SetupMenus()
        {
            _menuGameEasy.Checked = (_model.GameDifficulty == GameDifficulty.Easy);
            _menuGameMedium.Checked = (_model.GameDifficulty == GameDifficulty.Medium);
            _menuGameHard.Checked = (_model.GameDifficulty == GameDifficulty.Hard);
        }

        #endregion
    }
}
