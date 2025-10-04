using System;
using System.Drawing;
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
        private ITetrisGame? game;
        private bool isGameRunning = false;
        private bool isPaused = false;
        private TetrisTimerAggregation gameTimer;
        private System.Windows.Forms.Timer? gameTickTimer;
        private System.Windows.Forms.Timer? clockTimer;

        #endregion

        #region Constructors

        public GameForm()
        {
            InitializeComponent();
            this.KeyPreview = true;
            this.KeyDown += Form_KeyDown;

            gameTimer = new TetrisTimerAggregation();
            cmbBoardSize.SelectedIndex = 1;
            clockTimer = new System.Windows.Forms.Timer();
            clockTimer.Interval = 100;
            clockTimer.Tick += ClockTimer_Tick;
        }

        #endregion

        #region Game event handlers

        private void Form_Load(object sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }

        private void GameTimer_Tick(object? sender, EventArgs e)
        {
            if (isPaused || game == null) return;
            if (!game.MoveDown())
            {
                game.LandCurrentPiece();
                game.ClearFullLines();
                game.SpawnNewTetromino();
                if (game.IsGameOver)
                {
                    GameOver();
                    return;
                }
            }
            RefreshGrid();
        }

        private void ClockTimer_Tick(object? sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }
        
        private void Game_TetrominoMoved(object? sender, TetrominoEventArgs e)
        {
            RefreshGrid();
        }
        
        private void Game_TetrominoRotated(object? sender, TetrominoEventArgs e)
        {
            RefreshGrid();
        }
        
        private void Game_GameStateChanged(object? sender, TetrisGameEventArgs e)
        {
            RefreshGrid();
        }
        
        private void Game_TetrominoSpawned(object? sender, TetrominoEventArgs e)
        {
            RefreshGrid();
        }
        
        private void Game_GameOver(object? sender, TetrisGameEventArgs e)
        {
            if (e.IsGameOver)
            {
                GameOver();
            }
        }
        
        private void Game_LinesCleared(object? sender, TetrisGameEventArgs e)
        {
            RefreshGrid();
        }

        #endregion

        #region Grid event handlers

        private void Form_KeyDown(object? sender, KeyEventArgs e)
        {
            if (!isGameRunning || isPaused || game == null || game.CurrentBlock == null) return;
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
            if (cmbBoardSize.SelectedIndex == -1)
            {
                MessageBox.Show("Kérjük, válasszon pályaméretet!", "Figyelmeztetés", 
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            StopGame();

            int rows = 16;
            int cols = 8;
            switch (cmbBoardSize.SelectedIndex)
            {
                case 0: cols = 4; break;
                case 1: cols = 8; break;
                case 2: cols = 12; break;
            }

            game = new TetrisGame(rows, cols);
            SubscribeToGameEvents();
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

        #endregion

        #region Private methods

        private void SubscribeToGameEvents()
        {
            if (game == null) return;
            
            // Subscribe to game events for proper MVC pattern implementation
            ((TetrisGame)game).TetrominoMoved += Game_TetrominoMoved;
            ((TetrisGame)game).TetrominoRotated += Game_TetrominoRotated;
            ((TetrisGame)game).GameStateChanged += Game_GameStateChanged;
            ((TetrisGame)game).TetrominoSpawned += Game_TetrominoSpawned;
            ((TetrisGame)game).GameOver += Game_GameOver;
            ((TetrisGame)game).LinesCleared += Game_LinesCleared;
        }
        
        private void UnsubscribeFromGameEvents()
        {
            if (game == null) return;
            
            // Unsubscribe from game events to prevent memory leaks
            ((TetrisGame)game).TetrominoMoved -= Game_TetrominoMoved;
            ((TetrisGame)game).TetrominoRotated -= Game_TetrominoRotated;
            ((TetrisGame)game).GameStateChanged -= Game_GameStateChanged;
            ((TetrisGame)game).TetrominoSpawned -= Game_TetrominoSpawned;
            ((TetrisGame)game).GameOver -= Game_GameOver;
            ((TetrisGame)game).LinesCleared -= Game_LinesCleared;
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
            isGameRunning = true;
            isPaused = false;
            gameTimer.Start();
            btnNewGame.Text = "Új játék";
            btnPause.Text = "Szünet";
            btnPause.Enabled = true;
            btnSave.Enabled = false;
            btnLoad.Enabled = false;
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
            
            isGameRunning = false;
            isPaused = false;
            gameTickTimer?.Stop();
            clockTimer?.Stop();
            gameTimer.Stop();
            btnPause.Text = "Szünet";
            btnPause.Enabled = false;
            btnSave.Enabled = false;
        }

        private void PauseGame()
        {
            if (!isGameRunning || isPaused) return;
            isPaused = true;
            gameTimer.Pause();
            gameTickTimer?.Stop();
            btnPause.Text = "Folytatás";
            btnSave.Enabled = true;
        }

        private void ResumeGame()
        {
            if (!isGameRunning || !isPaused) return;
            isPaused = false;
            gameTimer.Resume();
            gameTickTimer?.Start();
            btnPause.Text = "Szünet";
            btnSave.Enabled = false;
        }

        private void UpdateTimeDisplay()
        {
            if (isGameRunning)
            {
                TimeSpan currentGameTime = gameTimer.ElapsedTime;
                lblTimeValue.Text = currentGameTime.ToString(@"hh\:mm\:ss");
            }
            else
            {
                lblTimeValue.Text = "00:00:00";
            }
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

        private void GameOver()
        {
            StopGame();
            TimeSpan totalTime = gameTimer.ElapsedTime;
            string timeString = totalTime.ToString(@"hh\:mm\:ss");
            MessageBox.Show($"Játék vége!\n\nJátékidő: {timeString}", "Tetris", 
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void SaveGame()
        {
            if (!isPaused || game == null) return;
            try
            {
                var gameState = new TetrisPersistence.GameState
                {
                    Rows = game.Rows,
                    Cols = game.Cols,
                    Board = game.Board,
                    CurrentTetrominoIndex = game.CurrentTetrominoIndex,
                    CurrentBlock = game.CurrentBlock,
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
                    TetrisPersistence.Save(dialog.FileName, gameState);
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
                    var gameState = TetrisPersistence.Load(dialog.FileName);
                    if (gameState?.Board == null)
                    {
                        MessageBox.Show("Érvénytelen mentési fájl!", "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                    StopGame();
                    game = new TetrisGame(gameState.Rows, gameState.Cols);
                    SubscribeToGameEvents();
                    ((TetrisGame)game).Board = gameState.Board;
                    ((TetrisGame)game).CurrentTetrominoIndex = gameState.CurrentTetrominoIndex;
                    ((TetrisGame)game).CurrentBlock = gameState.CurrentBlock;
                    ((TetrisGame)game).BlockRow = gameState.BlockRow;
                    ((TetrisGame)game).BlockCol = gameState.BlockCol;
                    gameTimer.SetPausedTime(gameState.PausedTime);
                    switch (gameState.Cols)
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

        #endregion
    }
}
