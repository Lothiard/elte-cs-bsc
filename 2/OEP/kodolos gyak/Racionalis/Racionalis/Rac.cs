using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rational {
    public class NullDivisionException : Exception { };
    internal class Rac {
        private int _n;
        private int _d;

        public Rac (int i, int j) {
            if(j == 0) {
                throw new NullDivisionException();
            }
            _n = i;
            _d = j;
        }

        public static Rac operator + (Rac a, Rac b) {
            return new Rac(a._n * b._d + a._d * b._n, a._d * b._d);
        }

        public static Rac operator - (Rac a, Rac b) {
            return new Rac(a._n * b._d - a._d * b._n, a._d * b._d);
        }

        public static Rac operator * (Rac a, Rac b) {
            return new Rac(a._n * b._n, a._d * b._d);
        }

        public static Rac operator / (Rac a, Rac b) {
            if(b._n == 0) {
                throw new NullDivisionException();
            }
            return new Rac(a._n * b._d, a._d * b._n);
        }

        public override string ToString() {
            return $"Rac:({_n},{_d})";
        }
    }
}
