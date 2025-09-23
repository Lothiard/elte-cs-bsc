using System;
using System.Drawing;
using System.Windows.Forms;

namespace ELTE.ColorGrid
{
    public partial class GridForm : Form
    {
        private Random _random; // véletlenszám generátor
        private GridButton[,]? _buttons; // gombok mátrixa    

        public GridForm()
        {
            InitializeComponent();

            _random = new Random();
        }

        private void ButtonSize_Click(object sender, EventArgs e)
        {
            if (_buttons != null)
            // ha már vannak gombok az ablakban, töröljük azokat
            {
                foreach (Button button in _buttons)
                    _tableLayoutGrid.Controls.Remove(button);
                // a törlés pontosabban azt jelenti, hogy levesszük őket a tartalmazó vezérlőről
            }
            _buttons = new GridButton[Convert.ToInt32(_numericRows.Value), Convert.ToInt32(_numericColumns.Value)];
            // új mátrix létrehozása

            // be kell állítani a táblaelhelyezés méreteit
            _tableLayoutGrid.RowCount = Convert.ToInt32(_numericRows.Value);
            _tableLayoutGrid.ColumnCount = Convert.ToInt32(_numericColumns.Value);

            for (Int32 i = 0; i < _numericRows.Value; i++) // addig megyünk, amíg a számlálók mondják
            {
                for (Int32 j = 0; j < _numericColumns.Value; j++)
                {
                    _buttons[i, j] = new GridButton(i, j);
                    _buttons[i, j].BackColor = Color.White;  // beállítjuk a kezdőszínét
                    _buttons[i, j].Dock = DockStyle.Fill; // kitöltésre állítjuk
                    _buttons[i, j].Click += new EventHandler(GridButton_Click); // eseménykezelő társítás
                    _tableLayoutGrid.Controls.Add(_buttons[i, j], j, i); // hozzáadjuk a táblapanel vezérlőihez
                }
            }

            // létre kell hozni a megfelelő stípusokat a soroknak és oszlopoknak
            _tableLayoutGrid.RowStyles.Clear();
            _tableLayoutGrid.ColumnStyles.Clear();

            for (Int32 i = 0; i < _numericRows.Value; i++)
            {
                _tableLayoutGrid.RowStyles.Add(new RowStyle(SizeType.Percent, 1 / Convert.ToSingle(_numericRows.Value)));
                // a sorok és oszlopok egyenlően, arányosan méreteződnek
            }
            for (Int32 j = 0; j < _numericColumns.Value; j++)
            {
                _tableLayoutGrid.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 1 / Convert.ToSingle(_numericColumns.Value)));
            }
        }

        private void GridButton_Click(object? sender, EventArgs e)
        {
            if (sender is GridButton button)
            {
                Int32 x = button.GridX; // rácskoordináták kiolvasása
                Int32 y = button.GridY;
                Color color = Color.FromArgb(_random.Next(256), _random.Next(256), _random.Next(256)); // ú, véletlenszín generálás

                for (Int32 i = 0; i < _buttons!.GetLength(0); i++) // a _buttons itt nem lehet null
                {
                    _buttons[i, y].BackColor = color; // átszínezés
                }
                for (Int32 j = 0; j < _buttons.GetLength(1); j++)
                {
                    _buttons[x, j].BackColor = color;
                }
            }
        }
    }
}
