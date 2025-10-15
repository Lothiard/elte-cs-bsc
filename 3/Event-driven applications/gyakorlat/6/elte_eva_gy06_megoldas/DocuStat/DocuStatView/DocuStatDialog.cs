using ELTE.DocuStat.Persistence;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ELTE.DocuStat.View
{
    public partial class DocuStatDialog : Form
    {
        public DocuStatDialog()
        {
            InitializeComponent();

            openFileDialogMenuItem.Click += OpenDialog;
            countWordsMenuItem.Click += CalculateStatistics;
        }

        private async void OpenDialog(object? sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.InitialDirectory = "C:\\";
                openFileDialog.Filter = "Text files (*.txt)|*.txt|PDF files (*.pdf)|*.pdf";
                openFileDialog.RestoreDirectory = true;
                openFileDialog.Multiselect = true;

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    countWordsMenuItem.Enabled = false;
                    openFileDialogMenuItem.Enabled = false;
                    tabControl.TabPages.Clear();

                    List<Task> tasks = new List<Task>();
                    foreach (string fileName in openFileDialog.FileNames)
                    {
                        tasks.Add(AddTabPageAsync(fileName));
                    }
                    await Task.WhenAll(tasks);

                    // A Windows Forms alapértelmezett szinkronizációs kontextusának köszönhetõen
                    // garantáltan a UI szálon folytatódik a végrehajtás.
                    countWordsMenuItem.Enabled = true;
                    openFileDialogMenuItem.Enabled = true;
                }
            }
        }

        private async Task AddTabPageAsync(string fileName)
        {
            IFileManager? fileManager = FileManagerFactory.CreateForPath(fileName);
            if (fileManager == null)
            {
                MessageBox.Show("File reading is unsuccessful!\nUnsupported file format.",
                "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                DocuStatControl control = new DocuStatControl();
                Task loadTask = control.LoadFileAsync(fileManager);
                TabPage tabPage = new TabPage("Loading...");
                tabPage.Controls.Add(control);
                tabControl.TabPages.Add(tabPage);

                await loadTask;
                // A Windows Forms alapértelmezett szinkronizációs kontextusának köszönhetõen
                // garantáltan a UI szálon folytatódik a végrehajtás.

                tabPage.Text = Path.GetFileName(fileName);
            }
            catch (FileManagerException ex)
            {
                Invoke(() => MessageBox.Show("File reading is unsuccessful!\n" + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error));
                return;
            }

        }

        private void CalculateStatistics(object? sender, EventArgs e)
        {
            if (tabControl.SelectedTab == null)
            {
                MessageBox.Show("No tabpage is selected!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            (tabControl.SelectedTab.Controls[0] as DocuStatControl)!.CalculateStatistics();
        }
    }
}