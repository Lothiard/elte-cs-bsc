namespace Purchase {
    public class Product {
        private string _name;
        private int _price;

        public string Name => _name;
        public int Price => _price;

        // lehetne ugy is hogy
        // public string Name { get; }
        // public int Price { get; }
        // stilusos de akkor nincs az alahuzas ami megis egyertelmuve teszi szamunkra hogy ez a property privat

        public Product (string name, int price) {
            _name = name;
            _price = price;
        }
    }
}