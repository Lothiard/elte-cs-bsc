namespace ELTE.ExamGenerator.View
{
    partial class SettingsForm
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
            this._numericQuestionCount = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this._numericPeriodLength = new System.Windows.Forms.NumericUpDown();
            this.label2 = new System.Windows.Forms.Label();
            this._checkedListBox = new System.Windows.Forms.CheckedListBox();
            this._buttonCancel = new System.Windows.Forms.Button();
            this._buttonOk = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this._numericQuestionCount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this._numericPeriodLength)).BeginInit();
            this.SuspendLayout();
            // 
            // _numericQuestionCount
            // 
            this._numericQuestionCount.Location = new System.Drawing.Point(125, 5);
            this._numericQuestionCount.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._numericQuestionCount.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this._numericQuestionCount.Name = "_numericQuestionCount";
            this._numericQuestionCount.Size = new System.Drawing.Size(100, 27);
            this._numericQuestionCount.TabIndex = 2;
            this._numericQuestionCount.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 8);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 20);
            this.label1.TabIndex = 3;
            this.label1.Text = "Tételek száma:";
            // 
            // _numericPeriodLength
            // 
            this._numericPeriodLength.Location = new System.Drawing.Point(125, 45);
            this._numericPeriodLength.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._numericPeriodLength.Name = "_numericPeriodLength";
            this._numericPeriodLength.Size = new System.Drawing.Size(100, 27);
            this._numericPeriodLength.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 48);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(68, 20);
            this.label2.TabIndex = 5;
            this.label2.Text = "Periódus:";
            // 
            // _checkedListBox
            // 
            this._checkedListBox.FormattingEnabled = true;
            this._checkedListBox.Location = new System.Drawing.Point(16, 85);
            this._checkedListBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._checkedListBox.Name = "_checkedListBox";
            this._checkedListBox.Size = new System.Drawing.Size(208, 136);
            this._checkedListBox.TabIndex = 6;
            // 
            // _buttonCancel
            // 
            this._buttonCancel.Location = new System.Drawing.Point(16, 238);
            this._buttonCancel.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._buttonCancel.Name = "_buttonCancel";
            this._buttonCancel.Size = new System.Drawing.Size(100, 35);
            this._buttonCancel.TabIndex = 9;
            this._buttonCancel.Text = "Mégse";
            this._buttonCancel.UseVisualStyleBackColor = true;
            this._buttonCancel.Click += new System.EventHandler(this.ButtonCancel_Click);
            // 
            // _buttonOk
            // 
            this._buttonOk.Location = new System.Drawing.Point(125, 238);
            this._buttonOk.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this._buttonOk.Name = "_buttonOk";
            this._buttonOk.Size = new System.Drawing.Size(100, 35);
            this._buttonOk.TabIndex = 8;
            this._buttonOk.Text = "OK";
            this._buttonOk.UseVisualStyleBackColor = true;
            this._buttonOk.Click += new System.EventHandler(this.ButtonOk_Click);
            // 
            // SettingsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(233, 285);
            this.ControlBox = false;
            this.Controls.Add(this._buttonCancel);
            this.Controls.Add(this._buttonOk);
            this.Controls.Add(this._checkedListBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this._numericPeriodLength);
            this.Controls.Add(this.label1);
            this.Controls.Add(this._numericQuestionCount);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "SettingsForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Beállítások";
            ((System.ComponentModel.ISupportInitialize)(this._numericQuestionCount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this._numericPeriodLength)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.NumericUpDown _numericQuestionCount;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.NumericUpDown _numericPeriodLength;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckedListBox _checkedListBox;
        private System.Windows.Forms.Button _buttonCancel;
        private System.Windows.Forms.Button _buttonOk;
    }
}