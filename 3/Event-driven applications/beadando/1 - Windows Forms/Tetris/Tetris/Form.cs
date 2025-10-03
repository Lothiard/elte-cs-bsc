using System.Text.Json;

namespace Tetris
{
    public partial class Form : System.Windows.Forms.Form
    {
        private int Rows;
        private int Cols;
        private const int CellSize = 25;
        
        private Button[,]? gridButtons;
        private int[,]? board;
        private bool isGameRunning = false;
        private bool isPaused = false;
        private DateTime gameStartTime;
        private TimeSpan pausedTime = TimeSpan.Zero;
        private System.Windows.Forms.Timer? gameTimer;
        private System.Windows.Forms.Timer? clockTimer;

        private readonly (int row, int col)[][] tetrominoes = new (int, int)[][]
        {
            new (int, int)[] { (0,0), (0,1), (0,2), (0,3) }, // I
            new (int, int)[] { (0,0), (0,1), (1,0), (1,1) }, // O
            new (int, int)[] { (0,1), (1,0), (1,1), (1,2) }, // T
            new (int, int)[] { (0,1), (0,2), (1,0), (1,1) }, // S
            new (int, int)[] { (0,0), (0,1), (1,1), (1,2) }, // Z
            new (int, int)[] { (0,0), (1,0), (1,1), (1,2) }, // J
            new (int, int)[] { (0,2), (1,0), (1,1), (1,2) }  // L
        };
        
        private readonly Color[] tetrominoColors = new Color[]
        {
            Color.Cyan, Color.Yellow, Color.Purple, Color.Green, 
            Color.Red, Color.Blue, Color.Orange
        };
        
        private int currentTetrominoIndex;
        private Random rng = new Random();
        private (int row, int col)[]? currentBlock;
        private int blockRow, blockCol;

        public Form()
        {
            InitializeComponent();
            this.KeyPreview = true;
            this.KeyDown += Form_KeyDown;

            cmbBoardSize.SelectedIndex = 1;
            
            clockTimer = new System.Windows.Forms.Timer();
            clockTimer.Interval = 100;
            clockTimer.Tick += ClockTimer_Tick;
        }

        private void Form_Load(object sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }

