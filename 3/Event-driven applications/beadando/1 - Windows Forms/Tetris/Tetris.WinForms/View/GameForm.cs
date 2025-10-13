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

        private const int _cellSize = 25;
        private Button[,] _gridButtons = null!;
        private TetrisGameModel _model = null!;
        private readonly System.Windows.Forms.Timer? _clockTimer;

        #endregion

        #region Constructors

        public GameForm()
        {
            InitializeComponent();

            this.KeyPreview = true;
            this.KeyDown += Form_KeyDown;

            cmbBoardSize.SelectedIndex = 1;
            _clockTimer = new System.Windows.Forms.Timer();
            _clockTimer.Interval = 100;
            _clockTimer.Tick += ClockTimer_Tick;
            
            btnPause.Enabled = false;
        }

        #endregion

        #region Game event handlers

        private void Form_Load(object sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }
        
        private void Game_GameStateChanged(object? sender, EventArgs e)
        {
            RefreshGrid();
        }
        
        private void Game_GameOver(object? sender, EventArgs e)
        {
            if (_model.IsGameOver)
            {
                ShowGameOverMessage();
            }
        }

        private void ClockTimer_Tick(object? sender, EventArgs e)
        {
            UpdateTimeDisplay();
        }

        #endregion

        #region Grid event handlers

        private void Form_KeyDown(object? sender, KeyEventArgs e)
        {
            if (_model == null || !_model.IsTimerRunning || _model.IsTimerPaused || _model.CurrentBlock == null) 
                return;
            
            switch (e.KeyCode)
            {
                case Keys.A:
                    _model.MoveLeft();
                    break;
                case Keys.D:
                    _model.MoveRight();
                    break;
                case Keys.S:
                    _model.MoveDown();
                    break;
                case Keys.W:
                    _model.Rotate();
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

            _model = new TetrisGameModel(rows, cols);
            SubscribeToGameEvents();
            InitializeGame();
            StartGame();
        }

        private void btnPause_Click(object sender, EventArgs e)
        {
            if (_model == null || !_model.IsTimerRunning) return;
            
            if (!_model.IsTimerPaused)
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
            if (_model == null) return;
            
            _model.GameStateChanged += Game_GameStateChanged;
            _model.GameOver += Game_GameOver;
        }
        
        private void UnsubscribeFromGameEvents()
        {
            if (_model == null) return;
            
            _model.GameStateChanged -= Game_GameStateChanged;
            _model.GameOver -= Game_GameOver;
        }

        private void InitializeGame()
        {
            if (_model == null) return;
            if (_gridButtons != null)
            {
                for (int row = 0; row < _gridButtons.GetLength(0); row++)
                {
                    for (int col = 0; col < _gridButtons.GetLength(1); col++)
                    {
                        panelGame.Controls.Remove(_gridButtons[row, col]);
                        _gridButtons[row, col].Dispose();
                    }
                }
            }
            _gridButtons = new Button[_model.Rows, _model.Cols];
            for (int row = 0; row < _model.Rows; row++)
            {
                for (int col = 0; col < _model.Cols; col++)
                {
                    var btn = new Button();
                    btn.Width = _cellSize;
                    btn.Height = _cellSize;
                    btn.Left = col * _cellSize;
                    btn.Top = row * _cellSize;
                    btn.Enabled = false;
                    btn.TabStop = false;
                    btn.FlatStyle = FlatStyle.Flat;
                    btn.Margin = new Padding(0);
                    btn.Padding = new Padding(0);
                    btn.BackColor = Color.Black;
                    btn.FlatAppearance.BorderColor = Color.Black;
                    btn.FlatAppearance.BorderSize = 1;
                    _gridButtons[row, col] = btn;
                    panelGame.Controls.Add(btn);
                }
            }
            panelGame.Size = new Size(_model.Cols * _cellSize + 2, _model.Rows * _cellSize + 2);
        }

        private void StartGame()
        {
            if (_model == null) return;
            
            _model.Reset();
            _model.StartTimer();
            
            btnNewGame.Text = "Új játék";
            btnPause.Text = "Szünet";
            btnPause.Enabled = true;
            btnSave.Enabled = false;
            btnLoad.Enabled = true;
            _clockTimer?.Start();
        }

        private void StopGame()
        {
            if (_model != null)
            {
                _model.StopTimer();
                UnsubscribeFromGameEvents();
            }
            
            _clockTimer?.Stop();
            
            btnPause.Text = "Szünet";
            btnPause.Enabled = false;
            btnSave.Enabled = false;
            btnLoad.Enabled = true;
        }

        private void PauseGame()
        {
            if (_model == null || !_model.IsTimerRunning || _model.IsTimerPaused) return;
            
            _model.PauseTimer();
            
            btnPause.Text = "Folytatás";
            btnSave.Enabled = true;
            btnLoad.Enabled = true;
        }

        private void ResumeGame()
        {
            if (_model == null || !_model.IsTimerRunning || !_model.IsTimerPaused) return;
            
            _model.ResumeTimer();
            
            btnPause.Text = "Szünet";
            btnSave.Enabled = false;
            btnLoad.Enabled = true;
        }

        private void UpdateTimeDisplay()
        {
            TimeSpan currentGameTime = (_model != null && _model.IsTimerRunning) ? _model.ElapsedTime : TimeSpan.Zero;
            lblTimeValue.Text = currentGameTime.ToString(@"hh\:mm\:ss");
        }

        private void RefreshGrid()
        {
            if (_gridButtons == null || _model == null) return;
            
            // Update the grid on the UI thread
            if (InvokeRequired)
            {
                Invoke(new Action(RefreshGrid));
                return;
            }
            
            for (int row = 0; row < _model.Rows; row++)
            {
                for (int col = 0; col < _model.Cols; col++)
                {
                    if (_model.Board[row, col] == 0)
                    {
                        _gridButtons[row, col].BackColor = Color.Black;
                    }
                    else
                    {
                        int tetrominoType = _model.Board[row, col] - 1;
                        if (tetrominoType >= 0 && tetrominoType < _model.TetrominoColors.Length)
                        {
                            _gridButtons[row, col].BackColor = _model.TetrominoColors[tetrominoType];
                        }
                    }
                }
            }
            
            if (_model.CurrentBlock != null)
            {
                Color color = _model.TetrominoColors[_model.CurrentTetrominoIndex];
                foreach (var (dr, dc) in _model.CurrentBlock)
                {
                    int r = _model.BlockRow + dr;
                    int c = _model.BlockCol + dc;
                    if (r >= 0 && r < _model.Rows && c >= 0 && c < _model.Cols && _model.Board[r, c] == 0)
                    {
                        _gridButtons[r, c].BackColor = color;
                    }
                }
            }
        }

        private void ShowGameOverMessage()
        {
            TimeSpan totalTime = _model.ElapsedTime;
            
            StopGame();
            
            string timeString = totalTime.ToString(@"hh\:mm\:ss");
            MessageBox.Show($"Játék vége!\n\nJátékidő: {timeString}", "Tetris", 
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private async Task SaveGameAsync()
        {
            if (_model == null || !_model.IsTimerPaused) return;
            
            try
            {
                var gameState = new TetrisPersistence.GameState
                {
                    Rows = _model.Rows,
                    Cols = _model.Cols,
                    Board = _model.Board,
                    CurrentTetrominoIndex = _model.CurrentTetrominoIndex,
                    CurrentBlock = _model.CurrentBlock!,
                    BlockRow = _model.BlockRow,
                    BlockCol = _model.BlockCol,
                    PausedTime = _model.ElapsedTime,
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
                    
                    _model = new TetrisGameModel(gameState.Rows, gameState.Cols);
                    
                    switch (gameState.Cols)
                    {
                        case 4: cmbBoardSize.SelectedIndex = 0; break;
                        case 8: cmbBoardSize.SelectedIndex = 1; break;
                        case 12: cmbBoardSize.SelectedIndex = 2; break;
                    }
                    
                    InitializeGame();
                    
                    _model.Board = gameState.Board;
                    _model.CurrentTetrominoIndex = gameState.CurrentTetrominoIndex;
                    _model.CurrentBlock = gameState.CurrentBlock;
                    _model.BlockRow = gameState.BlockRow;
                    _model.BlockCol = gameState.BlockCol;
                    
                    SubscribeToGameEvents();
                    
                    _model.SetTimerPausedTime(gameState.PausedTime);
                    _model.StartTimer();
                    
                    btnNewGame.Text = "Új játék";
                    btnPause.Text = "Szünet";
                    btnPause.Enabled = true;
                    btnSave.Enabled = false;
                    btnLoad.Enabled = true;
                    _clockTimer?.Start();
                    
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
