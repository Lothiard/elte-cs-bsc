using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PointCircle {
    internal class Point {
        private double _x;
        private double _y;

        public Point (double a, double b) {
            _x = a;
            _y = b;
        }

        public double Distance (Point p) {
            return Math.Sqrt(Math.Pow(_x - p._x, 2) + Math.Pow(_y - p._y, 2));
        }

        public override string ToString () {
            return $"Pont: X: {_x} Y: {_y}";
        }
    }
}
