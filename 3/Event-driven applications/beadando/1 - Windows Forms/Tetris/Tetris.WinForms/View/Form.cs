using System;
using System.Drawing;
using System.Threading.Tasks;
using System.Windows.Forms;
using Tetris.Persistence;
using Tetris.Model;

namespace Tetris.WinForms.View
{
    public partial class GameForm : Form
    {
        #region Fields

        private const int CellSize = 25;
        private Button[,]? gridButtons;
        private TetrisGameModel? game;
        private TetrisTimer gameTimer;
        private System.Windows.Forms.Timer? gameTickTimer;
        private System.Windows.Forms.Timer? clockTimer;

        #endregion

        #region Constructors

        public GameForm()
        {
            InitializeComponent();
            this.KeyPreview = true;
            this.KeyDown += Form_KeyDown;

            gameTimer = new TetrisTimer();
            cmbBoardSize.SelectedIndex = 1;
            clockTimer = new System.Windows.Forms.Timer();
            clockTimer.Interval = 100;
            clockTimer.Tick += ClockTimer_Tick;
            
            btnPause.Enabled = false;
        }

        #endregion

        #region Game event handlers

        private void Form_Load(object sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }

        private void GameTimer_Tick(object? sender, EventArgs e)
        {
            if (game == null || game.IsGameOver || gameTimer.IsPaused) return;

            if (!game.MoveDown())
            {
                game.LandCurrentPiece();
                game.ClearFullLines();
                game.SpawnNewTetromino();
            }
        }

        private void ClockTimer_Tick(object? sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }
        
        private void Game_GameStateChanged(object? sender, TetrisGameEventArgs e)
        {
            RefreshGrid();
        }
        
        private void Game_GameOver(object? sender, TetrisGameEventArgs e)
        {
            if (e.IsGameOver)
            {
                ShowGameOverMessage();
            }
        }

        #endregion

        #region Grid event handlers

        private void Form_KeyDown(object? sender, KeyEventArgs e)
        {
            if (!gameTimer.IsRunning || gameTimer.IsPaused || game == null || game.CurrentBlock == null) return;
            switch (e.KeyCode)
            {
                case Keys.A:
                    game.MoveLeft();
                    break;
                case Keys.D:
                    game.MoveRight();
                    break;
                case Keys.S:
                    game.MoveDown();
                    break;
                case Keys.W:
                    game.Rotate();
                    break;
            }
        }

        #endregion

        #region Menu event handlers

        private void btnNewGame_Click(object sender, EventArgs e)
        {
            StopGame();

            int rows = 16;
            int cols = 8;
            switch (cmbBoardSize.SelectedIndex)
            {
                case 0: cols = 4; break;
                case 1: cols = 8; break;
                case 2: cols = 12; break;
            }

            game = new TetrisGameModel(rows, cols);
            SubscribeToGameEvents();
            InitializeGame();
            StartGame();
        }

        private void btnPause_Click(object sender, EventArgs e)
        {
            if (!gameTimer.IsRunning || game == null) return;
            if (!gameTimer.IsPaused)
            {
                PauseGame();
            }
            else
            {
                ResumeGame();
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            await SaveGameAsync();
        }

        private async void btnLoad_Click(object sender, EventArgs e)
        {
            await LoadGameAsync();
        }

        #endregion

        #region Private methods

        private void SubscribeToGameEvents()
        {
            if (game == null) return;
            
            ((TetrisGameModel)game).GameStateChanged += Game_GameStateChanged;
            ((TetrisGameModel)game).GameOver += Game_GameOver;
        }
        
        private void UnsubscribeFromGameEvents()
        {
            if (game == null) return;
            
            ((TetrisGameModel)game).GameStateChanged -= Game_GameStateChanged;
            ((TetrisGameModel)game).GameOver -= Game_GameOver;
        }

        private void InitializeGame()
        {
            if (game == null) return;
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
            gridButtons = new Button[game.Rows, game.Cols];
            for (int row = 0; row < game.Rows; row++)
            {
                for (int col = 0; col < game.Cols; col++)
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
                }
            }
            panelGame.Size = new Size(game.Cols * CellSize + 2, game.Rows * CellSize + 2);
        }

        private void StartGame()
        {
            if (game == null) return;
            gameTimer.Start();
            btnNewGame.Text = "Új játék";
            btnPause.Text = "Szünet";
            btnPause.Enabled = true;
            btnSave.Enabled = false;
            btnLoad.Enabled = true;
            clockTimer?.Start();
            game.Reset();
            gameTickTimer = new System.Windows.Forms.Timer();
            gameTickTimer.Interval = 500;
            gameTickTimer.Tick += GameTimer_Tick;
            gameTickTimer.Start();
        }

        private void StopGame()
        {
            if (game != null)
            {
                UnsubscribeFromGameEvents();
            }
            
            gameTickTimer?.Stop();
            clockTimer?.Stop();
            gameTimer.Stop();
            btnPause.Text = "Szünet";
            btnPause.Enabled = false;
            btnSave.Enabled = false;
            btnLoad.Enabled = true;
        }

        private void PauseGame()
        {
            if (!gameTimer.IsRunning || gameTimer.IsPaused) return;
            gameTimer.Pause();
            gameTickTimer?.Stop();
            btnPause.Text = "Folytatás";
            btnSave.Enabled = true;
            btnLoad.Enabled = true;
        }

