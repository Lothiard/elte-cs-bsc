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
            this._lbxResults = new System.Windows.Forms.ListBox();
            this._btnCalculate = new System.Windows.Forms.Button();
            this._nupN = new System.Windows.Forms.NumericUpDown();
            ((System.ComponentModel.ISupportInitialize)(this._nupN)).BeginInit();
            this.SuspendLayout();
            // 
            // _lbxResults
            // 
            this._lbxResults.Dock = System.Windows.Forms.DockStyle.Bottom;
            this._lbxResults.FormattingEnabled = true;
            this._lbxResults.Location = new System.Drawing.Point(0, 37);
            this._lbxResults.Name = "_lbxResults";
            this._lbxResults.Size = new System.Drawing.Size(684, 225);
            this._lbxResults.TabIndex = 2;
            // 
            // _btnCalculate
            // 
            this._btnCalculate.Location = new System.Drawing.Point(81, 5);
            this._btnCalculate.Name = "_btnCalculate";
            this._btnCalculate.Size = new System.Drawing.Size(98, 23);
            this._btnCalculate.TabIndex = 1;
            this._btnCalculate.Text = "Számol";
            this._btnCalculate.UseVisualStyleBackColor = true;
            this._btnCalculate.Click += new System.EventHandler(this.StartStop);
            // 
            // _nupN
            // 
            this._nupN.Location = new System.Drawing.Point(12, 8);
            this._nupN.Maximum = new decimal(new int[] {
                500,
                0,
                0,
                0});
            this._nupN.Minimum = new decimal(new int[] {
                1,
                0,
                0,
                0});
            this._nupN.Name = "_nupN";
            this._nupN.Size = new System.Drawing.Size(63, 20);
            this._nupN.TabIndex = 0;
            this._nupN.Value = new decimal(new int[] {
                100,
                0,
                0,
                0});
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(684, 262);
            this.Controls.Add(this._nupN);
            this.Controls.Add(this._btnCalculate);
            this.Controls.Add(this._lbxResults);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.Text = "Fibonacci Calculator";
            ((System.ComponentModel.ISupportInitialize)(this._nupN)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ListBox _lbxResults;
        private System.Windows.Forms.Button _btnCalculate;
        private System.Windows.Forms.NumericUpDown _nupN;
    }
}

