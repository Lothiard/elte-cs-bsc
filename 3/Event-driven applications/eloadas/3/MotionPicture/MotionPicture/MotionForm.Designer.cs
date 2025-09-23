namespace ELTE.MotionPicture
{
    partial class MotionForm
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
            this._picutreBoxLarge = new System.Windows.Forms.PictureBox();
            this._buttonLoad = new System.Windows.Forms.Button();
            this._FolderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
            this._numericSmallImageCount = new System.Windows.Forms.NumericUpDown();
            this._buttonStartStop = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this._picutreBoxLarge)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this._numericSmallImageCount)).BeginInit();
            this.SuspendLayout();
            // 
            // _picutreBoxLarge
            // 
            this._picutreBoxLarge.BackColor = System.Drawing.SystemColors.Window;
            this._picutreBoxLarge.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this._picutreBoxLarge.Location = new System.Drawing.Point(3, 54);
            this._picutreBoxLarge.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._picutreBoxLarge.Name = "_picutreBoxLarge";
            this._picutreBoxLarge.Size = new System.Drawing.Size(400, 400);
            this._picutreBoxLarge.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this._picutreBoxLarge.TabIndex = 0;
            this._picutreBoxLarge.TabStop = false;
            // 
            // _buttonLoad
            // 
            this._buttonLoad.Location = new System.Drawing.Point(3, 9);
            this._buttonLoad.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._buttonLoad.Name = "_buttonLoad";
            this._buttonLoad.Size = new System.Drawing.Size(155, 35);
            this._buttonLoad.TabIndex = 1;
            this._buttonLoad.Text = "Load Pictures";
            this._buttonLoad.UseVisualStyleBackColor = true;
            this._buttonLoad.Click += new System.EventHandler(this.LoadButton_Click);
            // 
            // _numericSmallImageCount
            // 
            this._numericSmallImageCount.Location = new System.Drawing.Point(62, 466);
            this._numericSmallImageCount.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._numericSmallImageCount.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this._numericSmallImageCount.Name = "_numericSmallImageCount";
            this._numericSmallImageCount.Size = new System.Drawing.Size(75, 27);
            this._numericSmallImageCount.TabIndex = 2;
            this._numericSmallImageCount.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this._numericSmallImageCount.ValueChanged += new System.EventHandler(this.NumericSmallImageCount_ValueChanged);
            // 
            // _buttonStartStop
            // 
            this._buttonStartStop.Location = new System.Drawing.Point(267, 9);
            this._buttonStartStop.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._buttonStartStop.Name = "_buttonStartStop";
            this._buttonStartStop.Size = new System.Drawing.Size(136, 35);
            this._buttonStartStop.TabIndex = 3;
            this._buttonStartStop.Text = "Start / Stop";
            this._buttonStartStop.UseVisualStyleBackColor = true;
            this._buttonStartStop.Click += new System.EventHandler(this.StartStopButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(0, 468);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(54, 20);
            this.label1.TabIndex = 4;
            this.label1.Text = "Speed:";
            // 
            // MotionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(407, 623);
            this.Controls.Add(this.label1);
            this.Controls.Add(this._buttonStartStop);
            this.Controls.Add(this._numericSmallImageCount);
            this.Controls.Add(this._buttonLoad);
            this.Controls.Add(this._picutreBoxLarge);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MotionForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Motion Picture";
            ((System.ComponentModel.ISupportInitialize)(this._picutreBoxLarge)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this._numericSmallImageCount)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox _picutreBoxLarge;
        private System.Windows.Forms.Button _buttonLoad;
        private System.Windows.Forms.FolderBrowserDialog _FolderBrowserDialog;
        private System.Windows.Forms.NumericUpDown _numericSmallImageCount;
        private System.Windows.Forms.Button _buttonStartStop;
        private System.Windows.Forms.Label label1;
    }
}

