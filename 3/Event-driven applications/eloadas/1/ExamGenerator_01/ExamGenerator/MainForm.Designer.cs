namespace ELTE.ExamGenerator
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
            this._textNumber = new System.Windows.Forms.TextBox();
            this._buttonStart = new System.Windows.Forms.Button();
            this._buttonSet = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // _textNumber
            // 
            this._textNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 48F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._textNumber.Location = new System.Drawing.Point(12, 12);
            this._textNumber.Name = "_textNumber";
            this._textNumber.ReadOnly = true;
            this._textNumber.Size = new System.Drawing.Size(181, 80);
            this._textNumber.TabIndex = 1;
            this._textNumber.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // _buttonStart
            // 
            this._buttonStart.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._buttonStart.Location = new System.Drawing.Point(12, 98);
            this._buttonStart.Name = "_buttonStart";
            this._buttonStart.Size = new System.Drawing.Size(181, 43);
            this._buttonStart.TabIndex = 0;
            this._buttonStart.Text = "START";
            this._buttonStart.UseVisualStyleBackColor = true;
            this._buttonStart.Click += new System.EventHandler(this.ButtonStart_Click);
            // 
            // _buttonSet
            // 
            this._buttonSet.Location = new System.Drawing.Point(12, 147);
            this._buttonSet.Name = "_buttonSet";
            this._buttonSet.Size = new System.Drawing.Size(75, 23);
            this._buttonSet.TabIndex = 2;
            this._buttonSet.Text = "Beállít";
            this._buttonSet.UseVisualStyleBackColor = true;
            this._buttonSet.Click += new System.EventHandler(this.ButtonSet_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(199, 178);
            this.Controls.Add(this._buttonSet);
            this.Controls.Add(this._buttonStart);
            this.Controls.Add(this._textNumber);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.Text = "Tétel húzás";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox _textNumber;
        private System.Windows.Forms.Button _buttonStart;
        private System.Windows.Forms.Button _buttonSet;
    }
}

