namespace Tetris.WinForms.View
{
    partial class GameForm
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            panelGame = new System.Windows.Forms.Panel();
            panelControls = new System.Windows.Forms.Panel();
            btnNewGame = new System.Windows.Forms.Button();
            btnPause = new System.Windows.Forms.Button();
            btnSave = new System.Windows.Forms.Button();
            btnLoad = new System.Windows.Forms.Button();
            lblTime = new System.Windows.Forms.Label();
            lblTimeValue = new System.Windows.Forms.Label();
            cmbBoardSize = new System.Windows.Forms.ComboBox();
            lblBoardSize = new System.Windows.Forms.Label();
            SuspendLayout();
            // 
            // panelGame
            // 
            panelGame.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            panelGame.Location = new System.Drawing.Point(12, 12);
            panelGame.Name = "panelGame";
            panelGame.Size = new System.Drawing.Size(300, 600);
            panelGame.TabIndex = 0;
            // 
            // panelControls
            // 
            panelControls.Controls.Add(lblTimeValue);
            panelControls.Controls.Add(lblTime);
            panelControls.Controls.Add(btnLoad);
            panelControls.Controls.Add(btnSave);
            panelControls.Controls.Add(btnPause);
            panelControls.Controls.Add(cmbBoardSize);
            panelControls.Controls.Add(lblBoardSize);
            panelControls.Controls.Add(btnNewGame);
            panelControls.Location = new System.Drawing.Point(330, 12);
            panelControls.Name = "panelControls";
            panelControls.Size = new System.Drawing.Size(200, 600);
            panelControls.TabIndex = 1;
            // 
            // btnNewGame
            // 
            btnNewGame.Location = new System.Drawing.Point(15, 50);
            btnNewGame.Name = "btnNewGame";
            btnNewGame.Size = new System.Drawing.Size(170, 30);
            btnNewGame.TabIndex = 0;
            btnNewGame.Text = "Új játék";
            btnNewGame.UseVisualStyleBackColor = true;
            btnNewGame.Click += btnNewGame_Click;
            // 
            // btnPause
            // 
            btnPause.Location = new System.Drawing.Point(15, 100);
            btnPause.Name = "btnPause";
            btnPause.Size = new System.Drawing.Size(170, 30);
            btnPause.TabIndex = 1;
            btnPause.Text = "Szünet";
            btnPause.UseVisualStyleBackColor = true;
            btnPause.Click += btnPause_Click;
            // 
            // btnSave
            // 
            btnSave.Enabled = false;
            btnSave.Location = new System.Drawing.Point(15, 150);
            btnSave.Name = "btnSave";
            btnSave.Size = new System.Drawing.Size(170, 30);
            btnSave.TabIndex = 2;
            btnSave.Text = "Mentés";
            btnSave.UseVisualStyleBackColor = true;
            btnSave.Click += btnSave_Click;
            // 
            // btnLoad
            // 
            btnLoad.Location = new System.Drawing.Point(15, 200);
            btnLoad.Name = "btnLoad";
            btnLoad.Size = new System.Drawing.Size(170, 30);
            btnLoad.TabIndex = 3;
            btnLoad.Text = "Betöltés";
            btnLoad.UseVisualStyleBackColor = true;
            btnLoad.Click += btnLoad_Click;
            // 
            // lblTime
            // 
            lblTime.AutoSize = true;
            lblTime.Location = new System.Drawing.Point(15, 270);
            lblTime.Name = "lblTime";
            lblTime.Size = new System.Drawing.Size(62, 15);
            lblTime.TabIndex = 4;
            lblTime.Text = "Játékidő:";
            // 
            // lblTimeValue
            // 
            lblTimeValue.AutoSize = true;
            lblTimeValue.Location = new System.Drawing.Point(83, 270);
            lblTimeValue.Name = "lblTimeValue";
            lblTimeValue.Size = new System.Drawing.Size(49, 15);
            lblTimeValue.TabIndex = 5;
            lblTimeValue.Text = "00:00:00";
            // 
            // cmbBoardSize
            // 
            cmbBoardSize.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cmbBoardSize.FormattingEnabled = true;
            cmbBoardSize.Items.AddRange(new object[] { "4×16", "8×16", "12×16" });
            cmbBoardSize.Location = new System.Drawing.Point(15, 21);
            cmbBoardSize.Name = "cmbBoardSize";
            cmbBoardSize.Size = new System.Drawing.Size(170, 23);
            cmbBoardSize.TabIndex = 6;
            // 
            // lblBoardSize
            // 
            lblBoardSize.AutoSize = true;
            lblBoardSize.Location = new System.Drawing.Point(15, 3);
            lblBoardSize.Name = "lblBoardSize";
            lblBoardSize.Size = new System.Drawing.Size(79, 15);
            lblBoardSize.TabIndex = 7;
            lblBoardSize.Text = "Pályaméret:";
            // 
            // GameForm
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(550, 650);
            Controls.Add(panelControls);
            Controls.Add(panelGame);
            FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            Name = "GameForm";
            Text = "Tetris";
            Load += Form_Load;
            panelControls.ResumeLayout(false);
            panelControls.PerformLayout();
            ResumeLayout(false);
        }

        #endregion

        private System.Windows.Forms.Panel panelGame;
        private System.Windows.Forms.Panel panelControls;
        private System.Windows.Forms.Button btnNewGame;
        private System.Windows.Forms.Button btnPause;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnLoad;
        private System.Windows.Forms.Label lblTime;
        private System.Windows.Forms.Label lblTimeValue;
        private System.Windows.Forms.ComboBox cmbBoardSize;
        private System.Windows.Forms.Label lblBoardSize;
    }
}
