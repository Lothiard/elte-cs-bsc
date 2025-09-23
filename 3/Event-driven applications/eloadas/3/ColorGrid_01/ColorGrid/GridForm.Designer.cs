namespace ELTE.ColorGrid
{
    partial class GridForm
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
            this._numericRows = new System.Windows.Forms.NumericUpDown();
            this._buttonSize = new System.Windows.Forms.Button();
            this._numericColumns = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this._TableLayoutMain = new System.Windows.Forms.TableLayoutPanel();
            this._tableLayoutGrid = new System.Windows.Forms.TableLayoutPanel();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this._numericRows)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this._numericColumns)).BeginInit();
            this._TableLayoutMain.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this._numericRows);
            this.groupBox1.Controls.Add(this._buttonSize);
            this.groupBox1.Controls.Add(this._numericColumns);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(3, 3);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(386, 40);
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Méret:";
            // 
            // _numericRows
            // 
            this._numericRows.Location = new System.Drawing.Point(50, 14);
            this._numericRows.Maximum = new decimal(new int[] {
            20,
            0,
            0,
            0});
            this._numericRows.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this._numericRows.Name = "_numericRows";
            this._numericRows.Size = new System.Drawing.Size(72, 20);
            this._numericRows.TabIndex = 4;
            this._numericRows.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // _buttonSize
            // 
            this._buttonSize.Location = new System.Drawing.Point(302, 11);
            this._buttonSize.Name = "_buttonSize";
            this._buttonSize.Size = new System.Drawing.Size(75, 23);
            this._buttonSize.TabIndex = 0;
            this._buttonSize.Text = "Méretváltás";
            this._buttonSize.UseVisualStyleBackColor = true;
            this._buttonSize.Click += new System.EventHandler(this.ButtonSize_Click);
            // 
            // _numericColumns
            // 
            this._numericColumns.Location = new System.Drawing.Point(201, 14);
            this._numericColumns.Maximum = new decimal(new int[] {
            20,
            0,
            0,
            0});
            this._numericColumns.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this._numericColumns.Name = "_numericColumns";
            this._numericColumns.Size = new System.Drawing.Size(72, 20);
            this._numericColumns.TabIndex = 3;
            this._numericColumns.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 18);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(38, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Sorok:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(141, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(54, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Oszlopok:";
            // 
            // _TableLayoutMain
            // 
            this._TableLayoutMain.ColumnCount = 1;
            this._TableLayoutMain.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this._TableLayoutMain.Controls.Add(this.groupBox1, 0, 0);
            this._TableLayoutMain.Controls.Add(this._tableLayoutGrid, 0, 1);
            this._TableLayoutMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this._TableLayoutMain.Location = new System.Drawing.Point(0, 0);
            this._TableLayoutMain.Name = "_TableLayoutMain";
            this._TableLayoutMain.RowCount = 2;
            this._TableLayoutMain.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 50F));
            this._TableLayoutMain.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this._TableLayoutMain.Size = new System.Drawing.Size(752, 519);
            this._TableLayoutMain.TabIndex = 3;
            // 
            // _tableLayoutGrid
            // 
            this._tableLayoutGrid.AutoSize = true;
            this._tableLayoutGrid.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this._tableLayoutGrid.ColumnCount = 2;
            this._tableLayoutGrid.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this._tableLayoutGrid.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this._tableLayoutGrid.Dock = System.Windows.Forms.DockStyle.Fill;
            this._tableLayoutGrid.GrowStyle = System.Windows.Forms.TableLayoutPanelGrowStyle.FixedSize;
            this._tableLayoutGrid.Location = new System.Drawing.Point(3, 53);
            this._tableLayoutGrid.Name = "_tableLayoutGrid";
            this._tableLayoutGrid.RowCount = 2;
            this._tableLayoutGrid.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this._tableLayoutGrid.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this._tableLayoutGrid.Size = new System.Drawing.Size(746, 463);
            this._tableLayoutGrid.TabIndex = 3;
            // 
            // GridForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(752, 519);
            this.Controls.Add(this._TableLayoutMain);
            this.MinimumSize = new System.Drawing.Size(410, 280);
            this.Name = "GridForm";
            this.Text = "Színrács";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this._numericRows)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this._numericColumns)).EndInit();
            this._TableLayoutMain.ResumeLayout(false);
            this._TableLayoutMain.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.NumericUpDown _numericRows;
        private System.Windows.Forms.Button _buttonSize;
        private System.Windows.Forms.NumericUpDown _numericColumns;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TableLayoutPanel _TableLayoutMain;
        private System.Windows.Forms.TableLayoutPanel _tableLayoutGrid;
    }
}

