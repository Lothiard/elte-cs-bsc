namespace Garden {
    class Parcel {
        class ParcelIsAlreadyInUseException : Exception { }

        private int _plantingTime;
        private PlantType? _content;

        public Parcel () {
            _plantingTime = 0;
            _content = null; // default de biztos ami biztos
        }

        public void Plant (PlantType plant, int month) {
            if (_content != null) {
                throw new ParcelIsAlreadyInUseException();
            }
            _content = plant;
            _plantingTime = month;
        }

        public bool HasRipened (int month) {
            return _content != null && _content is Vegetable && month - _plantingTime == _content.RipeningTime;
        }

        public void Harvest () {
            _content = null;
        }
    }
}
