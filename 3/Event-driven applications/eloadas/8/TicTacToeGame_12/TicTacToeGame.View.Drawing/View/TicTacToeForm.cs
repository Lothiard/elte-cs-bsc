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

        #endregion

        #region Constructors

        /// <summary>
        /// Tic-Tac-Toe ablak létrehozása.
        /// </summary>
        public TicTacToeForm()
        {
            InitializeComponent();

            // modell létrehozása és eseménykezelők társítása
            _model = new BasicTicTacToeModel(new TicTacToeTextFileDataAccess());
            // a modellt úgy hozzuk létre, hogy fájl alapú adateléréssel fog rendelkezni

            _model.FieldChanged += new EventHandler<FieldChangedEventArgs>(Model_FieldChanged);
            _model.GameOver += new EventHandler(Model_GameOver);
            _model.GameWon += new EventHandler<GameWonEventArgs>(Model_GameWon);

            KeyPreview = true; // elfogjuk a billentyűzeteseményeket
            KeyDown += new KeyEventHandler(TicTacToeForm_KeyDown);
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

            _panel.Refresh();
        }

        /// <summary>
        /// Játék végének eseménykezelése.
        /// </summary>
        private void Model_GameOver(object? sender, EventArgs e)
        {
            MessageBox.Show("Döntetlen játék!", "Játék vége!", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            _model.NewGame();

            _panel.Refresh();
        }

        /// <summary>
        /// Modell mezőváltozásának eseménykezelése.
        /// </summary>
        private void Model_FieldChanged(object? sender, FieldChangedEventArgs e)
        {
            _panel.Refresh();
        }

        #endregion

        #region Panel event handlers

        /// <summary>
        /// Panel kirajzolásának eseménykezelése.
        /// </summary>
        private void Panel_Paint(object? sender, PaintEventArgs e)
        {
            Bitmap bitmap = new Bitmap(_panel.Width, _panel.Height); // kép a hatékony kirajzoláshoz

            Graphics graphics = Graphics.FromImage(bitmap);
            graphics.Clear(Color.White); // háttér fehérré festése

            // játéktábla rácsai
            Int32 fieldWidth = _panel.Width / 3;
            Int32 fieldHeight = _panel.Height / 3;
            graphics.DrawLine(Pens.Black, 0, fieldHeight, _panel.Width, fieldHeight);
            graphics.DrawLine(Pens.Black, 0, 2 * fieldHeight, _panel.Width, 2 * fieldHeight);
            graphics.DrawLine(Pens.Black, fieldWidth, 0, fieldWidth, _panel.Height);
            graphics.DrawLine(Pens.Black, 2 * fieldWidth, 0, 2 * fieldWidth, _panel.Height);

            // a mezőtartalmak
            for (Int32 i = 0; i < 3; i++)
                for (Int32 j = 0; j < 3; j++)
                {
                    switch (_model[i, j])
                    { 
                        case Player.PlayerO:
                            graphics.FillEllipse(Brushes.Yellow, i * fieldWidth + fieldWidth / 10, j * fieldHeight + fieldHeight / 10, 8 * fieldWidth / 10, 8 * fieldHeight / 10);
                            break;
                        case Player.PlayerX:
                            graphics.DrawLine(new Pen(Color.Orange, _panel.Width / 50), i * fieldWidth + fieldWidth / 10, j * fieldHeight + fieldHeight / 10, i * fieldWidth + 9 * fieldWidth / 10, j * fieldHeight + 9 * fieldHeight / 10);
                            graphics.DrawLine(new Pen(Color.Orange, _panel.Width / 50), i * fieldWidth + 9 * fieldWidth / 10, j * fieldHeight + fieldHeight / 10, i * fieldWidth + fieldWidth / 10, j * fieldHeight + 9 * fieldHeight / 10);
                            break;
                    }
                }

            e.Graphics.DrawImage(bitmap, 0, 0);
        }

        /// <summary>
        /// Panel egérlenyomásának eseménykezelése.
        /// </summary>
        private void Panel_MouseDown(object? sender, MouseEventArgs e)
        {
            // megállapítjuk, melyik mezőn van az egér
            Int32 x = 3 * e.X / _panel.Width;
            Int32 y = 3 * e.Y / _panel.Height;

            try
            {
                _model.StepGame(x, y); // lépünk a játékban
            }
            catch { }
        }

        #endregion

        #region Form event handlers

        /// <summary>
        /// Ablak betöltésének eseménykezelése.
        /// </summary>
        private void TicTacToeForm_Load(object? sender, EventArgs e)
        {
            _model.NewGame();
        }
        /// <summary>
        /// Ablak átmérezetésének eseménykezelése.
        /// </summary>
        private void TicTacToeForm_Resize(object? sender, EventArgs e)
        {
            _panel.Refresh();
        }

        /// <summary>
        /// Billentyű lenyomásának eseménykezelője.
        /// </summary>
        private async void TicTacToeForm_KeyDown(object? sender, KeyEventArgs e)
        {
            if (!e.Control) // ha nincs lenyomva a Control, nem csinálunk semmit
                return;

            switch (e.KeyCode)
            { 
                case Keys.N: // új játék indítása (Ctrl+N)
                    _model.NewGame();
                    break;
                case Keys.L: // betöltés (Ctrl+L)
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
                    break;
                case Keys.S: // mentés (Ctrl+S)
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
                    break;
            }
            _panel.Refresh();
        }

        #endregion
    }
}
