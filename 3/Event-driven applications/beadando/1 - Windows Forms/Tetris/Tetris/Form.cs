namespace Tetris
{
    public partial class Form : System.Windows.Forms.Form
    {
        private const int Rows = 20;
        private const int Cols = 10;
        private const int CellSize = 30;
        private Button[,] gridButtons = new Button[Rows, Cols];
        private int[,] board = new int[Rows, Cols]; // 0 = empty, >0 = filled

        private int fallingRow = 0;
        private int fallingCol = 4; // Start in the middle
        private System.Windows.Forms.Timer timer;

        public Form()
        {
            InitializeComponent();
            InitializeGrid();
            this.KeyPreview = true;
            this.KeyDown += Form_KeyDown;
            StartFallingBlock();
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

        private void RefreshGrid()
        {
            for (int row = 0; row < Rows; row++)
            {
                for (int col = 0; col < Cols; col++)
                {
                    gridButtons[row, col].BackColor = board[row, col] == 0 ? Color.Black : Color.Cyan;
                }
            }

            if (fallingRow >= 0 && fallingRow < Rows && fallingCol >= 0 && fallingCol < Cols && board[fallingRow, fallingCol] == 0)
            {
                gridButtons[fallingRow, fallingCol].BackColor = Color.Red;
            }
        }

        private void StartFallingBlock()
        {
            fallingRow = 0;
            fallingCol = Cols / 2;
            timer = new System.Windows.Forms.Timer();
            timer.Interval = 200; // ms
            timer.Tick += Timer_Tick;
            timer.Start();
            RefreshGrid();
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            // Check if the block can move down
            if (fallingRow + 1 < Rows && board[fallingRow + 1, fallingCol] == 0)
            {
                fallingRow++;
            }
            else
            {
                // Land the block
                board[fallingRow, fallingCol] = 1;
                timer.Stop();
            }
            RefreshGrid();
        }

        private void Form_KeyDown(object sender, KeyEventArgs e)
        {
            if (timer == null || !timer.Enabled) return;

            if (e.KeyCode == Keys.Left && fallingCol > 0 && board[fallingRow, fallingCol - 1] == 0)
            {
                fallingCol--;
            }
            else if (e.KeyCode == Keys.Right && fallingCol < Cols - 1 && board[fallingRow, fallingCol + 1] == 0)
            {
                fallingCol++;
            }
            else if (e.KeyCode == Keys.Down)
            {
                // Move down faster
                if (fallingRow + 1 < Rows && board[fallingRow + 1, fallingCol] == 0)
                    fallingRow++;
            }
            RefreshGrid();
        }

        private void Form_Load(object sender, EventArgs e)
        {
            board[0, 0] = 1;
            board[1, 1] = 1;
            RefreshGrid();
        }
    }
}
