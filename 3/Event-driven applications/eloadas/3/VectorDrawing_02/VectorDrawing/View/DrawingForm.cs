using System;
using System.Drawing;
using System.Windows.Forms;
using ELTE.VectorDrawing.Model;

namespace ELTE.VectorDrawing.View
{
    /// <summary>
    /// Rajzoló ablak típusa.
    /// </summary>
    public partial class DrawingForm : Form
    {
        private VectorImage _image; // vektoros kép
        private Point _startPoint; // egér hezdőpozíciója a rajzoláshoz
        
        /// <summary>
        /// Rajzoló ablak példányosítása.
        /// </summary>
        public DrawingForm()
        {
            InitializeComponent();

            // panel egérkezelő eseményei
            _panel.MouseDown += new MouseEventHandler(Panel_MouseDown); // egér lenyomása
            _panel.MouseUp += new MouseEventHandler(Panel_MouseUp); // egér felengedése
            _panel.MouseMove += new MouseEventHandler(Panel_MouseMove); // egér mozgatása

            // ablak billentyűkezelése
            KeyPreview = true; // az ablak is megkapja a billentyűeseményt
            KeyDown += new KeyEventHandler(DrawingForm_KeyDown); // billentyű lenyomása

            _image = new VectorImage();
            _image.ImageChanged += new EventHandler(Image_ImageChanged);
        }

        /// <summary>
        /// Kép betöltésének eseménykezelője.
        /// </summary>
        private void MenuImageLoad_Click(object? sender, EventArgs e)
        {
            _openFileDialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyPictures);
            // kezdő könyvtár beállítása a felahsználó képek könyvtárára

            if (_openFileDialog.ShowDialog() == DialogResult.OK) // ha OK-val zárták be az ablakot
            {
                _image.ImageChanged -= Image_ImageChanged; // az eseménykezelés társítást megszűntetjük

                // létrehozzuk az új képet a fájlból
                _image = new VectorImage(_openFileDialog.FileName);
                _image.ImageChanged += new EventHandler(Image_ImageChanged);

                _panel.Refresh();
            }
        }
        /// <summary>
        /// Kép mentésének eseménykezelője.
        /// </summary>
        private void MenuImageSave_Click(object? sender, EventArgs e)
        {
            _saveFileDialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyPictures);

