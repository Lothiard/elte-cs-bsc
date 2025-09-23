using System;

namespace ELTE.VectorDrawing.Model
{
    /// <summary>
    /// Vektoros alakzatfajta felsorolási típusa.
    /// </summary>
    public enum ShapeType { Rectangle, Ellipse, Triangle }

    /// <summary>
    /// Vektoros alakzat típusa.
    /// </summary>
    public class Shape
    {
        /// <summary>
        /// Típus lekérdezése.
        /// </summary>
        public ShapeType Type { get; private set; } // automatikus tulajdonság, a mező generálódik
        /// <summary>
        /// Vízszintes kezdőpozíció lekérdezése.
        /// </summary>
        public Int32 StartX { get; private set; }
        /// <summary>
        /// Függőleges kezdőpozíció lekérdezése.
        /// </summary>
        public Int32 StartY { get; private set; }
        /// <summary>
        /// Szélesség lekérdezése.
        /// </summary>
        public Int32 Width { get; private set; }
        /// <summary>
        /// Magasság lekérdezése.
        /// </summary>
        public Int32 Height { get; private set; }

        /// <summary>
        /// Vektoros alakzat példányosítása.
        /// </summary>
        /// <param name="type">Alakzat típusa.</param>
        /// <param name="startX">Alakzat vízszintes pozíciója.</param>
        /// <param name="startY">Alakzat függőleges pozíciója.</param>
        /// <param name="width">Alakzat szélessége.</param>
        /// <param name="height">Alakzat magassága.</param>
        public Shape(ShapeType type, Int32 startX, Int32 startY, Int32 width, Int32 height)
        {
            Type = type;
            StartX = startX;
            StartY = startY;
            Width = width;
            Height = height;
        }
    }
}
