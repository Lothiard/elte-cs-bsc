namespace ELTE.FibonacciNumberGenerator.View
{
    partial class MainForm
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
            this._button = new System.Windows.Forms.Button();
            this._listBox = new System.Windows.Forms.ListBox();
            this._numericNumber = new System.Windows.Forms.NumericUpDown();
            ((System.ComponentModel.ISupportInitialize)(this._numericNumber)).BeginInit();
            this.SuspendLayout();
            // 
            // _button
            // 
            this._button.Location = new System.Drawing.Point(12, 191);
            this._button.Name = "_button";
            this._button.Size = new System.Drawing.Size(170, 23);
            this._button.TabIndex = 0;
            this._button.Text = "Generate";
            this._button.UseVisualStyleBackColor = true;
            this._button.Click += new System.EventHandler(this.ButtonGenerate_Click);
            // 
            // _listBox
            // 
            this._listBox.FormattingEnabled = true;
            this._listBox.Location = new System.Drawing.Point(12, 12);
            this._listBox.Name = "_listBox";
            this._listBox.Size = new System.Drawing.Size(260, 173);
            this._listBox.TabIndex = 1;
            // 
            // _numericNumber
            // 
            this._numericNumber.Location = new System.Drawing.Point(188, 194);
            this._numericNumber.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this._numericNumber.Name = "_numericNumber";
            this._numericNumber.Size = new System.Drawing.Size(84, 20);
            this._numericNumber.TabIndex = 2;
            this._numericNumber.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(277, 218);
            this.Controls.Add(this._numericNumber);
            this.Controls.Add(this._listBox);
            this.Controls.Add(this._button);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.Text = "Fibonacci generator";
            ((System.ComponentModel.ISupportInitialize)(this._numericNumber)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button _button;
        private System.Windows.Forms.ListBox _listBox;
        private System.Windows.Forms.NumericUpDown _numericNumber;
    }
}

