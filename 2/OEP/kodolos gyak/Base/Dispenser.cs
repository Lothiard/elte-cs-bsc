using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Base {
    public class IllegalSizeException : Exception { }
    internal class Dispenser {
        private double _max;
        private double _dosee;
        private double _act;

        public Dispenser (double a, double b) {
            if (!(a > 0 && b > 0)) {
                throw new IllegalSizeException();
            }
            _max = a;
            _dosee = b;
            _act = 0.0;
        }

        public void Push () {
            _act = Math.Max(_act - _dosee, 0.0);
        }

        public void Fill () {
            _act = _max;
        }

        public bool IsEmpty () { // Az osztalydiagram el van irva ugyanis Empty()-t kerne viszont a Program.cs IsEmpty()-t hiv meg.
            return _act == 0;
        }
    }
}
