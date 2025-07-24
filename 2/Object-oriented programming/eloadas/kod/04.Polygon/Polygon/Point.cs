//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    class of points 

namespace Polygon
{
    class Point
    {
        public double X, Y;
        public Point(double x = 0.0, double y = 0.0)
        { 
            X = x; Y = y; 
        }
        public void SetPoint(double x, double y)
        { 
            X = x; Y = y; 
        }

        public static Point operator +(Point a, Point b)
        { 
            return new Point(a.X + b.X, a.Y + b.Y); 
        }

        public static Point operator /(Point a, double n)
        { 
            return new Point(a.X / n, a.Y / n); 
        }

        public override string ToString()
        { 
            return string.Format($"({X:0.0#},{Y:0.0#})");
        }
    }
}