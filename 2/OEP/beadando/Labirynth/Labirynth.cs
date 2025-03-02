using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HF1 {
    public class IllegalDimensionException : Exception { }
    public class IllegalMoveException : Exception { }
    public class IllegalCollect : Exception { }

    public enum Content { EMPTY, WALL, GHOST, TREASURE } // allcaps?

    public record struct Direction {
        public int x, y;
    }
    internal class Labirynth {
        private int _n;
        private int _m;
        private Content[,] _map;

        public Labirynth (Content[,] map) {
            this._n = map.GetLength(0);
            if (!(this._n >= 0)) {
                throw new IllegalDimensionException();
            }
            this._m = map.GetLength(1);
            if (!(this._m >= 0)) {
                throw new IllegalDimensionException();
            }
            this._map = map;
        }

        public Content LookAt(int x, int y, Direction dir) {
            if (x + dir.x < 0 || x + dir.x >= this._n || y + dir.y < 0 || y + dir.y >= this._m) {
                throw new IllegalMoveException();   
            }
            return this._map[x + dir.x, y + dir.y];
        }

        public void Collect (int x, int y) {
            if (this._map[x, y] != Content.TREASURE) {
                throw new IllegalCollect();
            }
            this._map[x, y] = Content.EMPTY;
        }
    }
}
