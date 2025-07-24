using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Fuzet {
    class Fuzet {

        public class IllegalPageNumberException : Exception { };
        public class PageAlreadyFilledException : Exception { };

        public enum Tipus { sima, negyzetracs, vonal }

        private Tipus _tipus;
        private List<string> _lapok;
        private int _uresdb;

        public Fuzet (int n, Tipus tip) {
            _lapok = new List<string>(n);
            for(int i = 0; i < n; ++i) {
                _lapok.Add("");
            }
            _tipus = tip;
            _uresdb = n;
        }

        public int LapDB() => _lapok.Count;

        public int UresDB() => _uresdb;

        public void Rair(int ind, string tart) {
            --ind;
            if (ind < 0 || ind > _lapok.Count) {
                throw new IllegalPageNumberException();
            }
            if (_lapok[ind] != "") {
                throw new PageAlreadyFilledException();
            }
            _lapok[ind] = tart;
            --_uresdb;
        }

        public void Kitep(int ind) {
            --ind;
            if (ind < 0 || ind > _lapok.Count) {
                throw new IllegalPageNumberException();
            }
            if (_lapok[ind] == "") {
                --_uresdb;
            }
            _lapok.RemoveAt(ind);
        }

        public bool Keres(out int ind) {
            ind = 0;
            for (int i = 0; i < _lapok.Count; ++i) {
                string lap = _lapok[i];
                if(lap == "") {
                    ind = i;
                    return true;
                }
            }

            return false;
        } 
    }
}
