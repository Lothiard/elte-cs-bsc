
namespace ELTE.DigiClock
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.digiClock1 = new global::ELTE.DigiClock.Clock();
            this.digiClock2 = new global::ELTE.DigiClock.Clock();
            this.digiClock3 = new global::ELTE.DigiClock.Clock();
            this.digiClock4 = new global::ELTE.DigiClock.Clock();
            this.flowLayoutPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.digiClock1);
            this.flowLayoutPanel1.Controls.Add(this.digiClock2);
            this.flowLayoutPanel1.Controls.Add(this.digiClock3);
            this.flowLayoutPanel1.Controls.Add(this.digiClock4);
            this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(782, 303);
            this.flowLayoutPanel1.TabIndex = 0;
            // 
            // digiClock1
            // 
            this.digiClock1.City = "Budapest";
            this.digiClock1.Location = new System.Drawing.Point(3, 3);
            this.digiClock1.Name = "digiClock1";
            this.digiClock1.Size = new System.Drawing.Size(188, 116);
            this.digiClock1.TabIndex = 1;
            this.digiClock1.TimeZone = 0;
            // 
            // digiClock2
            // 
            this.digiClock2.City = "London";
            this.digiClock2.Location = new System.Drawing.Point(197, 3);
            this.digiClock2.Name = "digiClock2";
            this.digiClock2.Size = new System.Drawing.Size(188, 116);
            this.digiClock2.TabIndex = 2;
            this.digiClock2.TimeZone = -1;
            // 
            // digiClock3
            // 
            this.digiClock3.City = "Tokyo";
            this.digiClock3.Location = new System.Drawing.Point(391, 3);
            this.digiClock3.Name = "digiClock3";
            this.digiClock3.Size = new System.Drawing.Size(188, 116);
            this.digiClock3.TabIndex = 3;
            this.digiClock3.TimeZone = 8;
            // 
            // digiClock4
            // 
            this.digiClock4.City = "Wellington";
            this.digiClock4.Location = new System.Drawing.Point(585, 3);
            this.digiClock4.Name = "digiClock4";
            this.digiClock4.Size = new System.Drawing.Size(188, 116);
            this.digiClock4.TabIndex = 4;
            this.digiClock4.TimeZone = 11;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(782, 303);
            this.Controls.Add(this.flowLayoutPanel1);
            this.MinimumSize = new System.Drawing.Size(450, 350);
            this.Name = "Form1";
            this.Text = "Digital Clocks";
            this.flowLayoutPanel1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private global::ELTE.DigiClock.Clock digiClock1;
        private global::ELTE.DigiClock.Clock digiClock2;
        private global::ELTE.DigiClock.Clock digiClock3;
        private global::ELTE.DigiClock.Clock digiClock4;
    }
}