        private void btnNewGame_Click(object sender, EventArgs e)
        {
            if (cmbBoardSize.SelectedIndex == -1)
            {
                MessageBox.Show("Kérjük, válasszon pályaméretet!", "Figyelmeztetés", 
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            StopGame();

            switch (cmbBoardSize.SelectedIndex)
            {
                case 0: Cols = 4; Rows = 16; break;
                case 1: Cols = 8; Rows = 16; break;
                case 2: Cols = 12; Rows = 16; break;
            }

            InitializeGame();
            StartGame();
        }

        private void btnPause_Click(object sender, EventArgs e)
        {
            if (!isGameRunning) return;

            if (!isPaused)
            {
                PauseGame();
            }
            else
            {
                ResumeGame();
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!isPaused)
            {
                MessageBox.Show("A játék mentése csak szünet alatt lehetséges!", "Figyelmeztetés", 
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            SaveGame();
        }

        private void btnLoad_Click(object sender, EventArgs e)
        {
            LoadGame();
        }

        private void InitializeGame()
        {
            if (gridButtons != null)
            {
                for (int row = 0; row < gridButtons.GetLength(0); row++)
                {
                    for (int col = 0; col < gridButtons.GetLength(1); col++)
                    {
                        panelGame.Controls.Remove(gridButtons[row, col]);
                        gridButtons[row, col].Dispose();
                    }
                }
            }

            gridButtons = new Button[Rows, Cols];
            board = new int[Rows, Cols];

            for (int row = 0; row < Rows; row++)
            {
                for (int col = 0; col < Cols; col++)
                {
                    var btn = new Button();
                    btn.Width = CellSize;
                    btn.Height = CellSize;
                    btn.Left = col * CellSize;
                    btn.Top = row * CellSize;
                    btn.Enabled = false;
                    btn.TabStop = false;
                    btn.FlatStyle = FlatStyle.Flat;
                    btn.Margin = new Padding(0);
                    btn.Padding = new Padding(0);
                    btn.BackColor = Color.Black;
                    btn.FlatAppearance.BorderColor = Color.Black;
                    btn.FlatAppearance.BorderSize = 1;
                    
                    gridButtons[row, col] = btn;
                    panelGame.Controls.Add(btn);

                    board[row, col] = 0;
                }
            }

            panelGame.Size = new Size(Cols * CellSize + 2, Rows * CellSize + 2);
        }

        private void StartGame()
        {
            isGameRunning = true;
            isPaused = false;
            gameStartTime = DateTime.Now;
            pausedTime = TimeSpan.Zero;
            
            btnNewGame.Text = "Új játék";
            btnPause.Text = "Szünet";
            btnPause.Enabled = true;
            btnSave.Enabled = false;
            // cmbBoardSize.Enabled = false;
            // ts shi not working gang
            btnLoad.Enabled = false;

            clockTimer?.Start();
            
            SpawnNewTetromino();

            gameTimer = new System.Windows.Forms.Timer();
            gameTimer.Interval = 500;
            gameTimer.Tick += GameTimer_Tick;
            gameTimer.Start();
            
            RefreshGrid();
        }

        private void StopGame()
        {
            isGameRunning = false;
            isPaused = false;

            gameTimer?.Stop();
            clockTimer?.Stop();

            btnPause.Text = "Szünet";
            btnPause.Enabled = false;
            btnSave.Enabled = false;
        }

        private void PauseGame()
        {
            if (!isGameRunning || isPaused) return;
            
            isPaused = true;
            pausedTime += DateTime.Now - gameStartTime;

            gameTimer?.Stop();

            btnPause.Text = "Folytatás";
            btnSave.Enabled = true;
        }

        private void ResumeGame()
        {
            if (!isGameRunning || !isPaused) return;
            
            isPaused = false;
            gameStartTime = DateTime.Now;

            gameTimer?.Start();

            btnPause.Text = "Szünet";
            btnSave.Enabled = false;
        }

        private void SpawnNewTetromino()
        {
            currentTetrominoIndex = rng.Next(tetrominoes.Length);
            currentBlock = (ValueTuple<int, int>[])tetrominoes[currentTetrominoIndex].Clone();
            blockRow = 0;
            blockCol = Cols / 2 - 2;

            if (!CanMoveTo(blockRow, blockCol, currentBlock))
            {
                GameOver();
            }
        }

        private void GameTimer_Tick(object? sender, EventArgs e)
        {
            if (isPaused) return;

            if (currentBlock != null && CanMoveTo(blockRow + 1, blockCol, currentBlock))
            {
                blockRow++;
            }
            else
            {
                LandCurrentPiece();
                ClearFullLines();
                SpawnNewTetromino();
            }
            
            RefreshGrid();
        }

        private void ClockTimer_Tick(object? sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }

        private void UpdateTimeDisplay()
        {
            if (isGameRunning)
            {
                TimeSpan currentGameTime;
                if (isPaused)
                {
                    currentGameTime = pausedTime;
                }
                else
                {
                    currentGameTime = pausedTime + (DateTime.Now - gameStartTime);
                }
                
                lblTimeValue.Text = currentGameTime.ToString(@"hh\:mm\:ss");
            }
            else
            {
                lblTimeValue.Text = "00:00:00";
            }
        }

        private bool CanMoveTo(int newRow, int newCol, (int row, int col)[] block)
        {
            if (block == null || board == null) return false;

            foreach (var (dr, dc) in block)
            {
                int r = newRow + dr;
                int c = newCol + dc;
                
                if (r < 0 || r >= Rows || c < 0 || c >= Cols || board[r, c] != 0)
                {
                    return false;
                }
            }
            return true;
        }

        private void LandCurrentPiece()
        {
            if (currentBlock == null || board == null) return;

            foreach (var (dr, dc) in currentBlock)
            {
                int r = blockRow + dr;
                int c = blockCol + dc;
                if (r >= 0 && r < Rows && c >= 0 && c < Cols)
                {
                    board[r, c] = currentTetrominoIndex + 1;
                }
            }
        }

        private void ClearFullLines()
        {
            if (board == null) return;

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
                    for (int r = row; r > 0; r--)
                    {
                        for (int c = 0; c < Cols; c++)
                        {
                            board[r, c] = board[r - 1, c];
                        }
                    }

                    for (int c = 0; c < Cols; c++)
                    {
                        board[0, c] = 0;
                    }
                    
                    row++;
                }
            }
        }

        private void RefreshGrid()
        {
            if (gridButtons == null || board == null) return;

            for (int row = 0; row < Rows; row++)
            {
                for (int col = 0; col < Cols; col++)
                {
                    if (board[row, col] == 0)
                    {
                        gridButtons[row, col].BackColor = Color.Black;
                    }
                    else
                    {
                        int tetrominoType = board[row, col] - 1;
                        if (tetrominoType >= 0 && tetrominoType < tetrominoColors.Length)
                        {
                            gridButtons[row, col].BackColor = tetrominoColors[tetrominoType];
                        }
                    }
                }
            }

            if (currentBlock != null)
            {
                Color color = tetrominoColors[currentTetrominoIndex];
                foreach (var (dr, dc) in currentBlock)
                {
                    int r = blockRow + dr;
                    int c = blockCol + dc;
                    if (r >= 0 && r < Rows && c >= 0 && c < Cols && board[r, c] == 0)
                    {
                        gridButtons[r, c].BackColor = color;
                    }
                }
            }
        }

        private void Form_KeyDown(object? sender, KeyEventArgs e)
        {
            if (!isGameRunning || isPaused || currentBlock == null) return;

            switch (e.KeyCode)
            {
                case Keys.A:
                    if (CanMoveTo(blockRow, blockCol - 1, currentBlock))
                        blockCol--;
                    break;
                    
                case Keys.D:
                    if (CanMoveTo(blockRow, blockCol + 1, currentBlock))
                        blockCol++;
                    break;
                    
                case Keys.S:
                    if (CanMoveTo(blockRow + 1, blockCol, currentBlock))
                        blockRow++;
                    break;
                    
                case Keys.W:
                    RotateCurrentPiece();
                    break;
            }
            
            RefreshGrid();
        }

        private void RotateCurrentPiece()
        {
            if (currentBlock == null) return;

            var rotated = new (int row, int col)[currentBlock.Length];
            for (int i = 0; i < currentBlock.Length; i++)
            {
                rotated[i] = (currentBlock[i].col, -currentBlock[i].row);
            }

            int minRow = rotated.Min(x => x.row);
            int minCol = rotated.Min(x => x.col);
            for (int i = 0; i < rotated.Length; i++)
            {
                rotated[i] = (rotated[i].row - minRow, rotated[i].col - minCol);
            }

            if (CanMoveTo(blockRow, blockCol, rotated))
            {
                currentBlock = rotated;
            }
        }

        private void GameOver()
        {
            StopGame();
            
            TimeSpan totalTime = pausedTime + (DateTime.Now - gameStartTime);
            string timeString = totalTime.ToString(@"hh\:mm\:ss");
            
            MessageBox.Show($"Játék vége!\n\nJátékidő: {timeString}", "Tetris", 
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public class GameState
        {
            public int Rows { get; set; }
            public int Cols { get; set; }
            public int[,]? Board { get; set; }
            public int CurrentTetrominoIndex { get; set; }
            public (int row, int col)[]? CurrentBlock { get; set; }
            public int BlockRow { get; set; }
            public int BlockCol { get; set; }
            public TimeSpan PausedTime { get; set; }
            public DateTime SaveTime { get; set; }
        }

        private void SaveGame()
        {
            if (!isPaused) return;

            try
            {
                var gameState = new GameState
                {
                    Rows = Rows,
                    Cols = Cols,
                    Board = board,
                    CurrentTetrominoIndex = currentTetrominoIndex,
                    CurrentBlock = currentBlock,
                    BlockRow = blockRow,
                    BlockCol = blockCol,
                    PausedTime = pausedTime,
                    SaveTime = DateTime.Now
                };

                using var dialog = new SaveFileDialog();
                dialog.Filter = "Tetris mentés (*.tetris)|*.tetris";
                dialog.DefaultExt = "tetris";
                dialog.Title = "Játék mentése";

                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    string json = JsonSerializer.Serialize(gameState, new JsonSerializerOptions { WriteIndented = true });
                    File.WriteAllText(dialog.FileName, json);
                    MessageBox.Show("Játék sikeresen elmentve!", "Mentés", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Hiba a mentés során: {ex.Message}", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void LoadGame()
        {
            try
            {
                using var dialog = new OpenFileDialog();
                dialog.Filter = "Tetris mentés (*.tetris)|*.tetris";
                dialog.Title = "Játék betöltése";

                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    string json = File.ReadAllText(dialog.FileName);
                    var gameState = JsonSerializer.Deserialize<GameState>(json);

                    if (gameState?.Board == null)
                    {
                        MessageBox.Show("Érvénytelen mentési fájl!", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    StopGame();

                    Rows = gameState.Rows;
                    Cols = gameState.Cols;
                    board = gameState.Board;
                    currentTetrominoIndex = gameState.CurrentTetrominoIndex;
                    currentBlock = gameState.CurrentBlock;
                    blockRow = gameState.BlockRow;
                    blockCol = gameState.BlockCol;
                    pausedTime = gameState.PausedTime;

                    switch (Cols)
                    {
                        case 4: cmbBoardSize.SelectedIndex = 0; break;
                        case 8: cmbBoardSize.SelectedIndex = 1; break;
                        case 12: cmbBoardSize.SelectedIndex = 2; break;
                    }

                    InitializeGame();
                    StartGame();
                    PauseGame();

                    MessageBox.Show("Játék sikeresen betöltve!", "Betöltés", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Hiba a betöltés során: {ex.Message}", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
