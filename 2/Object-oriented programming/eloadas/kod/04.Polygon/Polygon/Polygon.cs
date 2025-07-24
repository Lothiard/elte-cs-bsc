//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    class of polygons 

using System;
using TextFile;

namespace Polygon
{
    class Polygon
    {
        public class FewVerticesException : Exception { }

        private readonly Point[] vertices;

        public int Sides
        { 
            get { return vertices.Length; } 
        }

        public Point this[int i]
        {
            get { return vertices[i]; }
            set { vertices[i] = value; }
        }

        public Polygon(int m)
        {
            if (m < 3) throw new FewVerticesException();
            vertices = new Point[m];
            for (int i = 0; i < m; ++i) vertices[i] = new Point();
        }

        //Task: 	creating a polygon based on a textfile
        //Input:    ifstream inp   -  textfile
        //Output:   Polygon this   -  polygon
        //Activity: constracting a polygon and setting coordinates of its vertices
        public static Polygon Create(TextFileReader reader, int sides)
        {
            Polygon p = new (sides);
            for (int i = 0; i < sides; ++i)
            {
                reader.ReadDouble(out double x);
                reader.ReadDouble(out double y);
                p[i].SetPoint(x, y);  
            }
            return p;
        }

        //Task: 	moving a polygon
        //Input:    Polygon this   -  polygon
        //          Point mp       -  moving vector
        //Output:   Polygon this   -  polygon
        //Activity: moving of all vertices of the polygon
        public void Shift(Point e)
        {
            for (int i = 0; i < vertices.Length; ++i)
            {
                vertices[i] = vertices[i] + e;
            }
        }

        //Task: 	computing the center of a polygon polygon
        //Input:    Polygon this   -  polygon
        //Output:   Point center   -  polygon
        //Activity: computing the sum of the vertices of the polygon 
        //          and dividing it by the number of the vertices
        public Point Centroid()
        {
            Point centroid = new ();
            foreach (Point vertex in vertices)
            {
                centroid += vertex;
            }
            centroid /= Sides;
            return centroid;
        }

        //Task: 	prepearing for writing the vertices of a polygon
        //Input:    this        -  polygon
        //          string      -  polygon
        //Output:   ostream o   -  output adatfolyam
        //Activity: writing coordinates of all vertices of the polygon
        public override string ToString()
        {
            string str = "< ";
            foreach (Point vertex in vertices)
            {
                str += vertex.ToString();
            }
            str += " >";
            return str;
        }
    }
}