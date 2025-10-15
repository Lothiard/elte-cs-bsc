using System;
using System.Windows.Forms;

namespace ELTE.DocuStat.View
{
    partial class DocuStatDialog
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
            menuStrip1 = new MenuStrip();
            fileMenu = new ToolStripMenuItem();
            openFileDialogMenuItem = new ToolStripMenuItem();
            countWordsMenuItem = new ToolStripMenuItem();
            textBox = new TextBox();
            listBoxCounter = new ListBox();
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            labelCharacters = new Label();
            labelProperNouns = new Label();
            labelColemanLieuIndex = new Label();
            labelFleschReadingEase = new Label();
            spinBoxMinLength = new NumericUpDown();
            spinBoxMinOccurrence = new NumericUpDown();
            textBoxIgnoredWords = new TextBox();
            labelNonWhitespaceCharacters = new Label();
            labelSentences = new Label();
            menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)spinBoxMinLength).BeginInit();
            ((System.ComponentModel.ISupportInitialize)spinBoxMinOccurrence).BeginInit();
            SuspendLayout();
            // 
            // menuStrip1
            // 
            menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            menuStrip1.Items.AddRange(new ToolStripItem[] { fileMenu });
            menuStrip1.Location = new System.Drawing.Point(0, 0);
            menuStrip1.Name = "menuStrip1";
            menuStrip1.Padding = new Padding(7, 3, 0, 3);
            menuStrip1.Size = new System.Drawing.Size(914, 30);
            menuStrip1.TabIndex = 0;
            menuStrip1.Text = "menuStrip1";
            // 
            // fileMenu
            // 
            fileMenu.DropDownItems.AddRange(new ToolStripItem[] { openFileDialogMenuItem, countWordsMenuItem });
            fileMenu.Name = "fileMenu";
            fileMenu.Size = new System.Drawing.Size(46, 24);
            fileMenu.Text = "File";
            // 
            // openFileDialogMenuItem
            // 
            openFileDialogMenuItem.Name = "openFileDialogMenuItem";
            openFileDialogMenuItem.Size = new System.Drawing.Size(200, 26);
            openFileDialogMenuItem.Text = "Open file dialog";
            // 
            // countWordsMenuItem
            // 
            countWordsMenuItem.Name = "countWordsMenuItem";
            countWordsMenuItem.Size = new System.Drawing.Size(200, 26);
            countWordsMenuItem.Text = "Count words";
            // 
            // textBox
            // 
            textBox.Location = new System.Drawing.Point(14, 36);
            textBox.Margin = new Padding(3, 4, 3, 4);
            textBox.Multiline = true;
            textBox.Name = "textBox";
            textBox.ReadOnly = true;
            textBox.ScrollBars = ScrollBars.Vertical;
            textBox.Size = new System.Drawing.Size(444, 384);
            textBox.TabIndex = 1;
            // 
            // listBoxCounter
            // 
            listBoxCounter.FormattingEnabled = true;
            listBoxCounter.ItemHeight = 20;
            listBoxCounter.Location = new System.Drawing.Point(465, 36);
            listBoxCounter.Margin = new Padding(3, 4, 3, 4);
            listBoxCounter.Name = "listBoxCounter";
            listBoxCounter.Size = new System.Drawing.Size(435, 384);
            listBoxCounter.TabIndex = 2;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new System.Drawing.Point(517, 440);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(159, 20);
            label1.TabIndex = 3;
            label1.Text = "Minimum word length:";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new System.Drawing.Point(517, 492);
            label2.Name = "label2";
            label2.Size = new System.Drawing.Size(189, 20);
            label2.TabIndex = 4;
            label2.Text = "Minimum word occurrence:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new System.Drawing.Point(517, 544);
            label3.Name = "label3";
            label3.Size = new System.Drawing.Size(108, 20);
            label3.TabIndex = 5;
            label3.Text = "Ignored words:";
            // 
            // labelCharacters
            // 
            labelCharacters.AutoSize = true;
            labelCharacters.Location = new System.Drawing.Point(14, 440);
            labelCharacters.Name = "labelCharacters";
            labelCharacters.Size = new System.Drawing.Size(116, 20);
            labelCharacters.TabIndex = 6;
            labelCharacters.Text = "Character count:";
            // 
            // labelProperNouns
            // 
            labelProperNouns.AutoSize = true;
            labelProperNouns.Location = new System.Drawing.Point(257, 440);
            labelProperNouns.Name = "labelProperNouns";
            labelProperNouns.Size = new System.Drawing.Size(134, 20);
            labelProperNouns.TabIndex = 7;
            labelProperNouns.Text = "Proper noun count:";
            // 
            // labelColemanLieuIndex
            // 
            labelColemanLieuIndex.AutoSize = true;
            labelColemanLieuIndex.Location = new System.Drawing.Point(257, 492);
            labelColemanLieuIndex.Name = "labelColemanLieuIndex";
            labelColemanLieuIndex.Size = new System.Drawing.Size(142, 20);
            labelColemanLieuIndex.TabIndex = 8;
            labelColemanLieuIndex.Text = "Coleman Lieu Index:";
            // 
            // labelFleschReadingEase
            // 
            labelFleschReadingEase.AutoSize = true;
            labelFleschReadingEase.Location = new System.Drawing.Point(257, 544);
            labelFleschReadingEase.Name = "labelFleschReadingEase";
            labelFleschReadingEase.Size = new System.Drawing.Size(145, 20);
            labelFleschReadingEase.TabIndex = 9;
            labelFleschReadingEase.Text = "Flesch Reading Ease:";
            // 
            // spinBoxMinLength
            // 
            spinBoxMinLength.Location = new System.Drawing.Point(710, 437);
            spinBoxMinLength.Margin = new Padding(3, 4, 3, 4);
            spinBoxMinLength.Minimum = new decimal(new int[] { 1, 0, 0, 0 });
            spinBoxMinLength.Name = "spinBoxMinLength";
            spinBoxMinLength.Size = new System.Drawing.Size(137, 27);
            spinBoxMinLength.TabIndex = 10;
            spinBoxMinLength.Value = new decimal(new int[] { 1, 0, 0, 0 });
            // 
            // spinBoxMinOccurrence
            // 
            spinBoxMinOccurrence.Location = new System.Drawing.Point(710, 489);
            spinBoxMinOccurrence.Margin = new Padding(3, 4, 3, 4);
            spinBoxMinOccurrence.Maximum = new decimal(new int[] { 500, 0, 0, 0 });
            spinBoxMinOccurrence.Minimum = new decimal(new int[] { 1, 0, 0, 0 });
            spinBoxMinOccurrence.Name = "spinBoxMinOccurrence";
            spinBoxMinOccurrence.Size = new System.Drawing.Size(137, 27);
            spinBoxMinOccurrence.TabIndex = 11;
            spinBoxMinOccurrence.Value = new decimal(new int[] { 1, 0, 0, 0 });
            // 
            // textBoxIgnoredWords
            // 
            textBoxIgnoredWords.Location = new System.Drawing.Point(625, 540);
            textBoxIgnoredWords.Margin = new Padding(3, 4, 3, 4);
            textBoxIgnoredWords.Name = "textBoxIgnoredWords";
            textBoxIgnoredWords.Size = new System.Drawing.Size(222, 27);
            textBoxIgnoredWords.TabIndex = 12;
            // 
            // labelNonWhitespaceCharacters
            // 
            labelNonWhitespaceCharacters.AutoSize = true;
            labelNonWhitespaceCharacters.Location = new System.Drawing.Point(14, 492);
            labelNonWhitespaceCharacters.Name = "labelNonWhitespaceCharacters";
            labelNonWhitespaceCharacters.Size = new System.Drawing.Size(191, 20);
            labelNonWhitespaceCharacters.TabIndex = 13;
            labelNonWhitespaceCharacters.Text = "Non-whitespace characters:";
            // 
            // labelSentences
            // 
            labelSentences.AutoSize = true;
            labelSentences.Location = new System.Drawing.Point(14, 544);
            labelSentences.Name = "labelSentences";
            labelSentences.Size = new System.Drawing.Size(113, 20);
            labelSentences.TabIndex = 14;
            labelSentences.Text = "Sentence count:";
            // 
            // DocuStatDialog
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(914, 600);
            Controls.Add(labelSentences);
            Controls.Add(labelNonWhitespaceCharacters);
            Controls.Add(textBoxIgnoredWords);
            Controls.Add(spinBoxMinOccurrence);
            Controls.Add(spinBoxMinLength);
            Controls.Add(labelFleschReadingEase);
            Controls.Add(labelColemanLieuIndex);
            Controls.Add(labelProperNouns);
            Controls.Add(labelCharacters);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(listBoxCounter);
            Controls.Add(textBox);
            Controls.Add(menuStrip1);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MainMenuStrip = menuStrip1;
            Margin = new Padding(3, 4, 3, 4);
            MaximizeBox = false;
            Name = "DocuStatDialog";
            Text = "Document statistics";
            menuStrip1.ResumeLayout(false);
            menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)spinBoxMinLength).EndInit();
            ((System.ComponentModel.ISupportInitialize)spinBoxMinOccurrence).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private MenuStrip menuStrip1;
        private ToolStripMenuItem fileMenu;
        private ToolStripMenuItem openFileDialogMenuItem;
        private ToolStripMenuItem countWordsMenuItem;
        private TextBox textBox;
        private ListBox listBoxCounter;
        private Label label1;
        private Label label2;
        private Label label3;
        private Label labelCharacters;
        private Label labelProperNouns;
        private Label labelColemanLieuIndex;
        private Label labelFleschReadingEase;
        private NumericUpDown spinBoxMinLength;
        private NumericUpDown spinBoxMinOccurrence;
        private TextBox textBoxIgnoredWords;
        private Label labelNonWhitespaceCharacters;
        private Label labelSentences;
    }
}