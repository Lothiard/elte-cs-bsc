using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace HF3 {
    public class IllegalSizeException : Exception { }
    public class IndexOutOfRangeException : Exception { }
    public class IllegalIndexException : Exception { }

    class Diag {
        private double[] _x;
        public Diag (int n) {
            if (n < 1) { 
                throw new IllegalSizeException();
            }
            _x = new double[n];
        }

        public double Get (int i, int j) {
            if (i < 1 || i > _x.Length || j < 1 || j > _x.Length) {
                throw new IndexOutOfRangeException();
            }
            if (i == j) {
                return _x[i];
            } else {
                return 0.0;
            }
        }

        public void Set (int i, int j, double e) {
            if (i < 1 || i > _x.Length || j < 1 || j > _x.Length) {
                throw new IndexOutOfRangeException();
            }
            if (i == j) {
                this._x[i] = e;
            } else {
                throw new IllegalIndexException();
            }
        }

        public static Diag Add (Diag a, Diag b) {
            if(a._x.Length != b._x.Length) {
                throw new IllegalSizeException();
            }
            Diag c = new Diag(a._x.Length);
            for (int i = 1; i <= c._x.Length; ++i) {
                c._x[i - 1] = a._x[i - 1] + b._x[i - 1];
            }
            return c;
        }

        public static Diag Multiply (Diag a, Diag b) { // a diagrammon Mul
            if (a._x.Length != b._x.Length) {
                throw new IllegalSizeException();
            }
            Diag c = new Diag(a._x.Length);
            for (int i = 1; i <= c._x.Length; ++i) {
                c._x[i] = a._x[i] * b._x[i];
            }
            return c;
        }

        public static Diag operator + (Diag a, Diag b) {
            return Add(a, b);
        }

        public static Diag operator * (Diag a, Diag b) {
            return Multiply(a, b);
        }

    }
}
