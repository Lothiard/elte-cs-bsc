using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace HF4 {
    public struct Element {
        public int pr;
        public string data;
    }
    public class QueueUnderflowException : Exception { }
    class PrQueue {
        private List<Element> seq;

        public PrQueue () {
            seq = new List<Element>();
        }

        public void SetEmpty () {
            seq.Clear();
        }

        public bool isEmpty () {
            return seq.Count == 0;
        }

        public void Add (Element e) {
            seq.Add(e);
        }

        public Element GetMax() {
            if(seq.Count == 0) {
                throw new QueueUnderflowException();
            }
            int max, ind;
            (max, ind) = MaxSelect();
            return seq[ind];
        }

        public Element RemMax () {
            if (seq.Count == 0) {
                throw new QueueUnderflowException();
            }
            int max, ind;
            (max, ind) = MaxSelect();
            Element e = seq[ind];
            pop_back(seq, ind);
            return e;
        }

        private (int,int) MaxSelect() {
            if(seq.Count == 0) {
                throw new QueueUnderflowException();
            }
            int max = seq[0].pr;
            int ind = 0;
            for(int i = 1; i < seq.Count; i++) {
                if (seq[i].pr > max) {
                    max = seq[i].pr;
                    ind = i;
                }
            }
            return (max, ind);
        }

        private void pop_back (List<Element> seq, int ind) {
            seq.RemoveAt(ind);
        }
    }
}
