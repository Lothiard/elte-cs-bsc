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

        // Tetromino definition: O-block (2x2)
        private readonly (int row, int col)[] oBlock = new (int, int)[] { (0,0), (0,1), (1,0), (1,1) };
        private (int row, int col)[] currentBlock;
        private int blockRow, blockCol; // Top-left of the block

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

            foreach (var (dr, dc) in currentBlock)
            {
                int r = blockRow + dr;
                int c = blockCol + dc;

                if (r >= 0 && r < Rows && c >= 0 && c < Cols && board[r, c] == 0)
                {
                    gridButtons[r, c].BackColor = Color.Red;
                }
            }

        }

        private void StartFallingBlock()
        {
            blockRow = 0;
            blockCol = Cols / 2 - 1;
            currentBlock = oBlock;
            timer = new System.Windows.Forms.Timer();
            timer.Interval = 200; // ms
            timer.Tick += Timer_Tick;
            timer.Start();
            RefreshGrid();
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            // Check if the block can move down
            bool canMove = true;
            foreach (var (dr, dc) in currentBlock)
            {
                int r = blockRow + dr + 1;
                int c = blockCol + dc;
                if (r >= Rows || board[r, c] != 0)
                {
                    canMove = false;
                    break;
                }
            }

            if (canMove)
            {
                blockRow++;
            }
            else
            {
                // Land the block
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = blockRow + dr;
                    int c = blockCol + dc;
                    board[r, c] = 1;
                }
                timer.Stop();

                ClearFullLines();

                // Check for game over (if spawn position is blocked)
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = 0 + dr;
                    int c = (Cols / 2 - 1) + dc;
                    if (board[r, c] != 0)
                    {
                        MessageBox.Show("Game Over!");
                        return;
                    }
                }

                StartFallingBlock();
                return;
            }
            RefreshGrid();
        }

        private void Form_KeyDown(object sender, KeyEventArgs e)
        {
            if (timer == null || !timer.Enabled) return;

            if (e.KeyCode == Keys.Left)
            {
                bool canMove = true;
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = blockRow + dr;
                    int c = blockCol + dc - 1;
                    if (c < 0 || board[r, c] != 0)
                    {
                        canMove = false;
                        break;
                    }
                }
                if (canMove) blockCol--;
            }
            else if (e.KeyCode == Keys.Right)
            {
                bool canMove = true;
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = blockRow + dr;
                    int c = blockCol + dc + 1;
                    if (c >= Cols || board[r, c] != 0)
                    {
                        canMove = false;
                        break;
                    }
                }
                if (canMove) blockCol++;
            }
            else if (e.KeyCode == Keys.Down)
            {
                // Move down faster
                bool canMove = true;
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = blockRow + dr + 1;
                    int c = blockCol + dc;
                    if (r >= Rows || board[r, c] != 0)
                    {
                        canMove = false;
                        break;
                    }
                }
                if (canMove) blockRow++;
            }
            RefreshGrid();
        }

        private void ClearFullLines()
        {
            for (int row = Rows - 1; row >= 0; row--)
            {
                bool full = true;
                for (int col = 0; col < Cols; col++)
                {
                    if (board[row, col] == 0)
                    {
                        full = false;
                        break;
                    }
                }
                if (full)
                {
                    // Move all rows above down by one
                    for (int r = row; r > 0; r--)
                    {
                        for (int c = 0; c < Cols; c++)
                        {
                            board[r, c] = board[r - 1, c];
                        }
                    }
                    // Clear the top row
                    for (int c = 0; c < Cols; c++)
                    {
                        board[0, c] = 0;
                    }
                    row++; // Check this row again after shifting
                }
            }
        }

        private void Form_Load(object sender, EventArgs e)
        {
            RefreshGrid();
        }
    }
}