            if (_saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                _image.Save(_saveFileDialog.FileName); // kép mentése
            }
        }
        /// <summary>
        /// Kép törlésének eseménykezelője.
        /// </summary>
        private void MenuImageClear_Click(object? sender, EventArgs e)
        {
            _image.Clear();
        }
        /// <summary>
        /// Kép törlésének eseménykezelője.
        /// </summary>
        private void ButtonClear_Click(object? sender, EventArgs e)
        {
            _image.Clear();
        }
        /// <summary>
        /// Panel frissítésének eseménykezelője.
        /// </summary>
        private void Panel_Paint(object? sender, PaintEventArgs e)
        {
            Bitmap bitmap = new Bitmap(_panel.Width, _panel.Height); // kép létrehozása

            Graphics graphics = Graphics.FromImage(bitmap); // rajzeszköz a képre
            graphics.Clear(SystemColors.Control); // a vezérlő színére festjük a képet

            foreach (Shape shape in _image.Shapes)
                DrawShape(graphics, shape); // alakzatok kirajzolása

            e.Graphics.DrawImage(bitmap, 0, 0); // kép kirajzolása a panelre
        }

        /// <summary>
        /// Panel egérmozgatásának eseménykezelője.
        /// </summary>
        private void Panel_MouseMove(object? sender, MouseEventArgs e)
        {
            if (e.Button != MouseButtons.None) // ha van valamilyen egérgomb lenyomva
            {
                Bitmap bitmap = new Bitmap(_panel.Width, _panel.Height); // kép létrehozása

                Graphics graphics = Graphics.FromImage(bitmap); // rajzeszköz a képre
                graphics.Clear(SystemColors.Control); // a vezérlő színére festjük a képet

                foreach (Shape shape in _image.Shapes)
                    DrawShape(graphics, shape); // alakzatok kirajzolása

                // kirajzoljuk az aktuálisan húzott elemet
                Pen pen = new Pen(Color.Blue, 2);
                if (_radioRectangle.Checked)
                {
                    DrawShape(graphics, ShapeType.Rectangle, 
                              _startPoint.X < e.X ? _startPoint.X : e.X, // azt vesszük figyelembe, ami balra van
                              _startPoint.Y < e.Y ? _startPoint.Y : e.Y, 
                              Math.Abs(e.X - _startPoint.X), // a méretnél abszolútértéket veszünk
                              Math.Abs(e.Y - _startPoint.Y));
                }
                else if (_radioEllipse.Checked)
                {
                    DrawShape(graphics, ShapeType.Ellipse,
                              _startPoint.X < e.X ? _startPoint.X : e.X,
                              _startPoint.Y < e.Y ? _startPoint.Y : e.Y,
                              Math.Abs(e.X - _startPoint.X), 
                              Math.Abs(e.Y - _startPoint.Y));
                }
                else
                {
                    DrawShape(graphics, ShapeType.Triangle,
                              _startPoint.X < e.X ? _startPoint.X : e.X,
                              _startPoint.Y < e.Y ? _startPoint.Y : e.Y,
                              Math.Abs(e.X - _startPoint.X),
                              Math.Abs(e.Y - _startPoint.Y));
                }

                _panel.CreateGraphics().DrawImage(bitmap, 0, 0); // kép kirajzolása a panelre
            }
        }

        /// <summary>
        /// Panel egérfelengedésének eseménykezelője.
        /// </summary>
        private void Panel_MouseUp(object? sender, MouseEventArgs e)
        {
            // egérfelengedésre hozzávesszük az új alakzatot
            if (_radioRectangle.Checked)
            {
                _image.AddShape(ShapeType.Rectangle, _startPoint.X < e.X ? _startPoint.X : e.X, _startPoint.Y < e.Y ? _startPoint.Y : e.Y, Math.Abs(e.X - _startPoint.X), Math.Abs(e.Y - _startPoint.Y));
            }
            else if (_radioEllipse.Checked)
            {
                _image.AddShape(ShapeType.Ellipse, _startPoint.X < e.X ? _startPoint.X : e.X, _startPoint.Y < e.Y ? _startPoint.Y : e.Y, Math.Abs(e.X - _startPoint.X), Math.Abs(e.Y - _startPoint.Y));
            }
           else
            {
                _image.AddShape(ShapeType.Triangle, _startPoint.X < e.X ? _startPoint.X : e.X, _startPoint.Y < e.Y ? _startPoint.Y : e.Y, Math.Abs(e.X - _startPoint.X), Math.Abs(e.Y - _startPoint.Y));
            }
        }

        /// <summary>
        /// Panel egérlenyomásának eseménykezelője.
        /// </summary>
        private void Panel_MouseDown(object? sender, MouseEventArgs e)
        {
            // egér lenyomásra eltároljuk a kezdőpozíciót
            _startPoint = e.Location;
        }

        /// <summary>
        /// Billentyűlenyomás eseménykezelője.
        /// </summary>
        private void DrawingForm_KeyDown(object? sender, KeyEventArgs e)
        {
            // a billenytűzetről csak a Delete billentyűt kezeljük
            if (e.KeyCode == Keys.Delete)
            {
                _image.Clear();
            }
        }

        /// <summary>
        /// Kép megváltozásának eseménykezelője.
        /// </summary>
        private void Image_ImageChanged(object? sender, EventArgs e)
        {
            _panel.Refresh();
        }

        /// <summary>
        /// Alakzat kirajzolása.
        /// </summary>
        private void DrawShape(Graphics graphics, Shape shape)
        {
            switch (shape.Type)
            { 
                case ShapeType.Rectangle:
                    graphics.FillRectangle(Brushes.LightGreen, shape.StartX, shape.StartY, shape.Width, shape.Height); // kitöltés
                    graphics.DrawRectangle(Pens.Green, shape.StartX, shape.StartY, shape.Width, shape.Height); // keret
                    break;
                case ShapeType.Ellipse:
                    graphics.FillEllipse(Brushes.Red, shape.StartX, shape.StartY, shape.Width, shape.Height);
                    graphics.DrawEllipse(Pens.DarkRed, shape.StartX, shape.StartY, shape.Width, shape.Height);
                    break;
                case ShapeType.Triangle:
                    Point[] points = new Point[3]; // a háromszöget poligonként rajzoljuk, pontok segítségével
                    points[0] = new Point(shape.StartX + shape.Width / 2, shape.StartY);
                    points[1] = new Point(shape.StartX, shape.StartY + shape.Height);
                    points[2] = new Point(shape.StartX + shape.Width, shape.StartY + shape.Height);

                    graphics.FillPolygon(Brushes.Yellow, points); // kitöltés
                    graphics.DrawPolygon(Pens.Orange, points); 
                    break;
            }
        }

        /// <summary>
        /// Alakzat kirajzolása.
        /// </summary>
        private void DrawShape(Graphics graphics, ShapeType type, Int32 startX, Int32 startY, Int32 width, Int32 height)
        {
            Pen pen = new Pen(Color.Blue, 2); // 2 vastag, szaggatott, kék toll
            pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dash;

            switch (type)
            {
                case ShapeType.Rectangle:
                    graphics.DrawRectangle(pen, startX, startY, width, height); // keret
                    break;
                case ShapeType.Ellipse:
                    graphics.DrawEllipse(pen, startX, startY, width, height);
                    break;
                case ShapeType.Triangle:
                    Point[] points = new Point[3]; // a háromszöget poligonként rajzoljuk, pontok segítségével
                    points[0] = new Point(startX + width / 2, startY);
                    points[1] = new Point(startX, startY + height);
                    points[2] = new Point(startX + width, startY + height);

                    graphics.DrawPolygon(pen, points);
                    break;
            }
        }
        
    }
}
