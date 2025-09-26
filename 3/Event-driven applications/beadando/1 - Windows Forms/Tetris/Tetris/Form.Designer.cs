namespace Tetris
{
    partial class Form
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            panelGame = new Panel();
            panelControls = new Panel();
            btnNewGame = new Button();
            btnPause = new Button();
            btnSave = new Button();
            btnLoad = new Button();
            lblTime = new Label();
            lblTimeValue = new Label();
            cmbBoardSize = new ComboBox();
            lblBoardSize = new Label();
            SuspendLayout();
            // 
            // panelGame
            // 
            panelGame.BorderStyle = BorderStyle.FixedSingle;
            panelGame.Location = new Point(12, 12);
            panelGame.Name = "panelGame";
            panelGame.Size = new Size(300, 600);
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
            panelControls.Location = new Point(330, 12);
            panelControls.Name = "panelControls";
            panelControls.Size = new Size(200, 600);
            panelControls.TabIndex = 1;
            // 
            // btnNewGame
            // 
            btnNewGame.Location = new Point(15, 50);
            btnNewGame.Name = "btnNewGame";
            btnNewGame.Size = new Size(170, 30);
            btnNewGame.TabIndex = 0;
            btnNewGame.Text = "Új játék";
            btnNewGame.UseVisualStyleBackColor = true;
            btnNewGame.Click += btnNewGame_Click;
            // 
            // btnPause
            // 
            btnPause.Location = new Point(15, 100);
            btnPause.Name = "btnPause";
            btnPause.Size = new Size(170, 30);
            btnPause.TabIndex = 1;
            btnPause.Text = "Szünet";
            btnPause.UseVisualStyleBackColor = true;
            btnPause.Click += btnPause_Click;
            // 
            // btnSave
            // 
            btnSave.Enabled = false;
            btnSave.Location = new Point(15, 150);
            btnSave.Name = "btnSave";
            btnSave.Size = new Size(170, 30);
            btnSave.TabIndex = 2;
            btnSave.Text = "Mentés";
            btnSave.UseVisualStyleBackColor = true;
            btnSave.Click += btnSave_Click;
            // 
            // btnLoad
            // 
            btnLoad.Location = new Point(15, 200);
            btnLoad.Name = "btnLoad";
            btnLoad.Size = new Size(170, 30);
            btnLoad.TabIndex = 3;
            btnLoad.Text = "Betöltés";
            btnLoad.UseVisualStyleBackColor = true;
            btnLoad.Click += btnLoad_Click;
            // 
            // lblTime
            // 
            lblTime.AutoSize = true;
            lblTime.Location = new Point(15, 270);
            lblTime.Name = "lblTime";
            lblTime.Size = new Size(62, 15);
            lblTime.TabIndex = 4;
            lblTime.Text = "Játékidő:";
            // 
            // lblTimeValue
            // 
            lblTimeValue.AutoSize = true;
            lblTimeValue.Location = new Point(83, 270);
            lblTimeValue.Name = "lblTimeValue";
            lblTimeValue.Size = new Size(49, 15);
            lblTimeValue.TabIndex = 5;
            lblTimeValue.Text = "00:00:00";
            // 
            // cmbBoardSize
            // 
            cmbBoardSize.DropDownStyle = ComboBoxStyle.DropDownList;
            cmbBoardSize.FormattingEnabled = true;
            cmbBoardSize.Items.AddRange(new object[] { "4×16", "8×16", "12×16" });
            cmbBoardSize.Location = new Point(15, 21);
            cmbBoardSize.Name = "cmbBoardSize";
            cmbBoardSize.Size = new Size(170, 23);
            cmbBoardSize.TabIndex = 6;
            // 
            // lblBoardSize
            // 
            lblBoardSize.AutoSize = true;
            lblBoardSize.Location = new Point(15, 3);
            lblBoardSize.Name = "lblBoardSize";
            lblBoardSize.Size = new Size(79, 15);
            lblBoardSize.TabIndex = 7;
            lblBoardSize.Text = "Pályaméret:";
            // 
            // Form
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(550, 650);
            Controls.Add(panelControls);
            Controls.Add(panelGame);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            Name = "Form";
            Text = "Tetris";
            Load += Form_Load;
            panelControls.ResumeLayout(false);
            panelControls.PerformLayout();
            ResumeLayout(false);
        }

        #endregion

        private Panel panelGame;
        private Panel panelControls;
        private Button btnNewGame;
        private Button btnPause;
        private Button btnSave;
        private Button btnLoad;
        private Label lblTime;
        private Label lblTimeValue;
        private ComboBox cmbBoardSize;
        private Label lblBoardSize;
    }
}
