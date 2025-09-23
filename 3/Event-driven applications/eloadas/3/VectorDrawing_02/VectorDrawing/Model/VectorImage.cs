using System;
using System.Collections.Generic;
using System.IO;

namespace ELTE.VectorDrawing.Model
{
    /// <summary>
    /// Vektoros kép típusa.
    /// </summary>
    public class VectorImage
    {
        private List<Shape> _shapeList;

        /// <summary>
        /// Alakzatok listájának lekrédezése.
        /// </summary>
        public IList<Shape> Shapes 
        { 
            get 
            { 
                return _shapeList.AsReadOnly(); 
                // egy csak olvasható listát adunk vissza
            } 
        }

        /// <summary>
        /// Kép változásának eseménye.
        /// </summary>
        public event EventHandler? ImageChanged;

        /// <summary>
        /// Vektoros kép létrehozása.
        /// </summary>
        public VectorImage()
        {
            _shapeList = new List<Shape>();
        }
        /// <summary>
        /// Vektoros kép létrehozása.
        /// </summary>
        /// <param name="fileName">Fájlnév.</param>
        public VectorImage(String fileName) 
        {
            _shapeList = new List<Shape>();
            Load(fileName);
        }

        /// <summary>
        /// Új alakzat hozzáadása.
        /// </summary>
        /// <param name="type">Alakzat típusa.</param>
        /// <param name="startX">Alakzat vízszintes pozíciója.</param>
        /// <param name="startY">Alakzat függőleges pozíciója.</param>
        /// <param name="width">Alakzat szélessége.</param>
        /// <param name="height">Alakzat magassága.</param>
        public void AddShape(ShapeType type, Int32 startX, Int32 startY, Int32 width, Int32 height) 
        { 
            _shapeList.Add(new Shape(type, startX, startY, width, height));
            OnImageChanged();
        }

        /// <summary>
        /// Alakzatok törlése.
        /// </summary>
        public void Clear()
        {
            _shapeList.Clear();
            OnImageChanged();
        }

        /// <summary>
        /// Kép mentése.
        /// </summary>
        /// <param name="fileName">Fájlnév.</param>
        public void Save(String fileName) 
        {
            if (fileName == null)
                throw new ArgumentNullException(nameof(fileName), "The file name is null.");

            try
            {
                StreamWriter writer = new StreamWriter(fileName);
                foreach (Shape shape in _shapeList)
                {
                    writer.WriteLine((Int32)shape.Type + " " + shape.StartX + " " + shape.StartY + " " + shape.Width + " " + shape.Height);
                }
                writer.Close();
            }
            catch
            {
                throw new ArgumentException("Cannot save image to the specified file name.", nameof(fileName));
            }
        }

        /// <summary>
        /// Kép betöltése.
        /// </summary>
        /// <param name="fileName">Fájlnév.</param>
        private void Load(String fileName) 
        {
            if (fileName == null)
                throw new ArgumentNullException(nameof(fileName), "The file name is null.");

            try
            {
                StreamReader reader = new StreamReader(fileName);
                while (!reader.EndOfStream)
                {
                    String[] line = (reader.ReadLine() ?? String.Empty).Split(' ');
                    _shapeList.Add(new Shape((ShapeType)Int32.Parse(line[0]), Int32.Parse(line[1]), Int32.Parse(line[2]), Int32.Parse(line[3]), Int32.Parse(line[4])));
                }
                reader.Close();
            }
            catch
            {
                throw new ArgumentException("Cannot load image from the specified file name.", nameof(fileName));
            }
        }

        /// <summary>
        /// Kép változásának eseménykiváltása.
        /// </summary>
        private void OnImageChanged()
        {
            if (ImageChanged != null)
                ImageChanged(this, EventArgs.Empty);
        }
    }
}
