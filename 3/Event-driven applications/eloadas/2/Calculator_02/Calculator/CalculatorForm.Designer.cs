namespace ELTE.Calculator
{
    partial class CalculatorForm
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
            this._buttonPlus = new System.Windows.Forms.Button();
            this._buttonMinus = new System.Windows.Forms.Button();
            this._buttonMultiply = new System.Windows.Forms.Button();
            this._buttonDivide = new System.Windows.Forms.Button();
            this._buttonEqual = new System.Windows.Forms.Button();
            this._listHistory = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // _textNumber
            // 
            this._textNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._textNumber.Location = new System.Drawing.Point(2, 3);
            this._textNumber.Name = "_textNumber";
            this._textNumber.Size = new System.Drawing.Size(244, 26);
            this._textNumber.TabIndex = 0;
            this._textNumber.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // _buttonPlus
            // 
            this._buttonPlus.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._buttonPlus.Location = new System.Drawing.Point(2, 35);
            this._buttonPlus.Name = "_buttonPlus";
            this._buttonPlus.Size = new System.Drawing.Size(50, 50);
            this._buttonPlus.TabIndex = 1;
            this._buttonPlus.Text = "+";
            this._buttonPlus.UseVisualStyleBackColor = true;
            this._buttonPlus.Click += new System.EventHandler(this.Button_Click);
            // 
            // _buttonMinus
            // 
            this._buttonMinus.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._buttonMinus.Location = new System.Drawing.Point(58, 35);
            this._buttonMinus.Name = "_buttonMinus";
            this._buttonMinus.Size = new System.Drawing.Size(50, 50);
            this._buttonMinus.TabIndex = 2;
            this._buttonMinus.Text = "-";
            this._buttonMinus.UseVisualStyleBackColor = true;
            this._buttonMinus.Click += new System.EventHandler(this.Button_Click);
            // 
            // _buttonMultiply
            // 
            this._buttonMultiply.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._buttonMultiply.Location = new System.Drawing.Point(2, 91);
            this._buttonMultiply.Name = "_buttonMultiply";
            this._buttonMultiply.Size = new System.Drawing.Size(50, 50);
            this._buttonMultiply.TabIndex = 3;
            this._buttonMultiply.Text = "*";
            this._buttonMultiply.UseVisualStyleBackColor = true;
            this._buttonMultiply.Click += new System.EventHandler(this.Button_Click);
            // 
            // _buttonDivide
            // 
            this._buttonDivide.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._buttonDivide.Location = new System.Drawing.Point(58, 91);
            this._buttonDivide.Name = "_buttonDivide";
            this._buttonDivide.Size = new System.Drawing.Size(50, 50);
            this._buttonDivide.TabIndex = 4;
            this._buttonDivide.Text = "/";
            this._buttonDivide.UseVisualStyleBackColor = true;
            this._buttonDivide.Click += new System.EventHandler(this.Button_Click);
            // 
            // _buttonEqual
            // 
            this._buttonEqual.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this._buttonEqual.Location = new System.Drawing.Point(2, 147);
            this._buttonEqual.Name = "_buttonEqual";
            this._buttonEqual.Size = new System.Drawing.Size(106, 50);
            this._buttonEqual.TabIndex = 5;
            this._buttonEqual.Text = "=";
            this._buttonEqual.UseVisualStyleBackColor = true;
            this._buttonEqual.Click += new System.EventHandler(this.Button_Click);
            // 
            // _listHistory
            // 
            this._listHistory.FormattingEnabled = true;
            this._listHistory.Location = new System.Drawing.Point(114, 35);
            this._listHistory.Name = "_listHistory";
            this._listHistory.Size = new System.Drawing.Size(132, 160);
            this._listHistory.TabIndex = 6;
            // 
            // CalculatorForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(249, 198);
            this.Controls.Add(this._listHistory);
            this.Controls.Add(this._buttonEqual);
            this.Controls.Add(this._buttonDivide);
            this.Controls.Add(this._buttonMultiply);
            this.Controls.Add(this._buttonMinus);
            this.Controls.Add(this._buttonPlus);
            this.Controls.Add(this._textNumber);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "CalculatorForm";
            this.Text = "Calculator";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox _textNumber;
        private System.Windows.Forms.Button _buttonPlus;
        private System.Windows.Forms.Button _buttonMinus;
        private System.Windows.Forms.Button _buttonMultiply;
        private System.Windows.Forms.Button _buttonDivide;
        private System.Windows.Forms.Button _buttonEqual;
        private System.Windows.Forms.ListBox _listHistory;
    }
}

