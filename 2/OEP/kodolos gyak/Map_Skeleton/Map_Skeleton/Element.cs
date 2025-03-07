using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Map_Skeleton {
    public class Element {
        public int key;
        public string data;

        public Element(int key, string data) {
            this.key = key;
            this.data = data;
        }

        public override string ToString () {
            return $"({key}:{data})";
        }
    }
}
