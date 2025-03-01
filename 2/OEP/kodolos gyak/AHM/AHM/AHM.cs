using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;

namespace AHM {
    public class AHM { 
        public class ReferenceToNullPartException : Exception { }
        public class DifferentSizeException : Exception { }

        private readonly double[] _x;
        private readonly int _dim;

        public AHM (int m) {
            if(m < 1) {
                throw new ArgumentOutOfRangeException();
            }
            _dim = m;
            _x = new double[m * (m+1) / 2];
        }

        public double Get(int i, int j) {
            if(i < 1 || i > _dim || j < 1 || j > _dim) {
                throw new ReferenceToNullPartException();
            }
            if(i >= j) {
                return _x[Ind(i, j)];
            } else {
                return 0.0;
            }
        }

        public void Set(int i, int j, double e) {
            if(i < 1 || i > _dim || j < 1 || j > _dim) {
                throw new ReferenceToNullPartException();
            }
            if (i >= j) {
                _x[Ind(i, j)] = e;
                return;
            } else {
                throw new ReferenceToNullPartException();
            }
        }

        public static AHM Add (AHM a, AHM b) {
            if (a._dim != b._dim) {
                throw new DifferentSizeException();
            }
            AHM c = new AHM(a._dim);
            for (int i = 1; i < c._x.Length; i++) {
                c._x[i] = a._x[i] + b._x[i];
            }
            return c;
        }

        public static AHM Mul(AHM a, AHM b) {
            if (a._dim != b._dim) {
                throw new DifferentSizeException();
            }
            AHM c = new AHM(a._dim);
            for (int i = 1; i < c._dim; i++) {
                for (int j = 1; j < i; j++) {
                    c._x[Ind(i, j)] = 0.0;
                    for (int k = j; k < i; k++) {
                        c._x[Ind(i, j)] += a._x[Ind(i, k)] * b._x[Ind(k, j)];
                    }
                }
            }
            return c;
        }

        public double this[int i, int j] { 
            get { return Get(i, j); }
            set { Set(i, j, value); }
        }

        private static int Ind(int i, int j) {
            return j - 1 + i * (i + 1) / 2; // -1?
        }

        public static AHM operator + (AHM a, AHM b) {
            return Add(a, b);
        }

        public static AHM operator * (AHM a, AHM b) {
            return Mul(a, b);
        }

        public override string ToString () {
            string str = "";

            for (int i = 1; i <= _dim; i++) {
                for (int j = 0; j <= _dim; j++) {
                    str += this[i, j] + '\t';
                }
                str += '\n';
            }
            return str;
        }
    }
}
