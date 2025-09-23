namespace ELTE.VectorDrawing.View
{
    partial class DrawingForm
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this._radioTriangle = new System.Windows.Forms.RadioButton();
            this._radioEllipse = new System.Windows.Forms.RadioButton();
            this._buttonClear = new System.Windows.Forms.Button();
            this._radioRectangle = new System.Windows.Forms.RadioButton();
            this._panel = new System.Windows.Forms.Panel();
            this._menuStrip = new System.Windows.Forms.MenuStrip();
            this._menuImage = new System.Windows.Forms.ToolStripMenuItem();
            this._menuImageLoad = new System.Windows.Forms.ToolStripMenuItem();
            this._menuImageSave = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this._menuImageClear = new System.Windows.Forms.ToolStripMenuItem();
            this._tableLayout = new System.Windows.Forms.TableLayoutPanel();
            this._openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this._saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.groupBox1.SuspendLayout();
            this._menuStrip.SuspendLayout();
            this._tableLayout.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this._radioTriangle);
            this.groupBox1.Controls.Add(this._radioEllipse);
            this.groupBox1.Controls.Add(this._buttonClear);
            this.groupBox1.Controls.Add(this._radioRectangle);
            this.groupBox1.Location = new System.Drawing.Point(4, 637);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox1.Size = new System.Drawing.Size(888, 67);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            // 
            // _radioTriangle
            // 
            this._radioTriangle.AutoSize = true;
            this._radioTriangle.Location = new System.Drawing.Point(195, 29);
            this._radioTriangle.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._radioTriangle.Name = "_radioTriangle";
            this._radioTriangle.Size = new System.Drawing.Size(107, 24);
            this._radioTriangle.TabIndex = 2;
            this._radioTriangle.TabStop = true;
            this._radioTriangle.Text = "Háromszög";
            this._radioTriangle.UseVisualStyleBackColor = true;
            // 
            // _radioEllipse
            // 
            this._radioEllipse.AutoSize = true;
            this._radioEllipse.Location = new System.Drawing.Point(105, 29);
            this._radioEllipse.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._radioEllipse.Name = "_radioEllipse";
            this._radioEllipse.Size = new System.Drawing.Size(82, 24);
            this._radioEllipse.TabIndex = 1;
            this._radioEllipse.TabStop = true;
            this._radioEllipse.Text = "Ellipszis";
            this._radioEllipse.UseVisualStyleBackColor = true;
            // 
            // _buttonClear
            // 
            this._buttonClear.Dock = System.Windows.Forms.DockStyle.Right;
            this._buttonClear.Location = new System.Drawing.Point(784, 25);
            this._buttonClear.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._buttonClear.Name = "_buttonClear";
            this._buttonClear.Size = new System.Drawing.Size(100, 37);
            this._buttonClear.TabIndex = 5;
            this._buttonClear.Text = "Törlés";
            this._buttonClear.UseVisualStyleBackColor = true;
            this._buttonClear.Click += new System.EventHandler(this.ButtonClear_Click);
            // 
            // _radioRectangle
            // 
            this._radioRectangle.AutoSize = true;
            this._radioRectangle.Location = new System.Drawing.Point(8, 29);
            this._radioRectangle.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._radioRectangle.Name = "_radioRectangle";
            this._radioRectangle.Size = new System.Drawing.Size(87, 24);
            this._radioRectangle.TabIndex = 0;
            this._radioRectangle.TabStop = true;
            this._radioRectangle.Text = "Téglalap";
            this._radioRectangle.UseVisualStyleBackColor = true;
            // 
            // _panel
            // 
            this._panel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this._panel.Dock = System.Windows.Forms.DockStyle.Fill;
            this._panel.Location = new System.Drawing.Point(4, 40);
            this._panel.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._panel.Name = "_panel";
            this._panel.Size = new System.Drawing.Size(888, 587);
            this._panel.TabIndex = 3;
            this._panel.Paint += new System.Windows.Forms.PaintEventHandler(this.Panel_Paint);
            // 
            // _menuStrip
            // 
            this._menuStrip.ImageScalingSize = new System.Drawing.Size(20, 20);
            this._menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._menuImage});
            this._menuStrip.Location = new System.Drawing.Point(0, 0);
            this._menuStrip.Name = "_menuStrip";
            this._menuStrip.Padding = new System.Windows.Forms.Padding(8, 3, 0, 3);
            this._menuStrip.Size = new System.Drawing.Size(896, 30);
            this._menuStrip.TabIndex = 0;
            this._menuStrip.Text = "menuStrip1";
            // 
            // _menuImage
            // 
            this._menuImage.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._menuImageLoad,
            this._menuImageSave,
            this.toolStripMenuItem1,
            this._menuImageClear});
            this._menuImage.Name = "_menuImage";
            this._menuImage.Size = new System.Drawing.Size(49, 24);
            this._menuImage.Text = "&Kép";
            // 
            // _menuImageLoad
            // 
            this._menuImageLoad.Name = "_menuImageLoad";
            this._menuImageLoad.Size = new System.Drawing.Size(146, 26);
            this._menuImageLoad.Text = "&Betöltés";
            this._menuImageLoad.Click += new System.EventHandler(this.MenuImageLoad_Click);
            // 
            // _menuImageSave
            // 
            this._menuImageSave.Name = "_menuImageSave";
            this._menuImageSave.Size = new System.Drawing.Size(146, 26);
            this._menuImageSave.Text = "&Mentés";
            this._menuImageSave.Click += new System.EventHandler(this.MenuImageSave_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(143, 6);
            // 
            // _menuImageClear
            // 
            this._menuImageClear.Name = "_menuImageClear";
            this._menuImageClear.Size = new System.Drawing.Size(146, 26);
            this._menuImageClear.Text = "&Törlés";
            this._menuImageClear.Click += new System.EventHandler(this.MenuImageClear_Click);
            // 
            // _tableLayout
            // 
            this._tableLayout.AutoSize = true;
            this._tableLayout.ColumnCount = 1;
            this._tableLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this._tableLayout.Controls.Add(this._menuStrip, 0, 0);
            this._tableLayout.Controls.Add(this.groupBox1, 0, 2);
            this._tableLayout.Controls.Add(this._panel, 0, 1);
            this._tableLayout.Dock = System.Windows.Forms.DockStyle.Fill;
            this._tableLayout.Location = new System.Drawing.Point(0, 0);
            this._tableLayout.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._tableLayout.Name = "_tableLayout";
            this._tableLayout.RowCount = 3;
            this._tableLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35F));
            this._tableLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this._tableLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 77F));
            this._tableLayout.Size = new System.Drawing.Size(896, 709);
            this._tableLayout.TabIndex = 5;
            // 
            // _openFileDialog
            // 
            this._openFileDialog.Filter = "Vector images|*.img";
            this._openFileDialog.Title = "Kép betöltése";
            // 
            // _saveFileDialog
            // 
            this._saveFileDialog.Filter = "Vector images|*.img";
            this._saveFileDialog.Title = "Kép mentése";
            // 
            // DrawingForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(896, 709);
            this.Controls.Add(this._tableLayout);
            this.MainMenuStrip = this._menuStrip;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MinimumSize = new System.Drawing.Size(794, 590);
            this.Name = "DrawingForm";
            this.Text = "Rajzolóprogram";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this._menuStrip.ResumeLayout(false);
            this._menuStrip.PerformLayout();
            this._tableLayout.ResumeLayout(false);
            this._tableLayout.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton _radioTriangle;
        private System.Windows.Forms.RadioButton _radioEllipse;
        private System.Windows.Forms.RadioButton _radioRectangle;
        private System.Windows.Forms.Panel _panel;
        private System.Windows.Forms.TableLayoutPanel _tableLayout;
        private System.Windows.Forms.Button _buttonClear;
        private System.Windows.Forms.MenuStrip _menuStrip;
        private System.Windows.Forms.ToolStripMenuItem _menuImage;
        private System.Windows.Forms.ToolStripMenuItem _menuImageLoad;
        private System.Windows.Forms.ToolStripMenuItem _menuImageSave;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem _menuImageClear;
        private System.Windows.Forms.OpenFileDialog _openFileDialog;
        private System.Windows.Forms.SaveFileDialog _saveFileDialog;
    }
}

