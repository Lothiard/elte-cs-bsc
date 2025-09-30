namespace ELTE.TicTacToeGame.View
{
    partial class TicTacToeForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this._tableLayoutPanel = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this._menuStrip = new System.Windows.Forms.MenuStrip();
            this._menuGame = new System.Windows.Forms.ToolStripMenuItem();
            this._menuGameNew = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this._menuGameLoad = new System.Windows.Forms.ToolStripMenuItem();
            this._menuGameSave = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem2 = new System.Windows.Forms.ToolStripSeparator();
            this._menuGameExit = new System.Windows.Forms.ToolStripMenuItem();
            this._saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this._openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.tableLayoutPanel1.SuspendLayout();
            this._menuStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // _tableLayoutPanel
            // 
            this._tableLayoutPanel.ColumnCount = 3;
            this._tableLayoutPanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this._tableLayoutPanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this._tableLayoutPanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this._tableLayoutPanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this._tableLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this._tableLayoutPanel.Location = new System.Drawing.Point(3, 27);
            this._tableLayoutPanel.Name = "_tableLayoutPanel";
            this._tableLayoutPanel.RowCount = 3;
            this._tableLayoutPanel.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this._tableLayoutPanel.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this._tableLayoutPanel.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this._tableLayoutPanel.Size = new System.Drawing.Size(278, 262);
            this._tableLayoutPanel.TabIndex = 0;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this._menuStrip, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this._tableLayoutPanel, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 24F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel1.Size = new System.Drawing.Size(284, 292);
            this.tableLayoutPanel1.TabIndex = 2;
            // 
            // _menuStrip
            // 
            this._menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._menuGame});
            this._menuStrip.Location = new System.Drawing.Point(0, 0);
            this._menuStrip.Name = "_menuStrip";
            this._menuStrip.Size = new System.Drawing.Size(284, 24);
            this._menuStrip.TabIndex = 1;
            this._menuStrip.Text = "menuStrip1";
            // 
            // _menuGame
            // 
            this._menuGame.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._menuGameNew,
            this.toolStripMenuItem1,
            this._menuGameLoad,
            this._menuGameSave,
            this.toolStripMenuItem2,
            this._menuGameExit});
            this._menuGame.Name = "_menuGame";
            this._menuGame.Size = new System.Drawing.Size(45, 20);
            this._menuGame.Text = "&Játék";
            // 
            // _menuGameNew
            // 
            this._menuGameNew.Name = "_menuGameNew";
            this._menuGameNew.Size = new System.Drawing.Size(125, 22);
            this._menuGameNew.Text = "Ú&j";
            this._menuGameNew.Click += new System.EventHandler(this.MenuGameNew_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(122, 6);
            // 
            // _menuGameLoad
            // 
            this._menuGameLoad.Name = "_menuGameLoad";
            this._menuGameLoad.Size = new System.Drawing.Size(125, 22);
            this._menuGameLoad.Text = "&Betöltés...";
            this._menuGameLoad.Click += new System.EventHandler(this.MenuGameLoad_Click);
            // 
            // _menuGameSave
            // 
            this._menuGameSave.Name = "_menuGameSave";
            this._menuGameSave.Size = new System.Drawing.Size(125, 22);
            this._menuGameSave.Text = "&Mentés...";
            this._menuGameSave.Click += new System.EventHandler(this.MenuGameSave_Click);
            // 
            // toolStripMenuItem2
            // 
            this.toolStripMenuItem2.Name = "toolStripMenuItem2";
            this.toolStripMenuItem2.Size = new System.Drawing.Size(122, 6);
            // 
            // _menuGameExit
            // 
            this._menuGameExit.Name = "_menuGameExit";
            this._menuGameExit.Size = new System.Drawing.Size(125, 22);
            this._menuGameExit.Text = "&Kilépés";
            this._menuGameExit.Click += new System.EventHandler(this.MenuGameExit_Click);
            // 
            // _saveFileDialog
            // 
            this._saveFileDialog.Filter = "Játékmentések|*.sav";
            this._saveFileDialog.Title = "Tic-Tac-Toe - Játék mentése";
            // 
            // _openFileDialog
            // 
            this._openFileDialog.Filter = "Játékmentések|*.sav";
            this._openFileDialog.Title = "Tic-Tac-Toe - Játék betöltése";
            // 
            // TicTacToeForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 292);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "TicTacToeForm";
            this.Text = "Tic-Tac-Toe";
            this.Load += new System.EventHandler(this.TicTacToeForm_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this._menuStrip.ResumeLayout(false);
            this._menuStrip.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel _tableLayoutPanel;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.MenuStrip _menuStrip;
        private System.Windows.Forms.ToolStripMenuItem _menuGame;
        private System.Windows.Forms.ToolStripMenuItem _menuGameNew;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem _menuGameLoad;
        private System.Windows.Forms.ToolStripMenuItem _menuGameSave;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem2;
        private System.Windows.Forms.ToolStripMenuItem _menuGameExit;
        private System.Windows.Forms.SaveFileDialog _saveFileDialog;
        private System.Windows.Forms.OpenFileDialog _openFileDialog;
    }
}

