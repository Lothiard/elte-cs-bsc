namespace StopwatchWindowsForms
{
    partial class Stopwatch
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
            this.components = new System.ComponentModel.Container();
            this.clickButton = new System.Windows.Forms.Button();
            this.lcd = new System.Windows.Forms.TextBox();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.zeroButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // clickButton
            // 
            this.clickButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.clickButton.Location = new System.Drawing.Point(44, 135);
            this.clickButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.clickButton.Name = "clickButton";
            this.clickButton.Size = new System.Drawing.Size(128, 55);
            this.clickButton.TabIndex = 0;
            this.clickButton.Text = "Start/Stop";
            this.clickButton.UseVisualStyleBackColor = true;
            this.clickButton.Click += new System.EventHandler(this.clickButton_Click);
            // 
            // lcd
            // 
            this.lcd.Font = new System.Drawing.Font("Microsoft Sans Serif", 40F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.lcd.Location = new System.Drawing.Point(44, 34);
            this.lcd.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.lcd.Name = "lcd";
            this.lcd.Size = new System.Drawing.Size(231, 83);
            this.lcd.TabIndex = 1;
            this.lcd.Text = "00:00";
            this.lcd.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // timer
            // 
            this.timer.Interval = 1000;
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
            // 
            // zeroButton
            // 
            this.zeroButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.zeroButton.Location = new System.Drawing.Point(189, 136);
            this.zeroButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.zeroButton.Name = "zeroButton";
            this.zeroButton.Size = new System.Drawing.Size(86, 54);
            this.zeroButton.TabIndex = 2;
            this.zeroButton.Text = "Reset";
            this.zeroButton.UseVisualStyleBackColor = true;
            this.zeroButton.Click += new System.EventHandler(this.zeroButton_Click);
            // 
            // Stopwatch
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(322, 229);
            this.Controls.Add(this.zeroButton);
            this.Controls.Add(this.lcd);
            this.Controls.Add(this.clickButton);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "Stopwatch";
            this.Text = "Stopwatch";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.MainForm_FormClosed);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        
        private System.Windows.Forms.TextBox lcd;
        private System.Windows.Forms.Timer timer;
        private System.Windows.Forms.Button clickButton;
        private System.Windows.Forms.Button zeroButton;
    }
}

