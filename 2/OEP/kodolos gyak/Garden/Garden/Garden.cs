namespace Garden {
    class Garden {
        private readonly List<Parcel> _parcels;

        public Parcel this[int i] {
            get {
                if (i <= 0 || i >= _parcels.Count) { throw new ArgumentOutOfRangeException("Invalid number of parcels"); }
                return _parcels[i];
            }
        }

        public Garden (int n) {
            if (n <= 0) { throw new ArgumentException("Number of parcels must be at least 1"); }
            _parcels = new List<Parcel>();
            for (int i = 0; i < n; ++i) {
                _parcels.Add(new Parcel());
            }
        }

        public void Plant(int where, PlantType what, int month) {
            _parcels[where].Plant(what, month);
        }

        public void Harvest(int where) {
            _parcels[where - 1].Harvest();
        }

        public List<int> HarvestableParcels (int month) {
            List<int> harvestableParcelIndexes = new List<int>();
            for (int i = 0; i < _parcels.Count; ++i) {
                if (_parcels[i].HasRipened(month)) {
                    harvestableParcelIndexes.Add(i + 1);
                }
            }
            return harvestableParcelIndexes;
        }
    }
}
