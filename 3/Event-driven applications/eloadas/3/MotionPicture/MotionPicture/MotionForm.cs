using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

namespace ELTE.MotionPicture
{
    public partial class MotionForm : Form
    {
        private PictureBox[]? _pictureBoxes; // kis képek megjelenítésére
        private Image?[]? _images; // teljes képek tárolása
        private Int32 _currentIndex; // aktuális kép
        private Timer _timer; // időzítő

        public MotionForm()
        {
            InitializeComponent();

            _timer = new Timer(); // időzítő inicializálása
            _timer.Interval = 1000; // időzítő intervalluma ezredmásodpercben
            _timer.Tick += new EventHandler(Timer_Tick); // időzítő eseménykezelője
        }

        private void Timer_Tick(object? sender, EventArgs e)
        {
            if (_images != null && _images.Length > 0) // mutatott kép léptetése
                _currentIndex = (_currentIndex + 1) % _images.Length;
            else
                _currentIndex = 0;
            ReloadImages();
        }

        private void LoadButton_Click(object sender, EventArgs e)
        {
            if (_FolderBrowserDialog.ShowDialog() == DialogResult.OK) // ha OK-val zárták le a dialógusablakot
            { 
                String[] files = Directory.GetFiles(_FolderBrowserDialog.SelectedPath, "*.jpg"); 
                // könyvtár jpg kiterjesztésű fájljainak listázása

                _images = new Image[files.Length]; // a képek száma megegyezik a fájlok számával
                for (Int32 i = 0; i < files.Length; i++)
                {
                    try
                    {
                        _images[i] = Image.FromFile(files[i]); // kép betöltése
                    }
                    catch (ArgumentException) // ha a fájl nem kép
                    {
                        _images[i] = null;
                    }
                }
                _currentIndex = 0;
                _numericSmallImageCount.Value = _numericSmallImageCount.Maximum = _images.Length; // a maximális szám a képek számától függ
                ReloadPictureBoxes();
                ReloadImages();
            }
        }

        private void ReloadPictureBoxes() // kis képeket tartalmazó képmegjelenítők cseréje
        {
            if (_pictureBoxes != null)
                for (Int32 i = 0; i < _pictureBoxes.Length; i++)
                    Controls.Remove(_pictureBoxes[i]); // régi képmegjelenítők levétele

            _pictureBoxes = new PictureBox[Convert.ToInt32(_numericSmallImageCount.Value - 1)];
            for (Int32 i = 0; i < _pictureBoxes.Length; i++)
            {
                _pictureBoxes[i] = new PictureBox(); // új képmegjelenítők létrehozása
                _pictureBoxes[i].Location = new Point(2 + (i % 12) * 33, 500 + (i / 12) * 33);
                _pictureBoxes[i].Size = new Size(35, 35);
                _pictureBoxes[i].BorderStyle = BorderStyle.FixedSingle; // keret
                _pictureBoxes[i].SizeMode = PictureBoxSizeMode.StretchImage; // nyújtás

                Controls.Add(_pictureBoxes[i]); // vezérlő felvétele
            }
        }

        private void ReloadImages()  // képek újratöltése sorszámváltásnál
        {
            if (_images == null)
                return;

            _picutreBoxLarge.Image = _images[_currentIndex];
            for (Int32 i = 0; i < _pictureBoxes!.Length; i++) // a _pictureBoxes már létezik ezen a ponton
            {
                _pictureBoxes[i].Image = _images[(_currentIndex + i) % _images.Length];
            }
        }

        private void StartStopButton_Click(object sender, EventArgs e)
        {
            if (_timer.Enabled) // időzítő kapcsolása
                _timer.Stop();
            else
                _timer.Start();
        }

        private void NumericSmallImageCount_ValueChanged(object sender, EventArgs e)
        {
            _timer.Interval = Convert.ToInt32(1000 / _numericSmallImageCount.Value); // időzítő állítása
            ReloadPictureBoxes();
            ReloadImages();
        }
    }
}
