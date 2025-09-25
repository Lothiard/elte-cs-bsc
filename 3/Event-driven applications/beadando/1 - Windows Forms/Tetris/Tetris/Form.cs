namespace Tetris
{
    public partial class Form : System.Windows.Forms.Form
    {
        private const int Rows = 20;
        private const int Cols = 10;
        private const int CellSize = 30;
        private Button[,] gridButtons = new Button[Rows, Cols];

        public Form()
        {
            InitializeComponent();
            InitializeGrid();
        }

        private void InitializeGrid()
        {
            for (int row = 0; row < Rows; row++)
            {
                for (int col = 0; col < Cols; col++)
                {
                    var btn = new Button();
                    btn.Width = CellSize;
                    btn.Height = CellSize;
                    btn.Left = col * CellSize;
                    btn.Top = row * CellSize;
                    btn.Enabled = false; // Not clickable
                    btn.TabStop = false; // Skip in tab order
                    btn.FlatStyle = FlatStyle.Flat;
                    btn.Margin = new Padding(0);
                    btn.Padding = new Padding(0);
                    gridButtons[row, col] = btn;
                    this.Controls.Add(btn);
                }
            }
            this.ClientSize = new Size(Cols * CellSize, Rows * CellSize);
        }
        private void Form_Load(object sender, EventArgs e)
        {

        }
    }
}
