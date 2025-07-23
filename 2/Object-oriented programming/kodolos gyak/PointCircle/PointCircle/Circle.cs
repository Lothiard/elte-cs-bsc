using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PointCircle {
    public class InvalidRadiusException : Exception { }
    internal class Circle {
        private Point _c;
        private double _r;

        public Circle (Point p, double a) {
            if(a < 0) {
                throw new InvalidRadiusException();
            }
            _c = p;
            _r = a;
        }

        public bool Contains (Point p) {
            return _c.Distance(p) <= _r;
        }

        public override string ToString () {
            return $"Kör:\nKözéppont: {_c}\nSugár: {_r}";
        }
    }
}
