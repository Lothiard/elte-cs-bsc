using ELTE.TicTacToeGame.Persistence;
using ELTE.TicTacToeGame.Model;
using System;
using System.Drawing;
using System.Windows.Forms;

namespace ELTE.TicTacToeGame.View
{
    /// <summary>
    /// Tic-Tac-Toe ablak típusa.
    /// </summary>
    public partial class TicTacToeForm : Form
    {
        #region Private fields

        private ITicTacToeModel _model; // játék
        private Button[,] _buttonGrid; // gombrács

        #endregion

        #region Constructors

        /// <summary>
        /// Tic-Tac-Toe ablak létrehozása.
        /// </summary>
        public TicTacToeForm()
        {
            InitializeComponent();

            // modell létrehozása és eseménykezelők társítása
            _model = new BasicTicTacToeModel(new TicTacToeBinaryFileDataAccess());
            // a modellt úgy hozzuk létre, hogy fájl alapú adateléréssel fog rendelkezni

            _model.FieldChanged += new EventHandler<FieldChangedEventArgs>(Model_FieldChanged);
            _model.GameOver += new EventHandler(Model_GameOver);
            _model.GameWon += new EventHandler<GameWonEventArgs>(Model_GameWon);

            _buttonGrid = null!; // kezdetben null, de használat előtt garantáltan inicializáljuk majd
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Tábla létrehozása.
        /// </summary>
        private void GenerateTable()
        {
            // be kell állítani a táblaelhelyezés méreteit
            _tableLayoutPanel.RowCount = _tableLayoutPanel.ColumnCount = 3;

            _buttonGrid = new Button[3, 3];
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    _buttonGrid[i, j] = new GridButton(i, j);
                    _buttonGrid[i, j].Location = new Point(5 + 50 * i, 25 + 50 * j); // elhelyezkedés
                    _buttonGrid[i, j].Size = new Size(50, 50); // méret
                    _buttonGrid[i, j].Font = new Font(FontFamily.GenericSansSerif, Height / 10, FontStyle.Bold); // betűtípus
                    _buttonGrid[i, j].Dock = DockStyle.Fill; // kitölti a helyet
                    _buttonGrid[i, j].BackColor = Color.White;
                    _buttonGrid[i, j].MouseClick += new MouseEventHandler(ButtonGrid_MouseClick);
                    // közös eseménykezelő hozzárendelése minden gombhoz

                    _tableLayoutPanel.Controls.Add(_buttonGrid[i, j]);
                    // felevesszük az ablakra a gombot
                }

            // létre kell hozni a megfelelő stípusokat a soroknak és oszlopoknak
            _tableLayoutPanel.RowStyles.Clear();
            _tableLayoutPanel.ColumnStyles.Clear();

            for (Int32 i = 0; i < 3; i++)
            {
                _tableLayoutPanel.RowStyles.Add(new RowStyle(SizeType.Percent, 1 / 3F));
                // a sorok és oszlopok egyenlően, arányosan méreteződnek
            }
            for (Int32 j = 0; j < 3; j++)
            {
                _tableLayoutPanel.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 1 / 3F));
            }

        }

        /// <summary>
        /// Tábla beállítása.
        /// </summary>
        private void SetTable()
        {
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    switch (_model[i, j])
                    {
                        case Player.PlayerO:
                            _buttonGrid[i, j].BackColor = Color.Yellow;
                            _buttonGrid[i, j].Text = "O";
                            break;
                        case Player.PlayerX:
                            _buttonGrid[i, j].BackColor = Color.Orange;
                            _buttonGrid[i, j].Text = "X";
                            break;
                        case Player.NoPlayer:
                            _buttonGrid[i, j].BackColor = Color.White;
                            _buttonGrid[i, j].Text = String.Empty;
                            break;
                    }
                }
        }

        #endregion

        #region Model event handlers

        /// <summary>
        /// Játék megnyerésének eseménykezelése.
        /// </summary>
        private void Model_GameWon(object? sender, GameWonEventArgs e)
        {
            switch (e.Player)
            {
                case Player.PlayerO:
                    MessageBox.Show("A kör játékos győzött!", "Játék vége!", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
                    break;
                case Player.PlayerX:
                    MessageBox.Show("A kereszt játékos győzött!", "Játék vége!", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
                    break;
            }
            _model.NewGame();
            SetTable();
        }

        /// <summary>
        /// Játék végének eseménykezelése.
        /// </summary>
        private void Model_GameOver(object? sender, EventArgs e)
        {
            MessageBox.Show("Döntetlen játék!", "Játék vége!", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            _model.NewGame();
            SetTable();
        }

        /// <summary>
        /// Modell mezőváltozásának eseménykezelése.
        /// </summary>
        private void Model_FieldChanged(object? sender, FieldChangedEventArgs e)
        {
            switch (e.Player)
            {
                case Player.PlayerO:
                    _buttonGrid[e.X, e.Y].BackColor = Color.Yellow;
                    _buttonGrid[e.X, e.Y].Text = "O";
                    break;
                case Player.PlayerX:
                    _buttonGrid[e.X, e.Y].BackColor = Color.Orange;
                    _buttonGrid[e.X, e.Y].Text = "X";
                    break;
                case Player.NoPlayer:
                    _buttonGrid[e.X, e.Y].BackColor = Color.White;
                    _buttonGrid[e.X, e.Y].Text = String.Empty;
                    break;
            }
        }

        #endregion

        #region Form event handlers

        /// <summary>
        /// Ablak betöltésének eseménykezelése.
        /// </summary>
        private void TicTacToeForm_Load(object? sender, EventArgs e)
        {
            _model.NewGame();

            GenerateTable();

            SizeChanged += TicTacToeForm_SizeChanged;
        }

        /// <summary>
        /// Ablak méretváltásának eseménykezelése.
        /// </summary>
        private void TicTacToeForm_SizeChanged(object? sender, EventArgs e)
        {
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    // a gombok szövegméretét állítjuk be az új mérethez arányosan
                    _buttonGrid[i, j].Font = new Font(FontFamily.GenericSansSerif, Height / 10, FontStyle.Bold);
                }
        }

        #endregion

        #region Grid event handlers

        /// <summary>
        /// Gombrács eseménykezelője.
        /// </summary>
        private void ButtonGrid_MouseClick(object? sender, MouseEventArgs e)
        {
            if (sender is GridButton button)
            {
                Int32 x = button.GridX; // rácskoordináták kiolvasása
                Int32 y = button.GridY;

                try
                {
                    _model.StepGame(x, y); // lépés a játékban
                }
                catch
                {
                }
            }
        }

        #endregion

        #region Menu event handlers

        /// <summary>
        /// Új játék menüpontjának eseménykezelője.
        /// </summary>
        private void MenuGameNew_Click(object? sender, EventArgs e)
        {
            _model.NewGame();
            SetTable();
        }
        /// <summary>
        /// Játék betöltés menüpontjának eseménykezelője.
        /// </summary>
        private async void MenuGameLoad_Click(object? sender, EventArgs e)
        {
            if (_openFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    await _model.LoadGameAsync(_openFileDialog.FileName);
                }
                catch (TicTacToeDataException)
                {
                    MessageBox.Show("Hiba keletkezett a betöltés során.", "Tic-Tac-Toe", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
        /// <summary>
        /// Játék mentés menüpontjának eseménykezelője.
        /// </summary>
        private async void MenuGameSave_Click(object? sender, EventArgs e)
        {
            if (_saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    await _model.SaveGameAsync(_saveFileDialog.FileName);
                }
                catch (TicTacToeDataException)
                {
                    MessageBox.Show("Hiba keletkezett a mentés során.", "Tic-Tac-Toe", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
        /// <summary>
        /// Kilépés menüpontjának eseménykezelője.
        /// </summary>
        private void MenuGameExit_Click(object? sender, EventArgs e)
        {
            Close();
        }

        #endregion
    }
}
