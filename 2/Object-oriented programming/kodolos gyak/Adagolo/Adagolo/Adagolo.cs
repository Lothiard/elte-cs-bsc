using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Adagolo {
    public class SzappanOverflow : Exception { };
    internal class Adagolo {
        private int _tele;
        private int _adag;
        private int _akt;

        public Adagolo(int k, int e) {
            _tele = k;
            _adag = e;
            _akt = 0;
            if(!(_akt <= _tele)) {
                throw new SzappanOverflow();
            }
        }

        private int Max (int a, int b) {
            if (a >= b) {
                return a;
            } else {
                return b;
            }
        }

        public void Nyom() {
            _akt = Max(_akt - _adag, 0);
        }

        public void Feltolt() {
            _akt = _tele;
        }
    }
}