        private void ResumeGame()
        {
            if (!gameTimer.IsRunning || !gameTimer.IsPaused) return;
            gameTimer.Resume();
            gameTickTimer?.Start();
            btnPause.Text = "Szünet";
            btnSave.Enabled = false;
            btnLoad.Enabled = true;
        }

        private void UpdateTimeDisplay()
        {
            TimeSpan currentGameTime = gameTimer.IsRunning ? gameTimer.ElapsedTime : TimeSpan.Zero;
            lblTimeValue.Text = currentGameTime.ToString(@"hh\:mm\:ss");
        }

        private void RefreshGrid()
        {
            if (gridButtons == null || game == null) return;
            for (int row = 0; row < game.Rows; row++)
            {
                for (int col = 0; col < game.Cols; col++)
                {
                    if (game.Board[row, col] == 0)
                    {
                        gridButtons[row, col].BackColor = Color.Black;
                    }
                    else
                    {
                        int tetrominoType = game.Board[row, col] - 1;
                        if (tetrominoType >= 0 && tetrominoType < game.TetrominoColors.Length)
                        {
                            gridButtons[row, col].BackColor = game.TetrominoColors[tetrominoType];
                        }
                    }
                }
            }
            if (game.CurrentBlock != null)
            {
                Color color = game.TetrominoColors[game.CurrentTetrominoIndex];
                foreach (var (dr, dc) in game.CurrentBlock)
                {
                    int r = game.BlockRow + dr;
                    int c = game.BlockCol + dc;
                    if (r >= 0 && r < game.Rows && c >= 0 && c < game.Cols && game.Board[r, c] == 0)
                    {
                        gridButtons[r, c].BackColor = color;
                    }
                }
            }
        }

        private void ShowGameOverMessage()
        {
            TimeSpan totalTime = gameTimer.ElapsedTime;
            
            StopGame();
            
            string timeString = totalTime.ToString(@"hh\:mm\:ss");
            MessageBox.Show($"Játék vége!\n\nJátékidő: {timeString}", "Tetris", 
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private async Task SaveGameAsync()
        {
            if (!gameTimer.IsPaused || game == null) return;
            try
            {
                var gameState = new TetrisPersistence.GameState
                {
                    Rows = game.Rows,
                    Cols = game.Cols,
                    Board = game.Board,
                    CurrentTetrominoIndex = game.CurrentTetrominoIndex,
                    CurrentBlock = game.CurrentBlock!,
                    BlockRow = game.BlockRow,
                    BlockCol = game.BlockCol,
                    PausedTime = gameTimer.ElapsedTime,
                    SaveTime = DateTime.Now
                };
                using var dialog = new SaveFileDialog();
                dialog.Filter = "Tetris mentés (*.tetris)|*.tetris";
                dialog.DefaultExt = "tetris";
                dialog.Title = "Játék mentése";
                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    await TetrisPersistence.SaveAsync(dialog.FileName, gameState);
                    MessageBox.Show("Játék sikeresen elmentve!", "Mentés", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Hiba a mentés során: {ex.Message}", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private async Task LoadGameAsync()
        {
            try
            {
                using var dialog = new OpenFileDialog();
                dialog.Filter = "Tetris mentés (*.tetris)|*.tetris";
                dialog.Title = "Játék betöltése";
                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    var gameState = await TetrisPersistence.LoadAsync(dialog.FileName);
                    if (gameState?.Board == null)
                    {
                        MessageBox.Show("Érvénytelen mentési fájl!", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                    
                    StopGame();
                    
                    game = new TetrisGameModel(gameState.Rows, gameState.Cols);
                    
                    switch (gameState.Cols)
                    {
                        case 4: cmbBoardSize.SelectedIndex = 0; break;
                        case 8: cmbBoardSize.SelectedIndex = 1; break;
                        case 12: cmbBoardSize.SelectedIndex = 2; break;
                    }
                    
                    InitializeGame();
                    
                    game.Board = gameState.Board;
                    game.CurrentTetrominoIndex = gameState.CurrentTetrominoIndex;
                    game.CurrentBlock = gameState.CurrentBlock;
                    game.BlockRow = gameState.BlockRow;
                    game.BlockCol = gameState.BlockCol;
                    
                    SubscribeToGameEvents();
                    
                    gameTimer.SetPausedTime(gameState.PausedTime);
                    
                    gameTimer.Start();
                    btnNewGame.Text = "Új játék";
                    btnPause.Text = "Szünet";
                    btnPause.Enabled = true;
                    btnSave.Enabled = false;
                    btnLoad.Enabled = true;
                    clockTimer?.Start();
                    
                    gameTickTimer = new System.Windows.Forms.Timer();
                    gameTickTimer.Interval = 500;
                    gameTickTimer.Tick += GameTimer_Tick;
                    gameTickTimer.Start();
                    
                    PauseGame();
                    
                    RefreshGrid();
                    
                    UpdateTimeDisplay();
                    
                    MessageBox.Show("Játék sikeresen betöltve!", "Betöltés", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Hiba a betöltés során: {ex.Message}", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion
    }
}
